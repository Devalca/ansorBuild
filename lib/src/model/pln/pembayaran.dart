class Pembayaran {
  String id;
  String noMeter;
  String namaPelanggan;
  String status;
  String tarif;
  String daya;
  String nominal;
  String total;

  Pembayaran({
    this.id,
    this.noMeter,
    this.namaPelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total
  });

  factory Pembayaran.fromJson(Map<String, dynamic> item){
    return Pembayaran(
      id: item['id'],
      noMeter: item['no_meter'],
      namaPelanggan: item['nama_pelanggan'],
      status: item['status'],
      tarif: item['tarif'],
      daya: item['daya'],
      nominal: item['nominal'],
      total: item['total']
    );
  }
}