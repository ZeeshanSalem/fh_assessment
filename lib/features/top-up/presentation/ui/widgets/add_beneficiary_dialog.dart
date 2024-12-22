import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBeneficiaryDialog extends StatefulWidget {
  const AddBeneficiaryDialog({
    super.key,
  });

  @override
  State<AddBeneficiaryDialog> createState() => _AddBeneficiaryDialogState();
}

class _AddBeneficiaryDialogState extends State<AddBeneficiaryDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<BeneficiaryCubit>().addBeneficiary(
            Beneficiary(
              id: "+971${_phoneController.text}",
              nickName: _nicknameController.text,
            ),
          );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                "Add Beneficiary",
                style: AppTypography.lightTheme.titleMedium,
              ),

              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                maxLength: 9,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number is required";
                  }
                  if (value.length != 9) {
                    return "Phone number must be 9 digits";
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return "Phone number must be numeric";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixText: "+971 ",
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  counterText: "",
                ),
              ),

              // Nickname Field
              TextFormField(
                controller: _nicknameController,
                maxLength: 20,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nickname is required";
                  }
                  if (value.length > 20) {
                    return "Nickname cannot exceed 20 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nickname",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  counterText: "",
                ),
              ),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: AppTypography.lightTheme.bodyMedium
                          ?.copyWith(color: CustomColors.primary),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      "Add",
                      style: AppTypography.lightTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
