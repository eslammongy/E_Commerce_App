class FavoriteProducts {
  bool status;
  String message;

  FavoriteProducts.formJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
