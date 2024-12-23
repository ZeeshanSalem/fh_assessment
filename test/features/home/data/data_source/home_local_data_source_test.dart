import 'package:dio/dio.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_client.dart';
import 'package:fh_assignment/core/network/network_constant.dart';
import 'package:fh_assignment/core/utils/enums.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:fh_assignment/features/home/data/data_source/home_local_data_source.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<NetworkClient>(),
  MockSpec<PreferencesUtil>(),
])
import 'home_local_data_source_test.mocks.dart';

void main() {
  late HomeLocalDataSourceImpl dataSource;
  late MockNetworkClient mockNetworkClient;
  late MockPreferencesUtil mockPreferencesUtil;

  // Test data
  final tTransaction = Transaction(
    id: '1',
    createdAt: '2024-01-20T10:00:00Z',
    beneficiary: 'Zeeshan',
    type: TransactionType.credit,
    amount: '100.00',
    accountNumber: '+1234567890',
    currency: 'AED',
  );

  setUp(() {
    mockNetworkClient = MockNetworkClient();
    mockPreferencesUtil = MockPreferencesUtil();
    dataSource = HomeLocalDataSourceImpl(
      networkClient: mockNetworkClient,
      preferencesUtil: mockPreferencesUtil,
    );
  });

  group('HomeLocalDataSource Tests |', () {
    group('getTransactions() |', () {
      test('should return transactions when successful', () async {
        // Arrange
        final expectedResponse = {
          'transactions': [
            {
              'id': '1',
              'createdAt': '2024-01-20T10:00:00Z',
              'beneficiary': 'Zeeshan',
              'type': 'credit',
              'amount': '100.00',
              'accountNumber': '+1234567890',
              'currency': 'AED',
            }
          ]
        };

        when(mockNetworkClient.invoke(transactionAPI, RequestType.get))
            .thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: transactionAPI),
          data: expectedResponse,
          statusCode: 200,
        ));

        // Act
        final result = await dataSource.getTransactions();

        // Assert
        expect(result, equals(expectedResponse));
        verify(mockNetworkClient.invoke(transactionAPI, RequestType.get));
      });

      test('should throw ServerException when fails', () async {
        // Arrange
        when(mockNetworkClient.invoke(transactionAPI, RequestType.get))
            .thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: transactionAPI),
          statusCode: 404,
        ));

        // Act & Assert
        expect(
              () => dataSource.getTransactions(),
          throwsA(isA<ServerException>()),
        );
      });
    });

    group('addTransaction() |', () {
      test('should return success response when transaction added', () async {
        // Arrange
        final expectedResponse = {
          'status': 'success',
          'transaction': tTransaction.toJson(),
        };

        when(mockNetworkClient.invoke(
          transactionAPI,
          RequestType.post,
          requestBody: tTransaction.toJson(),
        )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: transactionAPI),
          data: expectedResponse,
          statusCode: 201,
        ));

        // Act
        final result = await dataSource.addTransaction(tTransaction);

        // Assert
        expect(result, equals(expectedResponse));
        verify(mockNetworkClient.invoke(
          transactionAPI,
          RequestType.post,
          requestBody: tTransaction.toJson(),
        ));
      });

      test('should throw ServerException when fails', () async {
        // Arrange
        when(mockNetworkClient.invoke(
          transactionAPI,
          RequestType.post,
          requestBody: tTransaction.toJson(),
        )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: transactionAPI),
          statusCode: 400,
        ));

        // Act & Assert
        expect(
              () => dataSource.addTransaction(tTransaction),
          throwsA(isA<ServerException>()),
        );
      });
    });
  });
}