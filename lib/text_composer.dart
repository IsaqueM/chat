import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Textcomposer extends StatefulWidget {

  Textcomposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;



  @override
  _TextcomposerState createState() => _TextcomposerState();
}

class _TextcomposerState extends State<Textcomposer> {

  final TextEditingController controller = TextEditingController();

  bool isComposing = false;

  void _reset(){
    controller.clear();
    setState(() {
      isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile =
                await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text){
                setState(() {
                  isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text){
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.lightBlue,),
            onPressed: isComposing ?(){
              widget.sendMessage(text: controller.text);
              controller.clear();
              _reset();
            } : null,
          )
        ],
      )
    );
  }
}
