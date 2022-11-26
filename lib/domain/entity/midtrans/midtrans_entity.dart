class MidtransEntity {
  String? orderId;
  String? paymentUrl;

  MidtransEntity({required this.orderId, required this.paymentUrl});

  MidtransEntity.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}
