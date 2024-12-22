part of 'transaction_list_tile.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Text(
            '${transaction.beneficiary?.substring(0, 1).toUpperCase()}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _getTitle(),
                style: AppTypography.lightTheme.bodyMedium,
              ),
              Text(
                '27, May 2024 04:38 PM',
                style: AppTypography.lightTheme.bodySmall,
              ),
            ],
          ),
        ),
        Text(
          _getAmount(),
          style: AppTypography.lightTheme.headlineMedium?.copyWith(
            color: _getAmountColorByType(),
          ),
        ),
      ],
    );
  }

  Color _getAmountColorByType() {
    if (transaction.type == TransactionType.debt) {
      return CustomColors.error;
    }
    return CustomColors.success;
  }

  String _getTitle() {
    if (transaction.type == TransactionType.debt) {
      return 'Transfer to ${transaction.beneficiary}';
    }
    return 'Credit In Account';
  }

  String _getAmount() {
    String sign = transaction.type == TransactionType.debt ? '-' : '+';
    return '$sign ${transaction.currency} ${transaction.amount}';
  }
}
