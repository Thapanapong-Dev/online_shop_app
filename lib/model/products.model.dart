class ProductsModel {
  List<ProductItems>? _productItems;

  ProductsModel({List<ProductItems>? productItems}) {
    if (productItems != null) {
      this._productItems = productItems;
    }
  }

  List<ProductItems>? get productItems => _productItems;
  set productItems(List<ProductItems>? productItems) =>
      _productItems = productItems;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['product_items'] != null) {
      _productItems = <ProductItems>[];
      json['product_items'].forEach((v) {
        _productItems!.add(new ProductItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._productItems != null) {
      data['product_items'] =
          this._productItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItems {
  String? _id;
  String? _name;
  int? _price;
  String? _imageUrl;

  ProductItems({String? id, String? name, int? price, String? imageUrl}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (price != null) {
      this._price = price;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get price => _price;
  set price(int? price) => _price = price;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;

  ProductItems.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['price'] = this._price;
    data['image_url'] = this._imageUrl;
    return data;
  }
}
