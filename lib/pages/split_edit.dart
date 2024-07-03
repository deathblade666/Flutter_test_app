import 'dart:core';
import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:mdeditor/pages/menu.dart';
import 'package:mdeditor/pages/preview.dart';
import 'package:mdeditor/pages/textfield.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => editorState();
}

// ignore: camel_case_types
class editorState extends State<Editor> {
  String contents = '';

  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  void mdText(String value) {
    setState(() {
     contents = value;      
    });
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        toolbarHeight: 2,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Renderer(contents),
          ),
          Expanded(
            child: mdtextfield(ontextchanged: mdText),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             Container(
                padding: const EdgeInsets.only(right: 15),
                child: Menu(contents)
              ),
            ]
          ),
        ]
      ),
    );
  }
}
