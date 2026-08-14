import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class IssuesOrSuggestionsWidgets extends StatefulWidget {
  const IssuesOrSuggestionsWidgets({super.key});

  @override
  State<IssuesOrSuggestionsWidgets> createState() =>
      _IssuesOrSuggestionsWidgetsState();
}

class _IssuesOrSuggestionsWidgetsState
    extends State<IssuesOrSuggestionsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: invisible,
        title: FadeInLeft(
          child: Text("Issues or Suggestions", style: textAppBar),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: FadeInUp(
            child: Container(
              width: size.width / 1.2,
              decoration: BoxDecoration(
                border: Border.all(color: white, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  IssueCategoriesTabs(
                    issueCategories: feedbackController.issueCategories,
                  ),
                  SeverityCategoriesTabs(severity: feedbackController.severity),
                  addANotePrompt(),
                  sendReportButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell sendReportButton() {
    return InkWell(
      onTap: () => feedbackController.storeFeedback(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: /* isHovered ? green : */ white, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        width: size.width * 0.4,
        height: size.height * 0.07,
        child: Center(
          child: Text("Submit Report", style: textStyleForButtons(24)),
        ),
      ),
    );
  }

  Container addANotePrompt() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.020,
        vertical: size.height * 0.030,
      ),
      width: size.width / 1.2,
      height: size.height / 2,
      child: TextFormField(
        maxLines: 200,
        controller: feedbackController.note,
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: 'Add a note.',
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(Iconsax.ticket, color: white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: greenColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class SeverityCategoriesTabs extends StatelessWidget {
  const SeverityCategoriesTabs({super.key, required this.severity});

  final List<String> severity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.145),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.004),
            child: Text(
              'Severity',
              style: GoogleFonts.aleo(
                fontSize: 24,
                color: white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Obx(
            () => Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.start,
              children: severity.map((serv) {
                final isSelected =
                    feedbackController.selectedSeverity.value == serv;
                return GestureDetector(
                  onTap: () => feedbackController.changeSeverit(serv),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                      right: size.width * 0.008,
                      top: size.height * 0.01,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      serv,
                      style: TextStyle(
                        color: isSelected ? Colors.green : Colors.white,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class IssueCategoriesTabs extends StatelessWidget {
  const IssueCategoriesTabs({super.key, required this.issueCategories});

  final List<String> issueCategories;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.02),
            child: Text(
              'Category',
              style: GoogleFonts.aleo(
                fontSize: 24,
                color: white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Obx(
            () => Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: issueCategories.map((issue) {
                final isSelected =
                    feedbackController.selectedIssueCategories.value == issue;

                return GestureDetector(
                  onTap: () => feedbackController.changeIssue(issue),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                      right: size.width * 0.008,
                      top: size.height * 0.01,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      issue,
                      style: TextStyle(
                        color: isSelected ? Colors.green : Colors.white,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
