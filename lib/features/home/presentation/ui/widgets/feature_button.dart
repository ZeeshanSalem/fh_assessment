import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  const FeatureButton({
    super.key,
    this.btnIcon,
    this.onPress,
    this.btnName,
  });

  ///  btnName(String): title of feature button.
  final String? btnName;

  /// btnIcon(IconData) : icon for feature Button.
  final IconData? btnIcon;

  /// onPressed(VoidCallback): it's a call back function,
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircleAvatar(
              child: Icon(
                btnIcon,
                size: 18,
              ),
            ),
          ),
          Text(
            '$btnName',
            style:  AppTypography.lightTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
