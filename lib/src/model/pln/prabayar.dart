class Prabayar {
  String noMeter;
  int nominal;

  Prabayar({
    this.noMeter,
    this.nominal,
  });

  factory Prabayar.fromJson(Map<String, dynamic> item){
    return Prabayar(
      noMeter: item['noMeter'],
      nominal: item['nominal'],
    );
  }
}