import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  static String tag = "home_page";
  @override
  Widget build(BuildContext context) {
    final title = 'Home';
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen =
        mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;

    return MaterialApp(
      title: title,
      home: Scaffold(appBar: AppBar(title: Text("PDAM"),toolbarOpacity: 1,centerTitle: true,
      bottomOpacity: 1,),
        backgroundColor: Colors.white,
        body: GridView.count(
          childAspectRatio: (widthScreen / heightScreen) * 3.5,
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 1,
          // Generate 100 widgets that display their index in the List.
          children: <Widget>[
            GestureDetector(
              onTap: (){
                print("lihat data clicked");
              },
              child:  Container(
                  padding: new EdgeInsets.all(10),
                  decoration: boxDecoration(),
                  margin: new EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain, // otherwise the logo will be tiny
                          child:
                          Icon(Icons.create, color: Colors.lightBlueAccent),
                        ),
                      ),
                      Text('Tambah Data'),
                      Text('sample deskripsi untuk mendambahkan data',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12)),
                    ],
                  )),
            ),

            Container(
                decoration: boxDecoration(),
                padding: new EdgeInsets.all(10),
                margin: new EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain, // otherwise the logo will be tiny
                        child: Icon(Icons.view_agenda,
                            color: Colors.lightBlueAccent),
                      ),
                    ),
                    Text('Lihat Data'),
                    Text('sample deskripsi untuk melihat data',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12)),
                  ],
                )),Container(
                decoration: boxDecoration(),
                padding: new EdgeInsets.all(10),
                margin: new EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain, // otherwise the logo will be tiny
                        child: Icon(Icons.exit_to_app,
                            color: Colors.deepOrange),
                      ),
                    ),
                    Text('Keluar'),
                    Text('sample deskripsi untuk keluar data',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12)),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.lightBlue, width: 0.8),
      borderRadius:
          BorderRadius.all(Radius.circular(8) //         <--- border radius here
              ),
    );
  }
}
