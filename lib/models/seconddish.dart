class Secondish {
  String name;
  String id;
  int price;
  String size;
  String image;
  String CookerId;

  int pQuantity;

  Secondish(this.name, this.CookerId, this.price, this.image, this.pQuantity,
      this.size, this.id);

  Secondish.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    size = json['size'];
    CookerId = json['CookerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['size'] = this.size;
    data['CookerId'] = this.CookerId;
    return data;
  }
}
