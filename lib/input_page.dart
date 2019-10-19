import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

class InputPage extends StatelessWidget {
  static String tag = "input_page";

  var _context;
  Future getImage(ImageSource img) async {
    var image = await ImagePicker.pickImage(source: img);

    return image;
  }

  FocusNode myFocusNode;

  var idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();
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
          padding: const EdgeInsets.only(left: 9.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
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
              TextFormField(
                autocorrect: false,
                enabled: false,
                decoration: InputDecoration(labelText: "Foto Rumah"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => choose(RUMAH),
              ),
              TextFormField(
                autocorrect: false,
                enabled: false,
                decoration: InputDecoration(labelText: "Foto BA"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => choose(RUMAH),
                padding: EdgeInsets.only(bottom: 0.0),
              ),
              TextFormField(
                autocorrect: false,
                enabled: false,
                decoration: InputDecoration(labelText: "Foto Meteran"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => choose(RUMAH),
                padding: EdgeInsets.only(bottom: 0.0),
              ),
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
              getImage(ImageSource.camera).then((result) {
                print(result.toString());
              });
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
              getImage(ImageSource.gallery).then((result) {
                print(result.toString());
              });
            },
            color: Colors.lightBlue,
          )
        ],
      ).show();
    }
  }
}
