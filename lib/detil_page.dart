import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdam/pojo/Data.dart';
import 'dart:io';
import 'package:pdam/pojo/Data.dart';
import 'package:flutter/services.dart';
import 'save_algorithm.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DetilPage extends StatefulWidget {
  final Data data;
  DetilPage({this.data});
  static String tag = "view_page";

  @override
  StatefulDetilPage createState() => StatefulDetilPage(fetchedData: data);
}

class StatefulDetilPage extends State<DetilPage> {
  final Data fetchedData;

  StatefulDetilPage({this.fetchedData});
  var title = "Lihat Data";
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    //FlushbarHelper.createInformation(title: "Lihat Rincian", message: "Untuk melihat informasil lebih rinci, klik pada salah satu data.", duration: Duration(seconds: 3)).show(context);
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Rincian Data'),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.nik,
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "NIK Pegawai"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.noregsl,
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "No. Registrasi SL"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.namapelanggan,
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Nama Pelanggan"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.alamat,
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Alamat"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.notelp,
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Telepon"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.nometer,
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Merk WM / No. Meter"),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: fetchedData.fotorumah == null
                            ? Image(
                                fit: BoxFit.cover,
                                key: Key("foto_rumah"),
                                width: 128,
                                height: 128,
                                image: AssetImage('graphics/addImage.png'),
                              )
                            : Image(
                                image: FileImage(File(fetchedData.fotorumah)),
                                width: 128,
                                height: 128,
                                fit: BoxFit.cover),
                      )),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.fotorumah.split(
                        "/")[fetchedData.fotorumah.split("/").length - 1],
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Foto Rumah"),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: fetchedData.fotoba == null
                            ? Image(
                                fit: BoxFit.cover,
                                key: Key("foto_ba"),
                                width: 128,
                                height: 128,
                                image: AssetImage('graphics/addImage.png'),
                              )
                            : Image(
                                image: FileImage(File(fetchedData.fotoba)),
                                width: 128,
                                height: 128,
                                fit: BoxFit.cover),
                      )),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.fotoba
                        .split("/")[fetchedData.fotoba.split("/").length - 1],
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Foto BA"),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: fetchedData.fotometeran == null
                            ? Image(
                                fit: BoxFit.cover,
                                key: Key("foto_meteran"),
                                width: 128,
                                height: 128,
                                image: AssetImage('graphics/addImage.png'),
                              )
                            : Image(
                                image: FileImage(File(fetchedData.fotometeran)),
                                width: 128,
                                height: 128,
                                fit: BoxFit.cover),
                      )),
                  TextFormField(
                    autocorrect: false,
                    initialValue: fetchedData.fotometeran.split(
                        "/")[fetchedData.fotometeran.split("/").length - 1],
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        labelText: "Foto BA"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Center(
                      child: FlatButton.icon(
                        label: Text(
                          "Simpan PDF",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        icon: Icon(Icons.save),
                        padding: EdgeInsets.all(12.0),
                        color: Colors.lightBlue,
                        onPressed: () {
                          
                          SavePDF save = SavePDF();
                          var pr = ProgressDialog(context);
                          pr = new ProgressDialog(context,
                              type: ProgressDialogType.Normal,
                              isDismissible: false,
                              showLogs: false);

                          pr.style(
                              message: 'Downloading file...',
                              borderRadius: 10.0,
                              backgroundColor: Colors.white,
                              progressWidget: CircularProgressIndicator(),
                              elevation: 10.0,
                              insetAnimCurve: Curves.easeInOut,
                              progress: 0.0,
                              maxProgress: 100.0,
                              progressTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                              messageTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600));
                          pr.show();
                          save.save(fetchedData).then((onValue) {
                            pr.hide().then((isHidden) {
                              save.share(onValue.path);
                              print(isHidden);
                            });
                          }).catchError((onError) {
                            pr.hide();
                            FlushbarHelper.createError(title: "Kesalahan",message: onError);
                            print(onError.toString());
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
