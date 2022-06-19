import 'package:flutter/material.dart';

class WaitingCircle extends StatelessWidget {
  const WaitingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          strokeWidth: 5,
        ),
      ),
    );
  }
}
