import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';

import 'enums.dart';

class TransactionValidator {
  final List<Transaction> monthlyTransactions;
  final bool isUserVerified;
  final num availableBalance;

  const TransactionValidator({
    required this.monthlyTransactions,
    required this.isUserVerified,
    required this.availableBalance,
  });

  TransactionValidationResult validateTransaction(Transaction newTransaction) {
    // First check balance
    final balanceResult = _validateBalance(newTransaction);
    if (!balanceResult.isValid) return balanceResult;

    // Then check monthly limit
    final monthlySpentResult = _validateMonthlySpendingLimit(newTransaction);
    if (!monthlySpentResult.isValid) return monthlySpentResult;

    // Finally check beneficiary limit
    final beneficiaryLimitResult = _validateBeneficiaryLimit(newTransaction);
    if (!beneficiaryLimitResult.isValid) return beneficiaryLimitResult;

    return TransactionValidationResult.success();
  }

  TransactionValidationResult _validateBalance(Transaction newTransaction) {
    final transactionAmount = _parseAmount(newTransaction.amount);

    if (transactionAmount > availableBalance) {
      return TransactionValidationResult.failure(
        'Insufficient balance. Available: AED $availableBalance',
      );
    }

    return TransactionValidationResult.success();
  }

  TransactionValidationResult _validateMonthlySpendingLimit(
    Transaction newTransaction,
  ) {
    final totalMonthlySpent = _calculateTotalMonthlySpent();
    final newTransactionAmount = _parseAmount(newTransaction.amount);

    if (totalMonthlySpent + newTransactionAmount > Constant.monthlyTopUpLimit) {
      return TransactionValidationResult.failure(
        'Monthly spending limit of AED ${Constant.monthlyTopUpLimit} exceeded',
      );
    }

    return TransactionValidationResult.success();
  }

  TransactionValidationResult _validateBeneficiaryLimit(
    Transaction newTransaction,
  ) {
    final monthlyBeneficiarySpent = _calculateBeneficiaryMonthlySpent(
      newTransaction.accountNumber!,
    );
    final newTransactionAmount = _parseAmount(newTransaction.amount);
    final beneficiaryLimit = isUserVerified
        ? Constant.verifiedBeneficiaryLimit
        : Constant.unVerifiedBeneficiaryLimit;

    if (monthlyBeneficiarySpent + newTransactionAmount > beneficiaryLimit) {
      return TransactionValidationResult.failure(
        '${isUserVerified ? 'Verified' : 'Unverified'} users can top up '
        'maximum AED $beneficiaryLimit per beneficiary per month',
      );
    }

    return TransactionValidationResult.success();
  }

  num _calculateTotalMonthlySpent() {
    return monthlyTransactions
        .where((transaction) => transaction.type == TransactionType.debt)
        .fold(0.0,
            (total, transaction) => total + _parseAmount(transaction.amount));
  }

  num _calculateBeneficiaryMonthlySpent(String beneficiary) {
    return monthlyTransactions
        .where((transaction) =>
            transaction.accountNumber == beneficiary &&
            transaction.type == TransactionType.debt)
        .fold(0.0,
            (total, transaction) => total + _parseAmount(transaction.amount));
  }

  num _parseAmount(String? amount) => num.tryParse(amount ?? '0') ?? 0.0;
}

class TransactionValidationResult {
  final bool isValid;
  final String? errorMessage;

  const TransactionValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  factory TransactionValidationResult.success() =>
      const TransactionValidationResult(isValid: true);

  factory TransactionValidationResult.failure(String message) =>
      TransactionValidationResult(isValid: false, errorMessage: message);
}
