import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdam/Database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdam/pojo/User.dart';
import 'package:pdam/pojo/Data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
class ViewPage extends StatefulWidget {
  final User user;
  ViewPage({this.user});
  static String tag = "view_page";
  
  @override
  StatefulInputPage createState() => StatefulInputPage(user: user);
}

class StatefulInputPage extends State<ViewPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController ftRumahController = TextEditingController();
  final TextEditingController ftBAController = TextEditingController();
  final TextEditingController ftMeteranController = TextEditingController();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController notelpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController namaWM = TextEditingController();
  final User user;
  StatefulInputPage({this.user});
  File _imageRumah, _imageBA, _imageMeteran;
  Future getImageRumah(ImageSource img) async {
    var image = await ImagePicker.pickImage(source: img);
    setState(() {
      _imageRumah = image;
      if (_imageRumah != null) ftRumahController.text = "R" + idController.text;
    });
  }

  Future getImageBA(ImageSource img) async {
    var image = await ImagePicker.pickImage(source: img);
    setState(() {
      _imageBA = image;
      if (_imageBA != null) ftBAController.text = "BA" + idController.text;
    });
  }

  Future getImageMeteran(ImageSource img) async {
    var image = await ImagePicker.pickImage(source: img);
    setState(() {
      _imageMeteran = image;
      if (_imageMeteran != null)
        ftMeteranController.text = "Foto meteran berhasil diambil.";
    });
  }

  void ambilGambar(String x, ImageSource ims) {
    switch (x) {
      case "RUMAH":
        {
          getImageRumah(ims);
        }
        break;
      case "BA":
        {
          getImageBA(ims);
        }
        break;
      case "METERAN":
        {
          getImageMeteran(ims);
        }
        break;
    }
  }

  var _context;
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
    _context = context;
    final String RUMAH = "RUMAH";
    final String BA = "BA";
    final String METERAN = "METERAN";
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen =
        mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);  
    return MaterialApp(
      title: title,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("PDAM"),
          toolbarOpacity: 1,
          centerTitle: true,
          bottomOpacity: 1,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 9.0, bottom: 10.0),
          child: Table(children:[
            TableRow()
          ],) 
        ),
      ),
    );
  }

  Future choose(String type) async {
    if (idController.text.isEmpty) {
      Alert(
          context: _context,
          type: AlertType.error,
          title: "Lengkapi Semua Form Terlebih Dahulu",
          desc: "Kolom No. Reg. SL harus di isi terlebih dahulu.",
          buttons: [
            DialogButton(
              child: Text(
                "Tutup",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(_context);
              },
            ),
          ]).show();
    } else {
      Alert(
        context: _context,
        type: AlertType.none,
        title: "Sumber Gambar",
        desc:
            "Pilih sumber gambar, dari kamera smartphone atau galeri. Gambar yang diambil dari galeri biasanya sudah diambil terlebih dahulu dari aplikasi kamera",
        buttons: [
          DialogButton(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(_context);
              ambilGambar(type, ImageSource.camera);
            },
            color: Colors.lightBlue,
          ),
          DialogButton(
            child: Text(
              "Gallery",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            // onPressed: () => Navigator.pop(_context),
            onPressed: () {
              Navigator.pop(_context);
              ambilGambar(type, ImageSource.gallery);
            },
            color: Colors.lightBlue,
          )
        ],
      ).show();
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> save() async {
    if (_imageBA == null || _imageMeteran == null || _imageRumah == null) {
      throw ("Lengkapi foto yang diperlukan terlebih dahulu.");
    } else {
      //berati ini bisa

      final path = await _localPath;
      File newFileRumah =
          await _imageRumah.copy('$path/' + ftRumahController.text + '.jpg');
      File newFileBA =
          await _imageBA.copy('$path/' + ftBAController.text + '.jpg');
      File newFileMeteran = await _imageMeteran
          .copy('$path/' + idController.text + 'meteran' + '.jpg');
      Data d = Data(
          nik: user.id,
          namapelanggan: namaLengkapController.text,
          noregsl: idController.text,
          alamat: alamatController.text,
          notelp: notelpController.text,
          nometer: namaWM.text,
          fotorumah: newFileRumah.path,
          fotoba: newFileBA.path,
          fotometeran: newFileMeteran.path);

      DBProvider provider = DBProvider();
      Future da = provider.newData(d);
      da.then((onValue) {
        Flushbar(
          message:
              "Informasi berhasil disimpan.",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          borderRadius: 8,
          margin: EdgeInsets.all(8),
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      });
      //final File newImage = await _imageRumah.copy('$directory/image1.jpg');

    }
  }
}
