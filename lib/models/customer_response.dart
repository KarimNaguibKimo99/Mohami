import './customer.dart';

class CustomerResponse {
  final List<Customer> results;
  final String error;

  CustomerResponse(
    this.results,
    this.error,
  );

  CustomerResponse.fromJson(Map<String, dynamic> json)
      : results =
            (json['data'] as List).map((i) => Customer.fromjson(i)).toList(),
        error = '';

  CustomerResponse.withError(String error)
      : results = [],
        error = error;
}
