class Orders {
  String drink = "";
  String customerName = "";
  int quantity = 0;

  Orders(
      {required this.drink,
      required this.customerName,
      required this.quantity});

  Orders.fromJson(Map<String, Object?> json)
      : this(
            drink: json['drink']! as String,
            customerName: json['customerName']! as String,
            quantity: json['quantity']! as int);

  Orders copyWidth({String? drink, String? customerName, int? quantity}) {
    return Orders(
        drink: drink ?? this.drink,
        customerName: customerName ?? this.customerName,
        quantity: quantity ?? this.quantity);
  }

  Map<String, Object?> toJson() {
    return {'drink': drink, 'customerName': customerName, 'quantity': quantity};
  }
}
