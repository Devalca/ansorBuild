class SakitResponse {
  bool status;
  String msg;
  int data;
  String blok;

  SakitResponse({this.status, this.msg, this.data});

  factory SakitResponse.fromJson(Map<String, dynamic> map) {
    var transactionId = map['transactionId'];
    print(transactionId);
    return SakitResponse(
        status: map["status"], msg: map["message"], data: transactionId);
  }
}