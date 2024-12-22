import 'package:flutter/material.dart';

import '../error/model/error_response_model.dart';
import '../utils/app_colors.dart';


class FailureWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final ErrorModel? errorModel;
  final String buttonName;

  const FailureWidget(
      {required this.onPressed,
      this.errorModel,
      this.buttonName = 'Try Again',
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: CustomColors.error,
              ),
            ],
          ),

          Text(
            errorModel?.message ?? "Something went Wrong!",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
                backgroundColor: CustomColors.error,

            ),
            child: Text(
              buttonName,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }


}
