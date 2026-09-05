import 'package:flutter/material.dart';
import 'package:storecs/Core/styles/colors.dart';

enum UserAccountStatus {
  active,
  longBreak,
  busy,
  offline,
} /* restrict user with values */

extension UserAccountStatusExtension on UserAccountStatus {
  /* make extensions for the user intractions */
  Color get color {
    switch (this) {
      case UserAccountStatus.active:
        return blueGreen;
      case UserAccountStatus.longBreak:
        return gold;

      case UserAccountStatus.busy:
        return redColor;
      case UserAccountStatus.offline:
        return colorGrey;
    }
  }

  String get label {
    switch (this) {
      case UserAccountStatus.active:
        return 'Active';
      case UserAccountStatus.longBreak:
        return 'Break';
      case UserAccountStatus.busy:
        return 'Busy';
      case UserAccountStatus.offline:
        return 'Offline';
    }
  }

  /* check which status are selectable from current status then show it's list of status */
  List<UserAccountStatus> get availableTransitionsAccStatus {
    switch (this) {
      case UserAccountStatus.offline:
        return [UserAccountStatus.active, UserAccountStatus.offline];
      case UserAccountStatus.busy:
      case UserAccountStatus.longBreak:
        return [
          UserAccountStatus.active,
          UserAccountStatus.longBreak,
          UserAccountStatus.busy,
        ];
      case UserAccountStatus.active:
        return UserAccountStatus.values;
    }
  }
}
