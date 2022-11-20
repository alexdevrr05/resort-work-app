import 'package:flutter/material.dart';

class ProfileInput extends StatelessWidget {
  final String labelText;
  final String inputText;

  ProfileInput(this.labelText, this.inputText);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Container(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          labelText,
                          style: TextStyle(
                               fontSize: 17, color: Colors.grey.shade300),
                        ),
                        padding: EdgeInsets.only(top: 15, bottom: 5),
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10))
          ],
        ));
  }
}
