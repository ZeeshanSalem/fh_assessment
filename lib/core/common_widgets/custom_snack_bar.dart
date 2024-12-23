import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

enum SnackBarStatusEnum { success, failure, warning, info }

SnackBar customSnackBar(
    {required SnackBarStatusEnum status,
    required String msg,
    required BuildContext context}) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    content: SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 15,
        children: [
          Icon(
            _getSnackBarIcon(status),
            color: Colors.white,
          ),
          Expanded(
            child: Text(
              msg,
              style: AppTypography.lightTheme.titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: _getSnackBarBackgroundColor(status),
  );
}

_getSnackBarIcon(SnackBarStatusEnum status) {
  switch (status) {
    case SnackBarStatusEnum.failure:
      return Icons.error;

    case SnackBarStatusEnum.warning:
      return Icons.warning;
    case SnackBarStatusEnum.info:
      return Icons.info_outline;
    case SnackBarStatusEnum.success:
      return Icons.check_circle_outline;
  }
}

_getSnackBarBackgroundColor(SnackBarStatusEnum status) {
  switch (status) {
    case SnackBarStatusEnum.failure:
      return CustomColors.error;

    case SnackBarStatusEnum.warning:
      return CustomColors.warning;
    case SnackBarStatusEnum.info:
      return CustomColors.lightPurple;
    case SnackBarStatusEnum.success:
      return CustomColors.success;
  }
}
