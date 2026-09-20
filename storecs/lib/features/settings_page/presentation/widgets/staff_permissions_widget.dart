import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class StaffPermissionWidget extends StatefulWidget {
  const StaffPermissionWidget({super.key});

  @override
  State<StaffPermissionWidget> createState() => _StaffPermissionWidgetState();
}

class _StaffPermissionWidgetState extends State<StaffPermissionWidget> {
  @override
  void initState() {
    super.initState();
    staffPermissionsController.getActions();
  }

  @override
  void dispose() {
    staffPermissionsController.newPIN.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invisible,
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(child: Text('Staff Permissions', style: textAppBar)),
      ),
      body: ListenableBuilder(
        listenable: staffPermissionsController,
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
                      'Restricts high-level actions like manual price overrides, open-box discounts, or processing returns to manager PIN codes.',
                      style: TextStyle(color: grey, fontSize: 13),
                    ),
                    sizeBoxHeight(size.height * 0.02),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Require Manager PIN',
                        style: textBodiesStyle,
                      ),
                      subtitle: Text(
                        'When enabled, restricted actions below will prompt for a manager PIN.',
                        style: TextStyle(color: grey, fontSize: 12),
                      ),
                      value: staffPermissionsController.pinRequired,
                      activeColor: blueGreen,
                      onChanged: (value) => setState(
                        () => staffPermissionsController.pinRequired = value,
                      ),
                    ),

                    Divider(color: white),
                    sizeBoxHeight(size.height * 0.015),

                    Text(
                      'Manager PIN',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    TextFormField(
                      controller: staffPermissionsController.newPIN,
                      enabled: staffPermissionsController.pinRequired,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      style: textBodiesStyle,
                      decoration: InputDecoration(
                        labelText: 'New PIN (leave blank to keep current)',
                        labelStyle: TextStyle(color: white),
                        prefixIcon: const Icon(Iconsax.lock_1, color: white),
                        counterText: '',
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
                    ),

                    sizeBoxHeight(size.height * 0.03),

                    Text(
                      'Restricted Actions',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.005),
                    Text(
                      'Toggle which actions require the manager PIN.',
                      style: TextStyle(color: grey, fontSize: 12),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    ...staffPermissionsController.hasAccess.keys.map((pageKey) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pageKey,
                              style: textBodiesStyle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            sizeBoxHeight(size.height * 0.008),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: staffPermissionsController.allLevels
                                  .map((level) {
                                    final isSelected =
                                        staffPermissionsController
                                            .hasAccess[pageKey]!
                                            .contains(level);
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected ? black : white,
                                        ),
                                        color: isSelected
                                            ? blueGreen
                                            : invisible,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: size.width * 0.09,
                                      height: size.width * 0.03,
                                      child: GestureDetector(
                                        onTap: () => staffPermissionsController
                                            .toggleLevelForPage(pageKey, level),
                                        child: Center(
                                          child: Text(
                                            level,
                                            style: GoogleFonts.aleo(
                                              color: white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    }),

                    sizeBoxHeight(size.height * 0.03),

                    SaveButton(
                      callback: () async =>
                          staffPermissionsController.storeActions(),
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
