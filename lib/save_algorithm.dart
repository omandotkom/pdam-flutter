import 'package:flutter/material.dart' as material;
import 'package:pdf/widgets.dart';
import 'package:pdam/pojo/Data.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as s;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
class SavePDF {
    
  Future<File> save(Data data) async {
    if (data == null) {
      throw ("Data is empty!");
    } else {
      final pdf = Document(title: "LAPORAN TITLE");
    final img = s.decodeImage(File(data.fotorumah).readAsBytesSync());
    final img1 = s.decodeImage(File(data.fotoba).readAsBytesSync());
    final img2 = s.decodeImage(File(data.fotometeran).readAsBytesSync());
final imageRumah = PdfImage(
  pdf.document,
  image: img.data.buffer.asUint8List(),
  width: img.width,
  height: img.height,
);
final imageBa = PdfImage(
  pdf.document,
  image: img1.data.buffer.asUint8List(),
  width: img1.width,
  height: img1.height,
);

final imageMeteran = PdfImage(
  pdf.document,
  image: img2.data.buffer.asUint8List(),
  width: img2.width,
  height: img2.width,
);
      pdf.addPage(Page(
        margin: EdgeInsets.only(top:40.0, left: 4.0, right: 3.0),
          pageFormat: PdfPageFormat.a4,
          build: (Context context) {
            return Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(children: <Widget>[
                
                Center(child: Text("FILE LAPORAN",style: TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
                Padding(padding: EdgeInsets.only(left: 20.0, top : 20.0),
                child : Align(alignment: Alignment.bottomLeft,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  
                  children : <Widget>[Text("NIK Karyawan : " + data.nik),
                SizedBox(height: 10.0),
                Text("NO. REG SL : " + data.noregsl),
                SizedBox(height: 10.0),
                Text("Nama Pelanggan : " + data.namapelanggan),
                SizedBox(height: 10.0),
                Text("Alamat Pelanggan : " + data.alamat),
                SizedBox(height: 10.0),
                Text("Nomor Telepon : " + data.notelp),
            
                
                ] )
                ))
              ]
              ),
            ); // Center
          })); // Page
          pdf.addPage(Page(
    build: (Context context) {
      return Center(
        child: Column(children: <Widget>[
          Center(child: Text("FOTO RUMAH",style: TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
Image(imageRumah),
        ])
      ); // Center
    }));
         pdf.addPage(Page(
    build: (Context context) {
      return Center(
        child: Column(children: <Widget>[
          Center(child: Text("FOTO BA",style: TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
Image(imageBa),
        ])
      ); // Center
    })); 
         pdf.addPage(Page(
    build: (Context context) {
      return Center(
        child: Column(children: <Widget>[
          Center(child: Text("FOTO METERAN",style: TextStyle(fontSize: 20, fontBold: Font.courierBold()))),
Image(imageMeteran),
        ])
      ); // Center
    }));  // Page
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/oman.pdf");
//final file = File("example.pdf");
      await file.writeAsBytes(pdf.save());
      return file;
    }
  }
  share(var path) async{
//final ByteData bytes = await File(path).b;
final Uint8List bytes = File(path).readAsBytesSync();
await Share.file('Bagikan File', 'report.pdf', bytes, 'application/pdf');
  }
}
