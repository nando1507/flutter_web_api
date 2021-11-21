import 'package:flutter/material.dart';

const String _carregando = 'Loading';

class Progress extends StatelessWidget {
  final String message;
  Progress({this.message = 'Loading', Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Text(message),
        ],
      ),
    );
  }
}
