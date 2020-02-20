class PascaBayar {
  String transactionId;
  String noMeter;
  String status;

  PascaBayar({
    this.transactionId,
    this.noMeter,
    this.status
  });

  factory PascaBayar.fromJson(Map<String, dynamic> item){
    return PascaBayar(
      transactionId: item['transactionId'],
      noMeter: item['no_meter'],
      status: item['status']
    );
  }
}