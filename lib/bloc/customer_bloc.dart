import 'package:rxdart/rxdart.dart';
import '../models/customer_response.dart';
import '../repository/customer_repository.dart';

class CustomerBloc {
  final CustomerRepository _customerRepository = CustomerRepository();
  final BehaviorSubject<CustomerResponse> _subject =
      BehaviorSubject<CustomerResponse>();

  getCustomer() async {
    CustomerResponse response = await _customerRepository.getCustomer();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CustomerResponse> get subject => _subject;
}

final customerBloc = CustomerBloc();
