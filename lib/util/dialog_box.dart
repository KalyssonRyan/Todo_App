import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:todo/util/my_button.dart";

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
 DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container( 
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Onde o usuario adiciona
            TextField(
              controller:controller,
              decoration: InputDecoration(border: OutlineInputBorder(),),
              
            ),

            //butoes save + cancel
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              
              children: [
                MyButton(text: 'Save', onPressed: onSave),
                
                MyButton(text: 'Cancel', onPressed: onCancel),
              ],
            )



          ]
        ),
      ),
    );
  }
}