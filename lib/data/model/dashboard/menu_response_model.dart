// ignore_for_file: unnecessary_this

import 'package:sembako_bintang/domain/entity/dashboard/menu_entity.dart';

class MenuResponseModel {
  String? responseCode;
  OKContentMenu? oKContentMenu;

  MenuResponseModel({this.responseCode, this.oKContentMenu});

  MenuResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    oKContentMenu = json['OKContentMenu'] != null
        ? new OKContentMenu.fromJson(json['OKContentMenu'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    if (this.oKContentMenu != null) {
      data['OKContentMenu'] = this.oKContentMenu!.toJson();
    }
    return data;
  }

  MenuDashboardEntity toEntity() {
    return MenuDashboardEntity(
        responseCode: this.responseCode,
        oKContentMenu:
            this.oKContentMenu != null ? this.oKContentMenu!.toEntity() : null);
  }
}

class OKContentMenu {
  List<Menu>? menu;

  OKContentMenu({this.menu});

  OKContentMenu.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OKContentMenuEntity toEntity() {
    return OKContentMenuEntity(
        menu: this.menu != null
            ? this.menu!.map((e) => e.toEntity()).toList()
            : null);
  }
}

class Menu {
  String? routeName;
  String? imageUrl;
  String? title;
  String? subTitle;

  Menu({this.routeName, this.imageUrl, this.title, this.subTitle});

  Menu.fromJson(Map<String, dynamic> json) {
    routeName = json['routeName'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    subTitle = json['subTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    return data;
  }

  ListMenu toEntity() {
    return ListMenu(
        imageUrl: this.imageUrl,
        title: this.title,
        subTitle: this.subTitle,
        routeName: this.routeName);
  }
}
