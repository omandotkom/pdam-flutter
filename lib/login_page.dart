import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:pdam/home_page.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:pdam/Database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:pdam/pojo/User.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

User user;

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController(text: "user1");
  final passController = TextEditingController(text: "system3298");
  final newIDController = TextEditingController();
  final newPassController = TextEditingController();
  ProgressDialog pr;
  final TextEditingController masterPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DBProvider db = new DBProvider();
    db.initDB();
    final logo = Hero(
      tag: 'pdam',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 90.0,
        child: Image.asset('graphics/logopdam.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.text,
      controller: idController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(120.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 0.2,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(10.0)),
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            //Navigator.of(context).pushNamed(HomePage.tag);
            //fetchPost();

            DBProvider dbProvider = DBProvider();
            dbProvider
                .login(user =
                    User(id: idController.text, password: passController.text))
                .then((val) {
              //buat ganti halaman
              // Navigator.of(context).pushNamed(HomePage.tag);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          user: val,
                        )),
              );
            }).catchError((onError) {
              var alertStyle = AlertStyle(
                animationType: AnimationType.fromTop,
                isCloseButton: false,
                isOverlayTapDismiss: false,
                descStyle: TextStyle(fontWeight: FontWeight.bold),
                animationDuration: Duration(milliseconds: 800),
                alertBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                titleStyle: TextStyle(
                  color: Colors.black45,
                ),
              );
              Alert(
                  context: context,
                  style: alertStyle,
                  type: AlertType.error,
                  title: "Gagal Login",
                  desc: onError.toString(),
                  buttons: [
                    DialogButton(
                      color: Colors.deepOrange,
                      onPressed: () => Navigator.pop(context),
                      child: Text("Tutup",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    )
                  ]).show();
            });
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Daftarkan Pengguna',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
            /*   DBProvider db = new DBProvider();
         db.newClient(User(id: "user1",
         password : "system3298"));
    */
        Alert(
            style: AlertStyle(
              animationType: AnimationType.fromBottom,
              isCloseButton: true,
              isOverlayTapDismiss: false,
              descStyle: TextStyle(fontWeight: FontWeight.bold),
              animationDuration: Duration(seconds: 1),
              alertBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            context: context,
            title: "Masukkan Master Password",
            content: Column(
              children: <Widget>[
                Text(
                  "Master Password adalah password utama yang digunakan untuk mengakses fitur pembuatan User baru pada aplikasi ini",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: masterPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (masterPass.text != "150498") {
                    //passwrong
                    FlushbarHelper.createError(
                            title: "Gagal",
                            message: "Master Password yang Anda Masukkan Salah",
                            duration: Duration(seconds: 3))
                        .show(context);
                  } else {
                    //pass correct
                    Alert(
                        style: AlertStyle(
                          animationType: AnimationType.fromBottom,
                          isCloseButton: true,
                          isOverlayTapDismiss: false,
                          descStyle: TextStyle(fontWeight: FontWeight.bold),
                          animationDuration: Duration(seconds: 1),
                          alertBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        context: context,
                        title: "Pendaftaran Pengguna",
                        content: Column(
                          children: <Widget>[
                            Text(
                              'Masukkan NIK dan Password untuk Pengguna Lapangan yang Akan Menggunakan Aplikasi Ini.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                            TextField(
                              controller: newIDController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.account_circle),
                                labelText: 'NIK',
                              ),
                            ),
                            TextField(
                              controller: newPassController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Password',
                              ),
                            ),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              Navigator.pop(context);
                              DBProvider db = new DBProvider();
                              db
                                  .newClient(User(
                                      id: newIDController.text,
                                      password: newPassController.text))
                                  .then((res) {
                                FlushbarHelper.createSuccess(
                                        message:
                                            "Berhasil mendaftarkan pengguka",
                                        title: "Sukses",
                                        duration: Duration(seconds: 2))
                                    .show(context);
                              });
                            },
                            child: Text(
                              "DAFTARKAN",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ]).show();
                  }
                },
                child: Text(
                  "LANJUTKAN",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
