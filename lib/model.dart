
class Product {
  final String pname;
  final String price;
  final String qty;
  final String total;

  Product({
    required this.pname,
    required this.price,
    required this.qty,
    required this.total,
  });

  Product copy({
    String? pname,
    String? price,
    String? qty,
    String? total,
  }) =>
      Product(
        pname: pname ?? this.pname,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        total: total ?? this.total,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          pname == other.pname &&
          price == other.price &&
          qty == other.qty &&
          total == other.total;

  @override
  int get hashCode =>
      pname.hashCode ^ price.hashCode ^ qty.hashCode ^ total.hashCode;
}
