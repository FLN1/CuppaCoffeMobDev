import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobdev_app/models/OrderMold.dart';
import 'package:mobdev_app/screens/Setting.dart';
import 'package:mobdev_app/arguments/FormData.dart';

import 'package:mobdev_app/services/database_service.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = false;
  final DatabaseService _DBService = DatabaseService();
  final TextEditingController _drinkController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Container(
          child: Text(
            "Cuppa Coffee\n",
            style: TextStyle(
                fontFamily: 'SoDoSans',
                fontSize: 25,
                fontWeight: FontWeight.w100,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        )),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Setting.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayTextInputDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      children: [
        _messListView(),
      ],
    ));
  }

  Widget _messListView() {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.80,
        width: MediaQuery.sizeOf(context).width,
        child: StreamBuilder(
            stream: _DBService.getOrders(),
            builder: (context, snapshot) {
              List orders = snapshot.data?.docs ?? [];
              if (orders.isEmpty) {
                return const Center(
                  child: Text("Add your order!"),
                );
              }
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Orders orderList = orders[index].data();
                    String orderID = orders[index].id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: ListTile(
                        tileColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        title: Text(orderList.customerName),
                      ),
                    );
                  });
            }));
  }

  void _displayTextInputDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add an order'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _drinkController,
                decoration: const InputDecoration(hintText: "Drink name"),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: "Customer name"),
              ),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(hintText: "Quantity"),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Okay'),
              onPressed: () {
                Orders order = Orders(
                  drink: _drinkController.text,
                  customerName: _nameController.text,
                  quantity: int.tryParse(_quantityController.text) ?? 0,
                );
                _DBService.addOrder(order);
                Navigator.pop(context);
                _drinkController.clear();
                _nameController.clear();
                _quantityController.clear();
              },
            )
          ],
        );
      },
    );
  }
}
