import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/logger/app_logger.dart';
import 'package:fh_assignment/core/network/network_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

/// Generate mock classes for Dio and AppLogger using Mockito
/// This will create a new file named network_client_test.mocks.dart
@GenerateNiceMocks([MockSpec<Dio>(), MockSpec<AppLogger>()])
import 'network_client_test.mocks.dart';

void main() {
  // Declare test dependencies
  late NetworkClient networkClient;
  late MockDio mockDio;
  late MockAppLogger mockLogger;

  /// Test data constants used across multiple tests
  const tUrl = 'https://api.example.com';
  final tHeaders = {'Content-Type': 'application/json'};
  final tQueryParams = {'key': 'value'};
  final tRequestBody = {'data': 'test'};

  /// Mock successful response used in tests
  final tResponse = Response(
    requestOptions: RequestOptions(path: tUrl),
    data: {'response': 'success'},
    statusCode: 200,
  );

  /// Setup method runs before each test
  setUp(() {
    // Initialize mock objects
    mockDio = MockDio();
    mockLogger = MockAppLogger();
    // Create NetworkClient instance with mock dependencies
    networkClient = NetworkClient(
      dio: mockDio,
      logger: mockLogger,
    );
  });

  group('NetworkClient', () {
    /// Tests for successful HTTP requests
    test('GET request should complete successfully', () async {
      // Arrange: Configure mock Dio to return successful response for GET request
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => tResponse);

      // Act: Execute the GET request through NetworkClient
      final result = await networkClient.invoke(
        tUrl,
        RequestType.get,
        queryParameters: tQueryParams,
        headers: tHeaders,
        requestBody: tRequestBody,
      );

      // Assert: Verify response and method call
      expect(result, equals(tResponse));
      verify(mockDio.get(
        tUrl,
        queryParameters: tQueryParams,
        data: tRequestBody,
        options: anyNamed('options'),
      )).called(1);
    });

    test('POST request should complete successfully', () async {
      // Arrange: Configure mock Dio for POST request
      when(mockDio.post(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => tResponse);

      // Act: Execute the POST request
      final result = await networkClient.invoke(
        tUrl,
        RequestType.post,
        queryParameters: tQueryParams,
        headers: tHeaders,
        requestBody: tRequestBody,
      );

      // Assert: Verify response and method call
      expect(result, equals(tResponse));
      verify(mockDio.post(
        tUrl,
        queryParameters: tQueryParams,
        data: tRequestBody,
        options: anyNamed('options'),
      ));
    });

    test('PUT request should complete successfully', () async {
      // Arrange: Configure mock Dio for PUT request
      when(mockDio.put(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => tResponse);

      // Act: Execute the PUT request
      final result = await networkClient.invoke(
        tUrl,
        RequestType.put,
        queryParameters: tQueryParams,
        headers: tHeaders,
        requestBody: tRequestBody,
      );

      // Assert: Verify response and method call
      expect(result, equals(tResponse));
      verify(mockDio.put(
        tUrl,
        queryParameters: tQueryParams,
        data: tRequestBody,
        options: anyNamed('options'),
      ));
    });

    test('DELETE request should complete successfully', () async {
      // Arrange: Configure mock Dio for DELETE request
      when(mockDio.delete(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => tResponse);

      // Act: Execute the DELETE request
      final result = await networkClient.invoke(
        tUrl,
        RequestType.delete,
        queryParameters: tQueryParams,
        headers: tHeaders,
        requestBody: tRequestBody,
      );

      // Assert: Verify response and method call
      expect(result, equals(tResponse));
      verify(mockDio.delete(
        tUrl,
        queryParameters: tQueryParams,
        data: tRequestBody,
        options: anyNamed('options'),
      ));
    });

    test('PATCH request should complete successfully', () async {
      // Arrange: Configure mock Dio for PATCH request
      when(mockDio.patch(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => tResponse);

      // Act: Execute the PATCH request
      final result = await networkClient.invoke(
        tUrl,
        RequestType.patch,
        queryParameters: tQueryParams,
        headers: tHeaders,
        requestBody: tRequestBody,
      );

      // Assert: Verify response and method call
      expect(result, equals(tResponse));
      verify(mockDio.patch(
        tUrl,
        queryParameters: tQueryParams,
        data: tRequestBody,
        options: anyNamed('options'),
      ));
    });

    /// Tests for error handling scenarios
    test('should throw ServerException when DioException occurs', () async {
      // Arrange: Create DioException for connection timeout
      final dioError = DioException(
        requestOptions: RequestOptions(path: tUrl),
        type: DioExceptionType.connectionTimeout,
        error: 'Connection timeout',
      );

      // Configure mock to throw DioException
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(dioError);

      // Act & Assert: Verify that ServerException is thrown
      expect(
            () => networkClient.invoke(
          tUrl,
          RequestType.get,
          queryParameters: tQueryParams,
          headers: tHeaders,
        ),
        throwsA(isA<ServerException>()),
      );

      // Verify that error was logged
      verify(mockLogger.e(any, any));
    });

    test('should rethrow SocketException', () async {
      // Arrange: Create SocketException for no internet
      final socketException = const SocketException('No internet connection');

      // Configure mock to throw SocketException
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(socketException);

      // Act & Assert: Verify that SocketException is rethrown
      expect(
            () => networkClient.invoke(
          tUrl,
          RequestType.get,
          queryParameters: tQueryParams,
          headers: tHeaders,
        ),
        throwsA(isA<SocketException>()),
      );

      // Verify that error was logged
      verify(mockLogger.e(any, any));
    });
  });
}