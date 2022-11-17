class CartEntity {
  String? responseCode;
  OKContentCartEntity? oKContentCart;

  CartEntity({required this.responseCode, required this.oKContentCart});
}

class OKContentCartEntity {
  List<ListCart>? cart;

  OKContentCartEntity({required this.cart});

  OKContentCartEntity.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <ListCart>[];
      json['cart'].forEach((v) {
        cart!.add(new ListCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListCart {
  String? imageUrl;
  String? title;
  String? price;
  String? count;

  ListCart(
      {required this.imageUrl,
      required this.title,
      required this.price,
      required this.count});

  ListCart.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['price'] = this.price;
    data['count'] = this.count;
    return data;
  }
}
