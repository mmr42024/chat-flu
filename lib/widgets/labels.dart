import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String textInfo1;
  final String textInfo2;

  const Labels({
    super.key,
    required this.ruta,
    required this.textInfo1,
    required this.textInfo2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(textInfo1,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            )),
        GestureDetector(
            child: Text(
              textInfo2,
              style: TextStyle(
                color: Colors.blue.shade600,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            })
      ],
    );
  }
}
