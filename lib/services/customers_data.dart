import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/services/el_mohami.dart';

class CustomersData {
  //add customer

  /* Future<bool> addCustomer(
      String name, String phone, String address, String id, String date) async {
    try {
      FirebaseFirestore.instance
          .collection(Elmohami.collectionCustomer)
          .get()
          .then((value) {
        for (int i = 0; i < value.size; i++) {
          if (value.docs[i].get(Elmohami.customerID) != id) {
            if (value.docs[i].get(Elmohami.customerPhoneNumber) == phone) {
              print('repeated phone');
              return false;
            }
          } else {
            print('repeated id');
            return false;
          }
        }
        print('repeated id and phone');
        FirebaseFirestore.instance
            .collection(Elmohami.collectionCustomer)
            .doc(id)
            .set({
          Elmohami.customerID: id,
          Elmohami.customerAddress: address,
          Elmohami.customerName: name,
          Elmohami.customerPhoneNumber: phone,
          Elmohami.customerDate: date,
        });
        /* .then((value) async {
        await Elmohami.sharedPreferences.setInt(
            Elmohami.customersCount,
            (Elmohami.sharedPreferences
                    .getInt(Elmohami.customersCount)
                    .toInt() +
                1));
      }); */
        return true;
      });
    } catch (e) {
      return false;
    }
  } */

  // get number of customers
  Future<int> customersCount() async {
    try {
      FirebaseFirestore.instance
          .collection(Elmohami.collectionCustomer)
          .get()
          .then((value) async {
        await Elmohami.sharedPreferences
            .setInt(Elmohami.customersCount, value.size);
        return value.size;
      });
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
