import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/enums.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/core/utils/utils.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RechargeDialog extends StatefulWidget {
  const RechargeDialog({
    super.key,
  });

  @override
  State<RechargeDialog> createState() => _RechargeDialogState();
}

class _RechargeDialogState extends State<RechargeDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<TransactionCubit>().addTransaction(Transaction(
            createdAt: DateTime.now().toIso8601String(),
            beneficiary: 'MyAccount',
            type: TransactionType.credit,
            accountNumber: '',
            amount: _amountController.text,
            currency: 'AED',
            // id: Utils.generateTransactionID(),
          ));
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
                "Recharge",
                style: AppTypography.lightTheme.titleMedium,
              ),

              // Phone Number Field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                // @Dev In Edit case it will be always disable
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Amount is required";
                  }
                  if (value.length != 4) {
                    return "Amount must be 4 digits";
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return "Amount must be numeric";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixText: "AED ",
                  labelText: "Amount",
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
                      "Recharge",
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
