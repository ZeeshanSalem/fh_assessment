import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

enum SnackBarStatusEnum { success, failure, warning }

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
            status == SnackBarStatusEnum.success
                ? Icons.check_circle_outline
                : status == SnackBarStatusEnum.warning
                    ? Icons.warning
                    : Icons.error,
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
    backgroundColor: status == SnackBarStatusEnum.success
        ? CustomColors.success
        : status == SnackBarStatusEnum.warning
            ? CustomColors.warning
            : CustomColors.error,
  );
}
