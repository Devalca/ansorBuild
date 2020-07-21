String formatRupiah(value, {String separator='.', String trailing=''}) {
	return "Rp " + value.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}${separator}') + trailing;
}

String formatTanggal(DateTime date, {bool shortMonth=false}) {
  if (date.day <= 9) {
    	return "0${date.day} ${_convertToIndo(date.month, shortMonth)} ${date.year}";
  }
	return "${date.day} ${_convertToIndo(date.month, shortMonth)} ${date.year}";
}

String formatTglBulan(DateTime date, {bool shortMonth=false}) {
	return "${date.day} ${_convertToIndo(date.month, shortMonth)}";
}

String formatBlnTahun(DateTime date, {bool shortMonth=false}) {
	return "${_convertToIndo(date.month, shortMonth)} ${date.year}";
}

List _longMonth = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
List _shortMonth = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

String _convertToIndo(int month, bool shortMonth) {
	if (shortMonth) return _shortMonth[month -1];
	return _longMonth[month - 1];
}