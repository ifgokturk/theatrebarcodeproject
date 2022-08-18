//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:theatrebarcodeproject/screens/homepage.dart';
import 'model/Seanslar.dart';
import 'model/biletbilgileri.dart';

//selam
void main() => runApp(MyApp());
List<SeansList> seansList = [];
List<BiletBilgileri> biletlist = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Bilet Takip Uygulaması';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          // TODO: burada hata verdi
          //    resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: const Text(appTitle),
            backgroundColor: Colors.lightBlueAccent[700],
          ),
          body: SingleChildScrollView(child: MyCustomForm()),
          backgroundColor: Colors.white),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<State> _keyLoader = GlobalKey<State>();

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

//  BiletBilgileri _biletBilgileri;
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // // mainAxisAlignment: MainAxisAlignment.start, //dikeyde ortalar
          children: const <Widget>[
            TiyatroSeanslar(),
          ],
        ),
      ),
    );
  }
}
