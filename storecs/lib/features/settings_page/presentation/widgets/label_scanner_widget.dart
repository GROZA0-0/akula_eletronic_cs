import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class LabelScannerWidget extends StatefulWidget {
  /* let upstream widgets receive the scanned barcode data */
  final Function(String barcode)? onBarcodeScanned;
  const LabelScannerWidget({super.key, this.onBarcodeScanned});

  @override
  State<LabelScannerWidget> createState() => _LabelScannerWidgetState();
}

class _LabelScannerWidgetState extends State<LabelScannerWidget> {
  /* HARDWARE INTERCEPTOR STATE VARIABLES */
  String buffer = '';
  DateTime? lastKeyTime;

  String pairedDeviceName = 'No device paired';

  @override
  void initState() {
    super.initState();
    labelScannerController.getActions();
    HardwareKeyboard.instance.addHandler(handleGlobalKeyStroke);
  }

  bool handleGlobalKeyStroke(KeyEvent event) {
    // If user turned off the scanner in the UI, ignore background hardware inputs entirely
    if (labelScannerController.scannerInput == true) return false;

    // Only process when a key is physically pushed down
    if (event is! KeyDownEvent) return false;

    final now = DateTime.now();
    final delayLimit =
        int.tryParse(labelScannerController.keyCaptureDelay.text.trim()) ?? 50;

    // Human vs. Machine filter: if too much time passed, reset buffer (likely manual typing)
    if (lastKeyTime != null &&
        now.difference(lastKeyTime!).inMilliseconds > delayLimit) {
      buffer = '';
    }
    lastKeyTime = now;

    // Determine what represents the "End of Scan" based on UI settings
    bool isTerminatorToken = false;

    if (labelScannerController.scanTriggerOptions == 'Enter Key' &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      isTerminatorToken = true;
    } else if (labelScannerController.scanTriggerOptions == 'Tab Key' &&
        event.logicalKey == LogicalKeyboardKey.tab) {
      isTerminatorToken = true;
    } else if (labelScannerController.scanTriggerOptions == 'Custom Suffix' &&
        event.character == labelScannerController.keyCaptureDelay.text.trim()) {
      isTerminatorToken = true;
    }

    // Process the collected buffer if the terminator token is hit
    if (isTerminatorToken) {
      if (buffer.length > 3) {
        processCapturedScan(buffer);
      }
      buffer = '';
      return true; // Handled: stops event from bubbling up and causing accidental UI focus issues
    }

    // If it's a normal character, append it to our ongoing scan string
    if (event.character != null && event.character!.isNotEmpty) {
      // Ensure we don't accidentally append the custom suffix itself into the clean text string
      if (labelScannerController.scanTriggerOptions == 'Custom Suffix' &&
          event.character ==
              labelScannerController.keyCaptureDelay.text.trim()) {
        return false;
      }
      buffer += event.character!;
    }

    return false; // Pass through to let other UI components function normally
  }

  void processCapturedScan(String code) {
    debugPrint('Hardware Scan Triggered Successfully: $code');

    if (labelScannerController.listOfScanInput == 'Play sound on scan') {
      // TODO: SystemSound.play(SystemSoundType.click) or call audio package here
    }

    if (widget.onBarcodeScanned != null) {
      widget.onBarcodeScanned!(code);
    }

    if (labelScannerController.listOfScanInput == 'Auto-submit on scan') {
      // Dynamically auto-submits data right away if toggled on
      saveSettings();
    } else {
      // Visually alert user code was received without forcing an immediate screen exit
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scanned code captured: $code'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void saveSettings() {
    final settings = {
      "scannerInput": labelScannerController.scannerInput,
      "scanTrigger": labelScannerController.scanTriggerSelected,
      "keyCaptureDelay": labelScannerController.keyCaptureDelay,
      "listOfScanInput": labelScannerController.listOfScanInput,
    };
    print('Scanner settings: $settings');
    Navigator.pop(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      labelScannerController.keyCaptureDelay.clear();
    });
    super.dispose();
  }

