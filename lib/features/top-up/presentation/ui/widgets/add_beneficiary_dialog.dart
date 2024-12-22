import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBeneficiaryDialog extends StatefulWidget {
  const AddBeneficiaryDialog({
    super.key,
    this.beneficiary,
  });

  /// when there is beneficiary it consider is edit. at that used can only
  /// change nickname.
  final Beneficiary? beneficiary;

  @override
  State<AddBeneficiaryDialog> createState() => _AddBeneficiaryDialogState();
}

class _AddBeneficiaryDialogState extends State<AddBeneficiaryDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  bool _isEdit = false;

  @override
  void initState() {
    _checkIsEdit();
    super.initState();
  }

  _checkIsEdit() {
    _isEdit = widget.beneficiary != null;
    if (_isEdit) {
      _phoneController =
          TextEditingController(text: '${widget.beneficiary?.id}');
      _nicknameController =
          TextEditingController(text: '${widget.beneficiary?.nickName}');
    }
    setState(() {});
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_isEdit) {
        context.read<BeneficiaryCubit>().updateBeneficiary(
              Beneficiary(
                id: _phoneController.text,
                nickName: _nicknameController.text,
              ),
            );
      } else {
        context.read<BeneficiaryCubit>().addBeneficiary(
              Beneficiary(
                id: "+971${_phoneController.text}",
                nickName: _nicknameController.text,
              ),
            );
      }

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
                "${_isEdit ? 'Edit' : 'Add'} Beneficiary",
                style: AppTypography.lightTheme.titleMedium,
              ),

              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                readOnly: _isEdit,
                maxLength: 9,
                // @Dev In Edit case it will be always disable
                validator: _isEdit
                    ? null
                    : (value) {
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
                  prefixText: _isEdit ? null : "+971 ",
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
                      _isEdit ? "Edit" : "Add",
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
