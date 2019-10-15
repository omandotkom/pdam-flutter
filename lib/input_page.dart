import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InputPage extends StatelessWidget {
  static String tag = "input_page";
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
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
            padding:   const EdgeInsets.all(8),
            child : Form(
          child: Column(

            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                autocorrect: false,
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
                decoration: InputDecoration(
                    labelText: "Foto Rumah"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              IconButton(icon: Icon(Icons.photo_camera))
            ],
          ),
        )),
      ),
    );
  }

}
