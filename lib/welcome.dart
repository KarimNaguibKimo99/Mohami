import 'package:flutter/material.dart';
import 'package:user/Sign/sign.dart';

class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    getHome();
  }

  void getHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Sign()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/loading.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: Column(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'images/mohami.png',
                    width: 220,
                    height: 220.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 64.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    height: 30,
                    width: 140,
                    alignment: Alignment.center,
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
