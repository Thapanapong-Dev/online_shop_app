class ProductsSelectedModel {
  ProductsSelected? _productsSelected;

  ProductsSelectedModel({ProductsSelected? productsSelected}) {
    if (productsSelected != null) {
      this._productsSelected = productsSelected;
    }
  }

  ProductsSelected? get productsSelected => _productsSelected;
  set productsSelected(ProductsSelected? productsSelected) =>
      _productsSelected = productsSelected;

  ProductsSelectedModel.fromJson(Map<String, dynamic> json) {
    _productsSelected = json['products_selected'] != null
        ? new ProductsSelected.fromJson(json['products_selected'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._productsSelected != null) {
      data['products_selected'] = this._productsSelected!.toJson();
    }
    return data;
  }
}

class ProductsSelected {
  double? _totaPrice;
  List<Products>? _products;

  ProductsSelected({double? totaPrice, List<Products>? products}) {
    if (totaPrice != null) {
      this._totaPrice = totaPrice;
    }
    if (products != null) {
      this._products = products;
    }
  }

  double? get totalPrice => _totaPrice;
  set totalPrice(double? totaPrice) => _totaPrice = totaPrice;
  List<Products>? get products => _products;
  set products(List<Products>? products) => _products = products;

  ProductsSelected.fromJson(Map<String, dynamic> json) {
    _totaPrice = json['tota_price'];
    if (json['products'] != null) {
      _products = <Products>[];
      json['products'].forEach((v) {
        _products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tota_price'] = this._totaPrice;
    if (this._products != null) {
      data['products'] = this._products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? _id;
  int? _qty;
  double? _totalByItem;
  double? _price;
  String? _name;

  Products(
      {String? id,
      int? qty,
      double? totalByItem,
      double? price,
      String? name}) {
    if (id != null) {
      this._id = id;
    }
    if (qty != null) {
      this._qty = qty;
    }
    if (totalByItem != null) {
      this._totalByItem = totalByItem;
    }
    if (price != null) {
      this._price = price;
    }
    if (name != null) {
      this._name = name;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  int? get qty => _qty;
  set qty(int? qty) => _qty = qty;
  double? get totalByItem => _totalByItem;
  set totalByItem(double? totalByItem) => _totalByItem = totalByItem;
  double? get price => _price;
  set price(double? price) => _price = price;
  String? get name => _name;
  set name(String? name) => _name = name;

  Products.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _qty = json['qty'];
    _totalByItem = json['total_by_item'];
    _price = json['price'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['qty'] = this._qty;
    data['total_by_item'] = this._totalByItem;
    data['price'] = this._price;
    data['name'] = this._name;
    return data;
  }
}
