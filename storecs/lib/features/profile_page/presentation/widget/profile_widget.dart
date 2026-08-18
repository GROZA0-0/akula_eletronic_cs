import 'dart:convert';

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

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: FadeInLeft(child: Text("User Profile Page", style: textAppBar)),
        iconTheme: IconThemeData(color: white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeInUp(child: profileBlocWidget()),
        ),
      ),
    );
  }

  Widget profileBlocWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileBloc(sl<ProfileController>())
                ..add(ProfileBlocEventLoading()),
        ),
      ],
      child: BlocBuilder<ProfileBloc, ProfileBlocState>(
        builder: (context, state) {
          if (state is ProfileBlocStateLoading) {
            return loadingStateBodies();
          } else if (state is ProfileBlocStateError) {
            return Center(
              child: Text(
                'No Profile Fetch, Kindly Try Again',
                style: textBodiesStyle2,
              ),
            );
          } else if (state is ProfileBlocStateLoaded) {
            final profile = state.entities;
            final checkStatus = profile.status.name;
            return fetchProfileInfoFromTheBloc(profile, checkStatus);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget fetchProfileInfoFromTheBloc(
    ProfileEntities profile,
    String checkStatus,
  ) {
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
        top: size.height * 0.1,
        left: size.width * 0.02,
        right: size.width * 0.02,
      ),
      child: Column(
        children: [
          sizeBoxHeight(size.height * 0.02),
          buildProfileImage(profile.picture),
          sizeBoxHeight(size.height * 0.02),
          ProfileInfoWidget(profile: profile, checkStatus: checkStatus),
        ],
      ),
    );
  }

  Widget buildProfileImage(String base64Image) {
    if (base64Image.isEmpty) {
      return const CircleAvatar(
        backgroundColor: grey,
        radius: 100,
        child: Icon(color: white, Iconsax.user),
      );
    } else {
      try {
        String sanitizedBase64 = base64Image.contains(',')
            ? base64Image.split(',').last
            : base64Image;

        sanitizedBase64 = sanitizedBase64.replaceAll(RegExp(r'\s+'), '');
        final bytes = base64Decode(sanitizedBase64);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: white),
          ),
          child: CircleAvatar(radius: 100, backgroundImage: MemoryImage(bytes)),
        );
      } catch (e) {
        print("error rending base64 : $e");
        return Container(
          margin: EdgeInsets.only(right: size.width * 0.03),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.error_outline, color: white, size: 16),
          ),
        );
      }
    }
  }
}

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.profile,
    required this.checkStatus,
  });

  final ProfileEntities profile;
  final String checkStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.3,
      height: size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextProfileTemplate(
            text: 'Employee Name: ${profile.name}',
            size: 24,
            color: white,
          ),
          TextProfileTemplate(
            text: 'Employee Email: ${profile.email}',
            size: 20,
            color: lightGrey,
          ),
          TextProfileTemplate(
            text: 'Employee Role: ${profile.level}',
            size: 20,
            color: lightGrey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextProfileTemplate(
                text: 'Employee Status: ',
                size: 20,
                color: lightGrey,
              ),
              TextProfileTemplate(
                text: profile.status.name,
                size: 20,
                color: checkStatus == 'active' ? blueGreen : grey,
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
  final double size;
  final Color color;
  const TextProfileTemplate({
    super.key,
    required this.text,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.aleo(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
