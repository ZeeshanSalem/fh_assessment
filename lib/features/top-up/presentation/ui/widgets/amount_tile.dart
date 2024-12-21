import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

/// Todo: Move stf to cubit/bloc
class AmountTile extends StatefulWidget {
  const AmountTile({super.key});

  @override
  State<AmountTile> createState() => _AmountTileState();
}

class _AmountTileState extends State<AmountTile> {
  List<String> amounts = [
    'AED 5',
    'AED 10',
    'AED 20',
    'AED 30',
    'AED 50',
    'AED 75',
    'AED 100',
  ];

  int? selectedAmount ;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List.generate(
        amounts.length,
        (index) => ChoiceChip(
          selectedColor: CustomColors.primary,
          checkmarkColor: Colors.white,
          disabledColor: Colors.grey,
          labelStyle: AppTypography.lightTheme.bodyMedium?.copyWith(
            color: selectedAmount == index ? Colors.white : Colors.black,
          ),
          label: Text(amounts[index]),
          selected: selectedAmount == index,
          onSelected: (value) {
            setState(() {
              selectedAmount = value ? index : null;
            });
          },
        ),
      ),
    );
  }
}
