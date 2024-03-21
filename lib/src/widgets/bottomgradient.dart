import 'package:flutter/cupertino.dart';

class BottomGradient extends StatelessWidget {
  final double offset;

  const BottomGradient({super.key, this.offset = 0.95});

  const BottomGradient.noOffset({super.key}) : offset = 1.0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            end: const FractionalOffset(0.0, 0.0),
            begin: FractionalOffset(0.0, offset),
            colors: const <Color>[
              Color(0xff222128),
              Color(0x442C2B33),
              Color(0x002C2B33)
            ],
          )),
    );
  }
}