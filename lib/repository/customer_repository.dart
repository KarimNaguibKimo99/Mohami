import '../models/customer_response.dart';
import './customer_api_provider.dart';

class CustomerRepository {
  CustomerApiProvider _customerApiProvider = CustomerApiProvider();
  Future<CustomerResponse> getCustomer() {
    return _customerApiProvider.getCustomer();
  }
}
