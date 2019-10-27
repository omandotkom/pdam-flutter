import 'dart:convert';

Data clientFromJson(String str) => Data.fromJson(json.decode(str));

String clientToJson(Data data) => json.encode(data.toJson());

class Data {
  String nik;

  String noregsl;
  String namapelanggan;
  String alamat;
  String notelp;
  String nometer;
  String fotorumah;
  String fotoba;
  String fotometeran;
  Data(
      {this.nik,
      this.noregsl,
      this.namapelanggan,
      this.alamat,
      this.notelp,
      this.nometer,
      this.fotorumah,
      this.fotoba,
      this.fotometeran});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      nik: json["nik"],
      noregsl: json["noregsl"],
      namapelanggan: json["namapelanggan"],
      alamat: json['alamat'],
      notelp: json['notelp'],
      nometer: json['nometer'],
      fotorumah: json['fotorumah'],
      fotoba: json['fotoba'],
      fotometeran: json['fotometeran']);

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "noregsl": noregsl,
        "namapelanggan" : namapelanggan,
        "alamat" : alamat,
        "notelp" : notelp,
        "nometer" : nometer,
        "fotorumah" : fotorumah,
        "fotoba" : fotoba,
        "fotometeran" : fotometeran
      };
  String toString(){
    return alamat;
  }
}