  void pairDevice() {
    // TODO: hook into your actual device pairing flow (Bluetooth/USB HID discovery)
    setState(() => pairedDeviceName = 'Scanning for devices...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invisible,
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(
          child: Text('Barcode & Label Scanners', style: textAppBar),
        ),
      ),
      body: ListenableBuilder(
        listenable: labelScannerController,
        builder: (context, _) {
          return FadeInUp(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adjusts scanner triggers, key capture delays, and pairing for specialized barcode or QR scanners.',
                      style: TextStyle(color: grey, fontSize: 13),
                    ),
                    sizeBoxHeight(size.height * 0.02),
                    ...labelScannerController.scannerInput.keys.map((label) {
                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(label, style: textBodiesStyle),
                        value: labelScannerController.scannerInput[label]!,
                        activeColor: blueGreen,
                        onChanged: (value) => setState(() {
                          labelScannerController.scannerInput[label] = value;
                          buffer = '';
                        }),
                      );
                    }),

                    Divider(color: white),
                    sizeBoxHeight(size.height * 0.015),

                    Text(
                      'Device Pairing',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Iconsax.scan, color: white),
                          sizeBoxWidth(size.width * 0.02),
                          Expanded(
                            child: Text(
                              pairedDeviceName,
                              style: textBodiesStyle,
                            ),
                          ),
                          TextButton(
                            onPressed:
                                labelScannerController.scannerInput == true
                                ? pairDevice
                                : null,
                            child: Text(
                              'Pair',
                              style: TextStyle(color: blueGreen),
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizeBoxHeight(size.height * 0.03),

                    Text(
                      'Scan Trigger',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    DropdownButtonFormField<String>(
                      value: labelScannerController.scanTriggerSelected,
                      dropdownColor: grey,
                      style: textBodiesStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: blueGreen, width: 2),
                        ),
                      ),
                      items: labelScannerController.scanTriggerOptions.map((
                        option,
                      ) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          labelScannerController.changeScanTrigger(value);
                        }
                      },
                    ),

                    /* if (labelScannerController.scanTriggerSelected == 'Custom Suffix') ...[
                      sizeBoxHeight(size.height * 0.015),
                      TextField(
                        controller: customSuffixController,
                        enabled: scannerEnabled,
                        style: textBodiesStyle,
                        decoration: InputDecoration(
                          labelText: 'Custom Suffix Character',
                          labelStyle: TextStyle(color: white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                        ),
                      ),
                    ], */
                    sizeBoxHeight(size.height * 0.03),

                    Text(
                      'Key Capture Delay (ms)',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.005),
                    Text(
                      'Time window to treat rapid key input as a single scan, not manual typing.',
                      style: TextStyle(color: grey, fontSize: 12),
                    ),
                    sizeBoxHeight(size.height * 0.01),
                    TextFormField(
                      controller: labelScannerController.keyCaptureDelay,
                      enabled: labelScannerController
                          .scannerInput['Auto-submit on scan'],
                      keyboardType: TextInputType.number,
                      style: textBodiesStyle,
                      decoration: InputDecoration(
                        suffixText: 'ms',
                        suffixStyle: TextStyle(color: grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: white),
                        ),
                      ),
                    ),

                    sizeBoxHeight(size.height * 0.02),
                    ...labelScannerController.listOfScanInput.entries.map((
                      entry,
                    ) {
                      final option = entry.key;
                      final boolList = entry.value;

                      final isOptionActive =
                          boolList.isNotEmpty && boolList.first == true;

                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(option, style: textBodiesStyle),
                        subtitle: const Text(
                          'Automatically process the item once scanned, without pressing Enter.',
                          style: TextStyle(color: grey, fontSize: 12),
                        ),
                        value: isOptionActive,
                        activeColor: blueGreen,
                        onChanged:
                            (labelScannerController
                                    .scannerInput['Enable Scanner Input'] ??
                                false)
                            ? (bool newValue) {
                                setState(() {
                                  // 1. Mutate state
                                  labelScannerController
                                      .listOfScanInput[option] = [
                                    newValue,
                                  ];
                                });
                              }
                            : null,
                      );
                    }),

                    sizeBoxHeight(size.height * 0.03),

                    SaveButton(
                      callback: () async =>
                          await labelScannerController.storeActions(),
                      height: size.height / 14,
                      width: size.width / 2,
                      text: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SaveButton extends StatefulWidget {
  final VoidCallback callback;
  final double width, height;
  final String text;

  const SaveButton({
    super.key,
    required this.callback,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool passMouse = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (event) => setState(() => passMouse = true),
        onExit: (event) => setState(() => passMouse = false),
        child: InkWell(
          splashColor: invisible,
          onTap: widget.callback,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: passMouse ? blueGreen : white,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: GoogleFonts.aleo(
                  color: passMouse ? blueGreen : white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
