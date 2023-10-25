class CartModel {
  Cart? _cart;

  CartModel({Cart? cart}) {
    if (cart != null) {
      this._cart = cart;
    }
  }

  Cart? get cart => _cart;
  set cart(Cart? cart) => _cart = cart;

  CartModel.fromJson(Map<String, dynamic> json) {
    _cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._cart != null) {
      data['cart'] = this._cart!.toJson();
    }
    return data;
  }
}

class Cart {
  double? _totaPrice;
  List<ProductsSelected>? _productsSelected;

  Cart({double? totaPrice, List<ProductsSelected>? productsSelected}) {
    if (totaPrice != null) {
      this._totaPrice = totaPrice;
    }
    if (productsSelected != null) {
      this._productsSelected = productsSelected;
    }
  }

  double? get totaPrice => _totaPrice;
  set totaPrice(double? totaPrice) => _totaPrice = totaPrice;
  List<ProductsSelected>? get productsSelected => _productsSelected;
  set productsSelected(List<ProductsSelected>? productsSelected) =>
      _productsSelected = productsSelected;

  Cart.fromJson(Map<String, dynamic> json) {
    _totaPrice = json['tota_price'];
    if (json['products_selected'] != null) {
      _productsSelected = <ProductsSelected>[];
      json['products_selected'].forEach((v) {
        _productsSelected!.add(new ProductsSelected.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tota_price'] = this._totaPrice;
    if (this._productsSelected != null) {
      data['products_selected'] =
          this._productsSelected!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsSelected {
  String? _id;
  int? _qty;
  double? _totalByItem;
  double? _price;
  String? _name;

  ProductsSelected(
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

  ProductsSelected.fromJson(Map<String, dynamic> json) {
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
