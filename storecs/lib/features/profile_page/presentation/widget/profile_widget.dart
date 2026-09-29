import 'dart:convert';

import 'dart:typed_data';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/profile_page/domain/entities/profile_entities.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_bloc/profile_bloc.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_bloc/profile_bloc_event.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_bloc/profile_bloc_state.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_controller.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeInLeft(child: Text("User Profile Page", style: textAppBar)),
        iconTheme: const IconThemeData(color: white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeInUp(
            child: BlocProvider(
              create: (context) =>
                  ProfileBloc(sl<ProfileController>())
                    ..add(ProfileBlocEventLoading()),
              child: const ProfileBlocConsumerView(),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileBlocConsumerView extends StatelessWidget {
  const ProfileBlocConsumerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileBlocState>(
      builder: (context, state) {
        if (state is ProfileBlocStateLoading) {
          return loadingStateBodies();
        } else if (state is ProfileBlocStateError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'No Profile Fetch, Kindly Try Again',
                style: textBodiesStyle2,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (state is ProfileBlocStateLoaded) {
          final profile = state.entities;
          return ProfileCardView(profile: profile);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ProfileCardView extends StatelessWidget {
  final ProfileEntities profile;

  const ProfileCardView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return profileCardViewLayout();
  }

  Widget profileCardViewLayout() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
        top: size.height * 0.05,
        left: size.width * 0.02,
        right: size.width * 0.02,
        bottom: size.height * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.03,
        horizontal: size.width * 0.03,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatarWidget(base64Image: profile.picture),
          SizedBox(height: size.height * 0.03),
          ProfileInfoDetailsWidget(
            profile: profile,
            checkStatus: profile.status.name,
          ),
        ],
      ),
    );
  }
}

class ProfileAvatarWidget extends StatelessWidget {
  final String base64Image;

  const ProfileAvatarWidget({super.key, required this.base64Image});

  @override
  Widget build(BuildContext context) {
    if (base64Image.isEmpty) {
      return const CircleAvatar(
        backgroundColor: grey,
        radius: 80,
        child: Icon(Iconsax.user, color: white, size: 60),
      );
    }

    try {
      String sanitizedBase64 = base64Image.contains(',')
          ? base64Image.split(',').last
          : base64Image;

      sanitizedBase64 = sanitizedBase64.replaceAll(RegExp(r'\s+'), '');
      final bytes = base64Decode(sanitizedBase64);

      return fetchProfilePictureWidgetMethod(bytes);
    } catch (e) {
      debugPrint("Error rendering Base64 image: $e");
      return errOfProfilePictureMethod();
    }
  }

  Widget errOfProfilePictureMethod() {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.03),
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.error_outline, color: white, size: 16),
      ),
    );
  }

  Widget fetchProfilePictureWidgetMethod(Uint8List bytes) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: white, width: 2),
      ),
      child: CircleAvatar(radius: 80, backgroundImage: MemoryImage(bytes)),
    );
  }
}

class ProfileInfoDetailsWidget extends StatelessWidget {
  const ProfileInfoDetailsWidget({
    super.key,
    required this.profile,
    required this.checkStatus,
  });

  final ProfileEntities profile;
  final String checkStatus;

  @override
  Widget build(BuildContext context) {
    return profileInformationWidgetMethod();
  }

  Widget profileInformationWidgetMethod() {
    return SizedBox(
      width: size.width > 600 ? size.width * 0.5 : size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextProfileTemplate(
            text: 'Employee Name: ${profile.name}',
            fontSize: 22,
            color: white,
          ),
          const SizedBox(height: 12),
          TextProfileTemplate(
            text: 'Employee Email: ${profile.email}',
            fontSize: 18,
            color: lightGrey,
          ),
          const SizedBox(height: 12),
          TextProfileTemplate(
            text: 'Employee Role: ${profile.level}',
            fontSize: 18,
            color: lightGrey,
          ),
          const SizedBox(height: 12),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const TextProfileTemplate(
                text: 'Employee Status: ',
                fontSize: 18,
                color: lightGrey,
              ),
              TextProfileTemplate(
                text: profile.status.name,
                fontSize: 18,
                color: checkStatus.toLowerCase() == 'active' ? blueGreen : grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextProfileTemplate extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const TextProfileTemplate({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.aleo(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
