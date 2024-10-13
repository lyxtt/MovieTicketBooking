
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/firebase_options.dart';

class MyFirebaseConnect extends StatefulWidget {
  final String errorMessage;
  final String connectingMessage;
  final Widget Function(BuildContext context) builder;

  const MyFirebaseConnect({
    Key? key,
    required this.errorMessage,
    required this.connectingMessage,
    required this.builder,
  }) : super(key: key);

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool loi = false;
  bool ketNoi = false;
  @override
  Widget build(BuildContext context) {
    if(loi) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Trang chủ"),
        ),
        body: Center(
          child: Text(widget.errorMessage),
        ),
      );
    } else if(ketNoi==false){
      return Scaffold(
        appBar: AppBar(
          title: Text("Trang chủ"),
        ),
        body: Center(
          child: Row(
            children: [
              Text(widget.connectingMessage),
              SizedBox(width: 30,),
              CircularProgressIndicator()
            ]
          ),
        ),
      );
    }
    else{
      return widget.builder(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase(){
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
        setState(() {
          ketNoi = true;
        });
      }).catchError((onError){
        setState(() {
          loi = true;
        });
      }).whenComplete(() => print("Hoàn tất kết nối firebase"));
  }
}
