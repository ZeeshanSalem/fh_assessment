import 'package:dartz/dartz.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/domain/repository/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:fh_assignment/core/logger/app_logger.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockLogger extends Mock implements AppLogger {}

class MockPreferencesUtil extends Mock implements PreferencesUtil {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockHomeRepository mockHomeRepository;
  late MockLogger mockLogger;
  late MockSharedPreferences mockSharedPreferences;
  late TransactionCubit cubit;
  late PreferencesUtil preferencesUtil;


  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockLogger = MockLogger();
    mockSharedPreferences = MockSharedPreferences();
    preferencesUtil =
        PreferencesUtil(preferences: mockSharedPreferences, logger: mockLogger);

    final getIt = GetIt.instance;
    getIt.registerSingleton<HomeRepository>(mockHomeRepository);
    getIt.registerSingleton<AppLogger>(mockLogger);
    getIt.registerSingleton<PreferencesUtil>(
        PreferencesUtil(preferences: mockSharedPreferences, logger: mockLogger));

    cubit = TransactionCubit(homeRepository: mockHomeRepository);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  final rawTransactionList = [
    {
      'id': '1',
      'createdAt': '2024-01-20T10:00:00Z',
      'beneficiary': 'Zeeshan',
      // 'type': 'credit',
      'amount': '100.00',
      'accountNumber': '1234567890',
      'currency': 'AED',
    },
    {
      'id': '2',
      'createdAt': '2024-02-20T10:00:00Z',
      'beneficiary': 'Zeeshan Saleem',
      // 'type': 'credit',
      'amount': '100.00',
      'accountNumber': '2234567890',
      'currency': 'AED',
    }

  ];

  final transactionList = rawTransactionList
      .map((transactionData) => Transaction.fromJson(transactionData))
      .toList();

  group('TransactionCubit', () {
    blocTest<TransactionCubit, TransactionState>(
      'emits [loading, success] when data is fetched successfully',
      build: () {
        // Ensure that the mock returns a valid response
        when(() => mockHomeRepository.getTransactions())
            .thenAnswer((_) async => Right(transactionList)); // Ensure transactionList is a valid List<Transaction>
        return cubit;
      },
      act: (cubit) => cubit.getTransactions(),
      expect: () => [
        const TransactionState(status: TransactionStatus.loading),
        TransactionState(
          status: TransactionStatus.success,
          transactions: transactionList.reversed.toList(), // Ensure this matches the expected output
        ),
      ],
    );

  });
}
