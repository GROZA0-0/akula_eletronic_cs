import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';

import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';

class ShowCustomerDisplayController {
  static WindowController? customerwindowController;
  static int? get targetWindowsId => customerwindowController?.windowId;
  static bool isSubWindowReady = false;
  static List<CartEntities> latestCartItems = [];
  static double latestTotal = 0.0;

  static Future<void> openCustomerDisplay() async {
    final display = await screenRetriever.getAllDisplays();
    final targetDisplay = display.length > 1 ? display[1] : display.first;
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      if (call.method == 'customer_display') {
        isSubWindowReady = true;
        // Auto-send latest cart data as soon as sub-window registers its handler(primary window)
        if (latestCartItems.isNotEmpty) {
          await updateCart(latestCartItems, latestTotal);
        }

        return 'ok';
      }
      return null;
    });
    final windowController = await DesktopMultiWindow.createWindow(
      jsonEncode({'type': 'customer_display'}),
    );
    customerwindowController = windowController;
    final Offset origin =
        targetDisplay.visiblePosition ??
        targetDisplay.visibleSize!.topLeft(Offset.zero);
    final Size size = targetDisplay.size;
    final Rect windowRect = Rect.fromLTWH(
      origin.dx,
      origin.dy,
      size.width,
      size.height,
    );

    await windowController.setFrame(windowRect);
    await windowController.setTitle('Customer Display');
    await windowController.show();
  }

  static Future<void> updateCart(
    List<CartEntities> cartItems,
    double total,
  ) async {
    try {
      if (customerwindowController == null) {
        // print('Customer display not open, skipping update');
        return;
      }
      final data = {
        'totalPrice': total,
        'items': cartItems.map((e) => e.toJson()).toList(),
      };
      final payload = jsonEncode(data);
      await DesktopMultiWindow.invokeMethod(
        customerwindowController!.windowId,
        'customer_display',
        payload,
      );
    } catch (e) {
      print('updateCart failed: $e');
    }
  }
}

/* 
////////////////////////////////////////////
//////////////[Customer Screen Notes]///////
////////////////////////////////////////////

We used Map<String,dynamic> in the widget,
cuz it's separate window (engine) , so when passed into the setHandler
that inside the controller, it will read the keys from the entities/models

                         toJson()          invokeMethod
CartEntities(Dart object) ======> Map/Json ===========>  sub-window engine
------------------------------------
To make the two windows run , we have to call setMethodHandler in controller
and the widget
 */
