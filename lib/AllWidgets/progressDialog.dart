// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black12,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 32, 32, 32),
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(width: 6.0),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(31, 240, 238, 238)),
              ),
              SizedBox(
                width: 26.0,
              ),
              Text(
                message,
                style: TextStyle(
                    color: Color.fromARGB(255, 253, 253, 253),
                    fontSize: 12.0,
                    fontFamily: "Brand-Regular"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
