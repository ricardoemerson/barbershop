import 'package:flutter/material.dart';

import '../config/app_validator_messages.dart';

extension AppValidatorMessagesExtension on BuildContext {
  AppValidatorMessages get validatorMessage => AppValidatorMessages.instance;
}
