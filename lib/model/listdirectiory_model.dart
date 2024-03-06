import 'dart:convert';

ListKamus listKamusFromJson(String str) => ListKamus.fromJson(json.decode(str));

String listKamusToJson(ListKamus data) => json.encode(data.toJson());

class ListKamus {
  String message;
  List<Result> results;

  ListKamus({
    required this.message,
    required this.results,
  });

  factory ListKamus.fromJson(Map<String, dynamic> json) => ListKamus(
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String kataIndonesia;
  String kataJerman;
  JenisKata jenisKata;
  String contohPenggunaan;
  String contohPenggunaanJerman;
  String keterangan;

  Result({
    required this.kataIndonesia,
    required this.kataJerman,
    required this.jenisKata,
    required this.contohPenggunaan,
    required this.contohPenggunaanJerman,
    required this.keterangan,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    kataIndonesia: json["kata_indonesia"],
    kataJerman: json["kata_jerman"],
    jenisKata: jenisKataValues.map[json["jenis_kata"]]!,
    contohPenggunaan: json["contoh_penggunaan"],
    contohPenggunaanJerman: json["contoh_penggunaan_jerman"],
    keterangan: json["keterangan"],
  );

  Map<String, dynamic> toJson() => {
    "kata_indonesia": kataIndonesia,
    "kata_jerman": kataJerman,
    "jenis_kata": jenisKataValues.reverse[jenisKata],
    "contoh_penggunaan": contohPenggunaan,
    "contoh_penggunaan_jerman": contohPenggunaanJerman,
    "keterangan": keterangan,
  };
}

enum JenisKata {
  KATA_BENDA,
  KATA_KERJA,
  KATA_SIFAT
}

final jenisKataValues = EnumValues({
  "Kata Benda": JenisKata.KATA_BENDA,
  "Kata Kerja": JenisKata.KATA_KERJA,
  "Kata Sifat": JenisKata.KATA_SIFAT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
