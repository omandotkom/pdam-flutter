import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as gambar;
import 'package:pdam/Database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdam/pojo/User.dart';
import 'package:pdam/pojo/Data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:permission_handler/permission_handler.dart';
class InputPage extends StatefulWidget {
  final User user;
  InputPage({this.user});
  static String tag = "input_page";
  @override
  StatefulInputPage createState() => StatefulInputPage(user: user);
}

class StatefulInputPage extends State<InputPage> {
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
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                autocorrect: false,
                controller: idController,

                decoration: InputDecoration(
                    hintText: "0219040692",
                    hintStyle: TextStyle(fontSize: 12),
                    labelText: "No. Reg. SL"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                autocorrect: false,
                controller: namaLengkapController,
                decoration: InputDecoration(
                    hintText: "Miftahul Pangestu",
                    hintStyle: TextStyle(fontSize: 12),
                    labelText: "Nama Pelanggan"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                autocorrect: false,
                controller: alamatController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Perumahan xxxx xxxxx",
                    hintStyle: TextStyle(fontSize: 12),
                    labelText: "Alamat"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                autocorrect: false,
                controller: notelpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "021 9635575",
                    hintStyle: TextStyle(fontSize: 12),
                    labelText: "No. Telepon"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                controller: namaWM,
                decoration: InputDecoration(
                    hintText: "03312",
                    hintStyle: TextStyle(fontSize: 12),
                    labelText: "No. Meter"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    child: _imageRumah == null
                        ? Image(
                            fit: BoxFit.cover,
                            key: Key("foto_rumah"),
                            width: 64,
                            height: 64,
                            image: AssetImage('graphics/addImage.png'),
                          )
                        : Image(
                            image: FileImage(_imageRumah),
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover),
                    onTap: () => choose("RUMAH"),
                  )),
              TextFormField(
                autocorrect: false,
                enabled: false,
                controller: ftRumahController,
                decoration: InputDecoration(labelText: "Foto Rumah"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    child: _imageBA == null
                        ? Image(
                            fit: BoxFit.cover,
                            key: Key("foto_BA"),
                            width: 64,
                            height: 64,
                            image: AssetImage('graphics/addImage.png'),
                          )
                        : Image(
                            image: FileImage(_imageBA),
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover),
                    onTap: () => choose("BA"),
                  )),
              TextFormField(
                autocorrect: false,
                enabled: false,
                controller: ftBAController,
                decoration: InputDecoration(labelText: "Foto BA"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    child: _imageMeteran == null
                        ? Image(
                            fit: BoxFit.cover,
                            key: Key("foto_meteran"),
                            width: 64,
                            height: 64,
                            image: AssetImage('graphics/addImage.png'),
                          )
                        : Image(
                            image: FileImage(_imageMeteran),
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover),
                    onTap: () => choose("METERAN"),
                  )),
              TextFormField(
                autocorrect: false,
                enabled: false,
                controller: ftMeteranController,
                decoration: InputDecoration(labelText: "Foto Meteran"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: FlatButton.icon(
                    color: Colors.lightBlue,
                    icon: Icon(Icons.save,
                        color: Colors.white), //`Icon` to display
                    label: Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ), //`Text` to display
                    onPressed: () {
                      save();
                    },
                  ),
                ),
              )
            ],
          ),
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
   
   Future<String> get _requestExternalStorageDirectory async{
      final List<PermissionGroup> permissions = <PermissionGroup>[PermissionGroup.storage];
     final Map<PermissionGroup, PermissionStatus>permissionRequestResult = await PermissionHandler().requestPermissions(permissions);
    final directory = await getExternalStorageDirectory();
    final newDir = directory.path + "/" + idController.text;
    Directory dir = new Directory(newDir);
    dir.createSync();
    return dir.path;
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

      //final path = await _localPath;
      final path = await _requestExternalStorageDirectory;
      
      File newFileRumah = 
          await _imageRumah.copy('$path/' + ftRumahController.text + '.jpg');
          print(newFileRumah.path);
           //_imageRumah.deleteSync();
      File newFileBA = 
          await _imageBA.copy('$path/' + ftBAController.text + '.jpg');
           //_imageBA.deleteSync();
      File newFileMeteran = await _imageMeteran
          .copy('$path/' + idController.text + 'meteran' + '.jpg');
         // _imageMeteran.deleteSync();
          
          //testCompressAndGetFile(newFileRumah, newFileRumah.path);
          //testCompressAndGetFile(newFileBA, newFileBA.path);
          //testCompressAndGetFile(newFileMeteran, newFileMeteran.path);

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
