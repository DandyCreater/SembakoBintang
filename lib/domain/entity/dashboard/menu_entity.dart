class MenuDashboardEntity {
  String? responseCode;
  OKContentMenuEntity? oKContentMenu;

  MenuDashboardEntity({required this.responseCode, required this.oKContentMenu});
}

class OKContentMenuEntity {
  List<ListMenu>? menu;

  OKContentMenuEntity({
    
   required this.menu});

  OKContentMenuEntity.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <ListMenu>[];
      json['menu'].forEach((v) {
        menu!.add(new ListMenu.fromJson(v));
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
}

class ListMenu {
  String? routeName;
  String? imageUrl;
  String? title;
  String? subTitle;

  ListMenu({required this.routeName, required this.imageUrl, required this.title, required this.subTitle});

  ListMenu.fromJson(Map<String, dynamic> json) {
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
}
