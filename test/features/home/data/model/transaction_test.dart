import 'package:flutter_test/flutter_test.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/core/utils/enums.dart';

void main() {
  group('Transaction', () {
    test('fromJson creates a Transaction object', () {
      final json = {
        'id': '1',
        'createdAt': '2024-01-20T10:00:00Z',
        'beneficiary': 'Zeeshan',
        'type': 'credit',
        'amount': '100.00',
        'accountNumber': '1234567890',
        'currency': 'AED',
      };

      final transaction = Transaction.fromJson(json);

      expect(transaction.createdAt, '2024-01-20T10:00:00Z');
      expect(transaction.beneficiary, 'Zeeshan');
      expect(transaction.type, TransactionType.credit);
      expect(transaction.amount, '100.00');
      expect(transaction.accountNumber, '1234567890');
      expect(transaction.currency, 'AED');
      expect(transaction.id, '1');
    });

    test('toJson converts a Transaction object to JSON', () {
      final transaction = Transaction(
        createdAt: '2024-01-20T10:00:00Z',
        beneficiary: 'Zeeshan',
        type: TransactionType.credit,
        amount: '100.00',
        accountNumber: '1234567890',
        currency: 'AED',
        id: '1',
      );

      final json = transaction.toJson();

      expect(json['createdAt'], '2024-01-20T10:00:00Z');
      expect(json['beneficiary'], 'Zeeshan');
      expect(json['type'], 'credit');
      expect(json['amount'], '100.00');
      expect(json['accountNumber'], '1234567890');
      expect(json['currency'], 'AED');
      expect(json['id'], '1');
    });
  });
}