import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    this.msg = "Are you sure you want to proceed with this action?",
    this.title = "Confirmation",
    this.actionButtonName = "Yes",
    this.onAction,
    this.btnColor,
  });

  final String msg;
  final String actionButtonName;
  final Color? btnColor;
  final String title;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(
              title,
              style: AppTypography.lightTheme.titleMedium,
            ),
            content: Text(
              msg,
              textAlign: TextAlign.center,
              style: AppTypography.lightTheme.titleSmall,
            ),
            actions: [
              CupertinoDialogAction(
                /// This parameter indicates the action would perform
                /// a destructive action such as deletion, and turns
                /// the action's text color to red.
                isDefaultAction: true,
                onPressed: onAction ??
                    () {
                      Navigator.pop(context, true);
                    },
                child: Text(actionButtonName),
              ),
            ],
          )
        : AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            title: Text(
              title,
              style: AppTypography.lightTheme.titleMedium,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg,
                  textAlign: TextAlign.start,
                  style: AppTypography.lightTheme.titleSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(btnColor),
                      ),
                      onPressed: onAction ??
                          () {
                            Navigator.pop(context, true);
                          },
                      child: Text(
                        actionButtonName,
                        style: AppTypography.lightTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
