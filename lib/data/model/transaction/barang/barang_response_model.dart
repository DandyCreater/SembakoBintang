import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';

class BarangResponseModel {
  String? responseCode;
  OKContentBarang? oKContentBarang;

  BarangResponseModel({this.responseCode, this.oKContentBarang});

  BarangResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    oKContentBarang = json['OKContentBarang'] != null
        ? new OKContentBarang.fromJson(json['OKContentBarang'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = responseCode;
    if (oKContentBarang != null) {
      data['OKContentBarang'] = oKContentBarang!.toJson();
    }
    return data;
  }

  BarangEntity toEntity() {
    return BarangEntity(
        responseCode: responseCode,
        oKContentBarang: oKContentBarang != null
            ? oKContentBarang!.toEntity()
            : null);
  }
}

class OKContentBarang {
  List<Barang>? barang;

  OKContentBarang({this.barang});

  OKContentBarang.fromJson(Map<String, dynamic> json) {
    if (json['barang'] != null) {
      barang = <Barang>[];
      json['barang'].forEach((v) {
        barang!.add(new Barang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (barang != null) {
      data['barang'] = barang!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OKContentBarangEntity toEntity() {
    return OKContentBarangEntity(
        barang: barang != null
            ? barang!.map((e) => e.toEntity()).toList()
            : null);
  }
}

class Barang {
  String? imageUrl;
  String? title;
  String? price;

  Barang({this.imageUrl, this.title, this.price});

  Barang.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = imageUrl;
    data['title'] = title;
    data['price'] = price;
    return data;
  }

  ListBarang toEntity() {
    return ListBarang(
        imageUrl: imageUrl, title: title, price: price);
  }
}
