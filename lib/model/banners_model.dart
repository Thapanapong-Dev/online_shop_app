class BannersModel {
  List<BannerItems>? _bannerItems;

  BannersModel({List<BannerItems>? bannerItems}) {
    if (bannerItems != null) {
      this._bannerItems = bannerItems;
    }
  }

  List<BannerItems>? get bannerItems => _bannerItems;
  set bannerItems(List<BannerItems>? bannerItems) => _bannerItems = bannerItems;

  BannersModel.fromJson(Map<String, dynamic> json) {
    if (json['banner_items'] != null) {
      _bannerItems = <BannerItems>[];
      json['banner_items'].forEach((v) {
        _bannerItems!.add(new BannerItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._bannerItems != null) {
      data['banner_items'] = this._bannerItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerItems {
  String? _id;
  String? _imageUrl;

  BannerItems({String? id, String? imageUrl}) {
    if (id != null) {
      this._id = id;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;

  BannerItems.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image_url'] = this._imageUrl;
    return data;
  }
}
