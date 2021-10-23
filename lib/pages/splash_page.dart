import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...',
            style: TextStyle(
              fontSize: 20,
            )),
      ),
    );
  }
}
