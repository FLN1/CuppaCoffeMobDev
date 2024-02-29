import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobdev_app/models/OrderMold.dart';

const String Orders_Collection_Ref = "Orders";

class DatabaseService {
  final dbConnection = FirebaseFirestore.instance;

  late final CollectionReference _ordersRef;

  DatabaseService() {
    _ordersRef =
        dbConnection.collection(Orders_Collection_Ref).withConverter<Orders>(
            fromFirestore: (snapshots, _) => Orders.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (orders, _) => orders.toJson());
  }
  Stream<QuerySnapshot> getOrders() {
    return _ordersRef.snapshots();
  }

  void addOrder(Orders orders) {
    _ordersRef.add(orders);
  }

  void updateOrder(String orderID, Orders order) {
    _ordersRef.doc(orderID).update(order.toJson());
  }
}
