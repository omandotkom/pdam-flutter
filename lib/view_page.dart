import 'dart:io';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdam/Database.dart';
import 'package:pdam/detil_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdam/pojo/User.dart';
import 'package:pdam/pojo/Data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:pdam/Database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/scheduler.dart';

class ViewPage extends StatefulWidget {
  final User user;
  ViewPage({this.user});
  static String tag = "view_page";

  @override
  StatefulViewPage createState() => StatefulViewPage(user: user);
}

class StatefulViewPage extends State<ViewPage> {
  final User user;
  List<Data> items = new List();
  DBProvider db = new DBProvider();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp
     ]);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Flushbar(
          title: "Lihat Rincian",
          margin: new EdgeInsets.only(left: 2.1, right: 2.1),
          borderRadius: 8.0,
          duration: Duration(seconds: 3),
          message:
              "Untuk melihat rincian data, cukup klik pada salah satu data",
          animationDuration: Duration(seconds: 2),
          dismissDirection: FlushbarDismissDirection.VERTICAL,
          leftBarIndicatorColor: Colors.blue[300],
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          )).show(context);
    });
    db.getAlllData().then((datas) {
      setState(() {
        datas.forEach((datas) {
          items.add(Data.fromJson(datas));
        });
      });
    });
  }

  StatefulViewPage({this.user});
  var title = "Lihat Data";
  var _context;
  @override
  Widget build(BuildContext context) {
    //FlushbarHelper.createInformation(title: "Lihat Rincian", message: "Untuk melihat informasil lebih rinci, klik pada salah satu data.", duration: Duration(seconds: 3)).show(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lihat Data'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.blueAccent)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Data oleh " + user.id),
                          ),
                          ListTile(
                            title: TextFormField(
                              initialValue: '${items[position].noregsl}',
                              readOnly: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                              autocorrect: false,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  labelText: "No. Reg. SL"),
                              // The validator receives the text that the user has entered.
                            ),
                            subtitle: TextFormField(
                              initialValue: '${items[position].namapelanggan}',
                              readOnly: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                              autocorrect: false,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  labelText: "Nama Pelanggan"),
                              // The validator receives the text that the user has entered.
                            ),
                            //onTap: () => _navigateToNote(context, items[position]),
                          ),
                          FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      width: 0.6, color: Colors.grey)),
                              label: Text(
                                "Rincian",
                                style: (TextStyle(fontSize: 12)),
                              ),
                              onPressed: () =>
                                  _navigateToNote(context, items[position]),
                              icon: Icon(Icons.more))
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, Data note, int position) async {
    /* db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });*/
  }
  void _navigateToNote(BuildContext context, Data data) async {
    db.getCompleteData(data).then((onValue) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetilPage(
                  data: onValue,
                )),
      );
    });

    /* String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );
 
    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }*/
  }
}
