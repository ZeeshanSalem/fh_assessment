import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/core/utils/enums.dart';
import 'package:fh_assignment/features/home/data/data_source/home_local_data_source.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/data/model/user.dart';
import 'package:fh_assignment/features/home/data/repository/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<HomeLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'home_repository_impl_test.mocks.dart';

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeLocalDataSource mockHomeRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  final tTransaction = Transaction(
    id: '1',
    createdAt: '2024-01-20T10:00:00Z',
    beneficiary: 'Zeeshan',
    type: TransactionType.credit,
    amount: '100.00',
    accountNumber: '+1234567890',
    currency: 'AED',
  );
  final tTransactions = [tTransaction];
  final tUser = User(
    name: "Zeeshan Saleem",
    id: "+971524691686",
    totalBalance: 1000.0,
    accountStatus: false,
  );

  setUp(() {
    mockHomeRemoteDataSource = MockHomeLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HomeRepositoryImpl(
      networkInfo: mockNetworkInfo,
      homeRemoteDataSource: mockHomeRemoteDataSource,
    );
  });

  group('getTransactions() |', () {
    test('should return a list of transactions when connected to the internet', () async {
      when(mockNetworkInfo.isConnected).thenReturn(true);
      when(mockHomeRemoteDataSource.getTransactions())
          .thenAnswer((_) async => tTransactions.map((e) => e.toJson()).toList());

      final result = await repository.getTransactions();

      expect(result.fold((l) => null, (r) => r), tTransactions);

      verify(mockNetworkInfo.isConnected);
      verify(mockHomeRemoteDataSource.getTransactions());
    });

    test('should return ServerException when fetching transactions fails', () async {
      when(mockNetworkInfo.isConnected).thenReturn(true);
      when(mockHomeRemoteDataSource.getTransactions()).thenThrow(
        ServerException(
          dioException: DioException(
            requestOptions: RequestOptions(path: 'mock_path'),
          ),
        ),
      );

      final result = await repository.getTransactions();

      expect(
        result.fold(
                (l) => ServerException(
              dioException: DioException(
                requestOptions: RequestOptions(path: ''),
              ),
            ),
                (r) => null),
        isA<ServerException>(),
      );

      verify(mockNetworkInfo.isConnected);
      verify(mockHomeRemoteDataSource.getTransactions());
    });

    test('should return NoInternetException when not connected to the internet', () async {
      when(mockNetworkInfo.isConnected).thenReturn(false);

      final result = await repository.getTransactions();

      expect(
        result.fold(
                (l) => NoInternetException(message: 'No Internet Connection'),
                (r) => null),
        isA<NoInternetException>(),
      );
      verify(mockNetworkInfo.isConnected);
      verifyNever(mockHomeRemoteDataSource.getTransactions());
    });
  });




}
