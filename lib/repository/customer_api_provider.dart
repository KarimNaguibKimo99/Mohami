import '../models/customer_response.dart';
import 'package:dio/dio.dart';

class CustomerApiProvider {
  final String url = 'https://tawaklsa.com/moham/search.php';
  final Dio _dio = Dio();

  Future<CustomerResponse> getCustomer() async {
    try {
      /* FormData formData = new FormData.fromMap({
        'search_value': searchValue,
      }); */
      //Response response = await _dio.post(url, data: formData);
      Response response = await _dio.post(
        url,
      );
      return CustomerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error  stackTrace : $stacktrace');
      return CustomerResponse.withError('$error');
    }
  }
}
