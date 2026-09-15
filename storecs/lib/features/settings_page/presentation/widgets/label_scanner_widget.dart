import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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
  bool scannerEnabled = true;
  bool autoSubmitOnScan = true;
  bool playSoundOnScan = true;

  String scanTrigger =
      'Enter Key'; /* how the scanner signals "end of scan"   */
  final List<String> scanTriggerOptions = [
    'Enter Key',
    'Tab Key',
    'Custom Suffix',
  ];

  final TextEditingController keyCaptureDelayController = TextEditingController(
    text: '50',
  );
  final TextEditingController customSuffixController = TextEditingController(
    text: '#',
  );
  /* HARDWARE INTERCEPTOR STATE VARIABLES */
  String buffer = '';
  DateTime? lastKeyTime;

  String pairedDeviceName = 'No device paired';

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(handleGlobalKeyStroke);
  }

  bool handleGlobalKeyStroke(KeyEvent event) {
    // If user turned off the scanner in the UI, ignore background hardware inputs entirely
    if (!scannerEnabled) return false;

    // Only process when a key is physically pushed down
    if (event is! KeyDownEvent) return false;

    final now = DateTime.now();
    final delayLimit =
        int.tryParse(keyCaptureDelayController.text.trim()) ?? 50;

    // Human vs. Machine filter: if too much time passed, reset buffer (likely manual typing)
    if (lastKeyTime != null &&
        now.difference(lastKeyTime!).inMilliseconds > delayLimit) {
      buffer = '';
    }
    lastKeyTime = now;

    // Determine what represents the "End of Scan" based on UI settings
    bool isTerminatorToken = false;

    if (scanTrigger == 'Enter Key' &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      isTerminatorToken = true;
    } else if (scanTrigger == 'Tab Key' &&
        event.logicalKey == LogicalKeyboardKey.tab) {
      isTerminatorToken = true;
    } else if (scanTrigger == 'Custom Suffix' &&
        event.character == customSuffixController.text.trim()) {
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
      if (scanTrigger == 'Custom Suffix' &&
          event.character == customSuffixController.text.trim()) {
        return false;
      }
      buffer += event.character!;
    }

    return false; // Pass through to let other UI components function normally
  }

  void processCapturedScan(String code) {
    debugPrint('Hardware Scan Triggered Successfully: $code');

    if (playSoundOnScan) {
      // TODO: SystemSound.play(SystemSoundType.click) or call audio package here
    }

    if (widget.onBarcodeScanned != null) {
      widget.onBarcodeScanned!(code);
    }

    if (autoSubmitOnScan) {
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
      'scannerEnabled': scannerEnabled,
      'autoSubmitOnScan': autoSubmitOnScan,
      'playSoundOnScan': playSoundOnScan,
      'scanTrigger': scanTrigger,
      'keyCaptureDelayMs':
          int.tryParse(keyCaptureDelayController.text.trim()) ?? 50,
      'customSuffix': customSuffixController.text.trim(),
    };
    print('Scanner settings: $settings');
    Navigator.pop(context);
  }

  @override
  void dispose() {
    keyCaptureDelayController.dispose();
    customSuffixController.dispose();
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
        title: FadeInRight(
          child: Text('Barcode & Label Scanners', style: textAppBar),
        ),
      ),
      body: FadeInUp(
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

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Enable Scanner Input', style: textBodiesStyle),
                  value: scannerEnabled,
                  activeColor: blueGreen,
                  onChanged: (value) => setState(() {
                    scannerEnabled = value;
                    buffer = '';
                  }),
                ),

                Divider(color: white),
                sizeBoxHeight(size.height * 0.015),

                Text(
                  'Device Pairing',
                  style: textBodiesStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                sizeBoxHeight(size.height * 0.01),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.scan, color: white),
                      sizeBoxWidth(size.width * 0.02),
                      Expanded(
                        child: Text(pairedDeviceName, style: textBodiesStyle),
                      ),
                      TextButton(
                        onPressed: scannerEnabled ? pairDevice : null,
                        child: Text('Pair', style: TextStyle(color: blueGreen)),
                      ),
                    ],
                  ),
                ),

                sizeBoxHeight(size.height * 0.03),

                Text(
                  'Scan Trigger',
                  style: textBodiesStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                sizeBoxHeight(size.height * 0.01),

                DropdownButtonFormField<String>(
                  value: scanTrigger,
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
                  items: scanTriggerOptions.map((option) {
                    return DropdownMenuItem(value: option, child: Text(option));
                  }).toList(),
                  onChanged: scannerEnabled
                      ? (value) => setState(() => scanTrigger = value!)
                      : null,
                ),

                if (scanTrigger == 'Custom Suffix') ...[
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
                ],

                sizeBoxHeight(size.height * 0.03),

                Text(
                  'Key Capture Delay (ms)',
                  style: textBodiesStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                sizeBoxHeight(size.height * 0.005),
                Text(
                  'Time window to treat rapid key input as a single scan, not manual typing.',
                  style: TextStyle(color: grey, fontSize: 12),
                ),
                sizeBoxHeight(size.height * 0.01),
                TextField(
                  controller: keyCaptureDelayController,
                  enabled: scannerEnabled,
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

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Auto-submit on scan', style: textBodiesStyle),
                  subtitle: Text(
                    'Automatically process the item once scanned, without pressing Enter.',
                    style: TextStyle(color: grey, fontSize: 12),
                  ),
                  value: autoSubmitOnScan,
                  activeColor: blueGreen,
                  onChanged: scannerEnabled
                      ? (value) => setState(() => autoSubmitOnScan = value)
                      : null,
                ),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Play sound on scan', style: textBodiesStyle),
                  value: playSoundOnScan,
                  activeColor: blueGreen,
                  onChanged: scannerEnabled
                      ? (value) => setState(() => playSoundOnScan = value)
                      : null,
                ),

                sizeBoxHeight(size.height * 0.03),

                SaveButton(
                  callback: () {},
                  height: size.height / 14,
                  width: size.width / 2,
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
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
