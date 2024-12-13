import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          spacing: 20,
          children: [
            Image(
              image: AssetImage('assets/tag-logo.png'),
              width: 170,
            ),
            Text(title, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
