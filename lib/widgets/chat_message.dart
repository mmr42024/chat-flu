import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String value;
  final String uuid;
  final AnimationController animationController;

  const ChatMessage({
    super.key,
    required this.value,
    required this.uuid,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child: uuid == '123' ? _sourceMessage() : _destinationMessage(),
        ),
      ),
    );
  }

  Widget _sourceMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 60, right: 5),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _destinationMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 60),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
