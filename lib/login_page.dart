import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdam/User.dart';
import 'package:pdam/home_page.dart';
import 'ALLURL.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final passController = TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
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
            login();
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        login();
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
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

  void login() {
    //show loading dialog
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: 'Memproses...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.bounceIn,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
    );
    pr.show();

    fetchPost().then((val) {
      if (pr.isShowing()) {
        pr.dismiss();
      }
      Fluttertoast.showToast(
          msg: "Selamat datang " + val.userId,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.transparent,
          textColor: Colors.black,
          fontSize: 12.0);
      Navigator.of(context).pushNamed(HomePage.tag);
      //then simpan ke save storage
    }).catchError((onError) {
      print(onError.toString());
      pr.dismiss();
      var alertStyle = AlertStyle(
        animationType: AnimationType.shrink,
        isCloseButton: true,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
      );
      Alert(
        context: context,
        type: AlertType.error,
        style: alertStyle,
        title: "Login Gagal",
        desc: "Username atau password salah",
        buttons: [
          DialogButton(
            child: Text(
              "Tutup",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    });
  }

  Future<User> fetchPost() async {
    var response = await http.post(ALLURL.loginURL,
        body: {'id': idController.text, 'password': passController.text});

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print(response);
      return User.fromJson(json.decode(response.body));
      pr.dismiss();
    } else if (response.statusCode == 401) {
      //throw Exception("Username atau password anda salah");
      return Future.error("Username atau password anda salah");
      //  pr.dismiss();
      throw ("Username atau password Anda salah, silahkan diperiksa kembali.");
      //throw Exception('Failed to load post');
    } else {
      // pr.dismiss();
      //throw Exception("Tidak tersambung ke server");
      return Future.error("Gagal tersambung ke server");
    }
  }
}
