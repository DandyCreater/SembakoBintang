class BarangEntity {
  String? responseCode;
  OKContentBarangEntity? oKContentBarang;
  BarangEntity({
    
   required this.responseCode,required this.oKContentBarang});
}

class OKContentBarangEntity {
  List<ListBarang>? barang;

  OKContentBarangEntity({
    required this.barang});

  OKContentBarangEntity.fromJson(Map<String, dynamic> json) {
    if (json['barang'] != null) {
      barang = <ListBarang>[];
      json['barang'].forEach((v) {
        barang!.add(new ListBarang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barang != null) {
      data['barang'] = this.barang!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListBarang {
  String? imageUrl;
  String? title;
  String? price;

  ListBarang({
   required this.imageUrl,
   required this.title,
   required this.price});

  ListBarang.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}
