import 'package:fh_assignment/core/network/network_client.dart';

abstract class TopUpDataSource {
  Future<dynamic> topUp();
}

class TopUpDataSourceImpl extends TopUpDataSource {
  final NetworkClient networkClient;

  TopUpDataSourceImpl({required this.networkClient});

  @override
  Future<dynamic> topUp() async {
    /// FixME: Replace it with it's own implementation
    // final response = await networkClient.invoke(allProducts, RequestType.get);
    // if (response.statusCode == 200) {
    //   return response.data;
    // } else {
    //   throw ServerException(
    //     dioException: DioException(
    //       requestOptions: response.requestOptions,
    //       error: response,
    //       type: DioExceptionType.badResponse,
    //     ),
    //   );
    // }
  }
}