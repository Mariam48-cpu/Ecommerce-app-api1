class ErroeModel {
  String? message;
  int? statusCode;

  ErroeModel({this.message, this.statusCode});

  ErroeModel.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    statusCode = json['statusCode'] is int
        ? json['statusCode']
        : int.tryParse(json['statusCode']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
