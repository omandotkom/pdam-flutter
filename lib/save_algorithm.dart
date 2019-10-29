import 'package:flutter/material.dart' as material;
import 'package:pdf/widgets.dart';
import 'package:pdam/pojo/Data.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as s;
import 'package:esys_flutter_share/esys_flutter_share.dart';

class SavePDF {
  final Data data;
  SavePDF(this.data);
  Future<File> save() async {
    if (data == null) {
      throw ("Data is empty!");
    } else {
      final pdf = Document(compress: true, title: "LAPORAN TITLE");
      File fotoRumah = File(data.fotorumah);
      File fotoBa = File(data.fotoba);
      File fotoMeteran = File(data.fotometeran);
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(fotoRumah.path);
      File compressedRumahFile = await FlutterNativeImage.compressImage(
          fotoRumah.path,
          quality: 80,
          targetWidth: 600,
          targetHeight: (properties.height * 600 / properties.width).round());
      final img = s.decodeImage(compressedRumahFile.readAsBytesSync());

      properties = await FlutterNativeImage.getImageProperties(fotoBa.path);
      File compressedBaFile = await FlutterNativeImage.compressImage(
          fotoBa.path,
          quality: 80,
          targetWidth: 600,
          targetHeight: (properties.height * 600 / properties.width).round());

      final img1 = s.decodeImage(compressedBaFile.readAsBytesSync());

      properties =
          await FlutterNativeImage.getImageProperties(fotoMeteran.path);
      File compressedMeteran = await FlutterNativeImage.compressImage(
          fotoMeteran.path,
          quality: 80,
          targetWidth: 600,
          targetHeight: (properties.height * 600 / properties.width).round());

      final img2 = s.decodeImage(compressedMeteran.readAsBytesSync());
      final imageRumah = PdfImage(
        pdf.document,
        image: img.data.buffer.asUint8List(),
        width: img.width,
        height: img.height,
      );
      final imageBa = PdfImage(
        pdf.document,
        image: img1.data.buffer.asUint8List(),
        width: img.width,
        height: img.height,
      );

      final imageMeteran = PdfImage(
        pdf.document,
        image: img2.data.buffer.asUint8List(),
        width: img.width,
        height: img.height,
      );
      pdf.addPage(Page(
          margin: EdgeInsets.only(top: 40.0, left: 4.0, right: 3.0),
          pageFormat: PdfPageFormat.a4,
          build: (Context context) {
            return Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(children: <Widget>[
                  Center(
                      child: Text("FILE LAPORAN",
                          style: TextStyle(
                              fontSize: 20, fontBold: Font.courierBold()))),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 180,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text("NIK Karyawan : ")),
                                      Container(
                                          padding: EdgeInsets.only(left: 0.8),
                                          width: 300,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text(data.nik))
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 180,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text("No Reg. SL : ")),
                                      Container(
                                          padding: EdgeInsets.only(left: 0.8),
                                          width: 300,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text(data.noregsl))
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 180,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text("Nama Pelanggan : ")),
                                      Container(
                                          padding: EdgeInsets.only(left: 0.8),
                                          width: 300,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text(data.namapelanggan))
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 180,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text("Alamat Pelanggan : ")),
                                      Container(
                                          padding: EdgeInsets.only(left: 0.8),
                                          width: 300,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text(data.alamat))
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 180,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text("Nomor Telepon : ")),
                                      Container(
                                          padding: EdgeInsets.only(left: 0.8),
                                          width: 300,
                                          decoration: BoxDecoration(
                                              border: BoxBorder(
                                                  top: true,
                                                  bottom: true,
                                                  left: true,
                                                  right: true)),
                                          child: Text(data.notelp))
                                    ]),
                              ])))
                ])); // Center
          })); // Page
      pdf.addPage(Page(build: (Context context) {
        return Center(
            child: Column(children: <Widget>[
          Center(
              child: Text("FOTO RUMAH",
                  style:
                      TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
          Image(imageRumah),
        ])); // Center
      }));
      pdf.addPage(Page(build: (Context context) {
        return Center(
            child: Column(children: <Widget>[
          Center(
              child: Text("FOTO BA",
                  style:
                      TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
          Image(imageBa),
        ])); // Center
      }));
      pdf.addPage(Page(build: (Context context) {
        return Center(
            child: Column(children: <Widget>[
          Center(
              child: Text("FOTO METERAN",
                  style:
                      TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
          Image(imageMeteran),
        ])); // Center
      })); // Page
      final output = await _requestExternalStorageDirectory;
      final file = File("${output.path}/report.pdf");
//final file = File("example.pdf");
      //await file.writeAsBytes(pdf.save());
      return await file.writeAsBytes(pdf.save());
    }
  }

  Future<Directory> get _requestExternalStorageDirectory async {
    final directory = await getExternalStorageDirectory();
    final newDir = directory.path + "/" + data.noregsl;
    Directory dir = new Directory(newDir);
    dir.createSync();
    return dir;
  }

  share(var path) async {
//final ByteData bytes = await File(path).b;
    final Uint8List bytes = File(path).readAsBytesSync();
    await Share.file('Bagikan File', 'report.pdf', bytes, 'application/pdf');
  }
}
