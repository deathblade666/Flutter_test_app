import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 enum menuItems {
  save, 
  open,
  fileInfo,
  close,
  switchTheme,
  switchView,
  enableWorkCount,
  }

//TODO: Implement new functions
// Save
//   - Fix crash on save
// Open function
//   - Load file value in textfield
// function and widget for file info
// function for theme control
// function to change view modes
// function to enable persistent word counter


  String filePath = '';
  void closeApp({bool? animated}) async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    final filePicked = result.files;
    final path = filePicked.first.path.toString();
    final file = File(path);
    filePath = path;
    final fileContent = await file.readAsString();
    final value = fileContent;
    print(value);
    print(filePath);
    
  }

  void saveFile() async {
    //String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    // ignore: unused_local_variable
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'output-file.pdf',
    );
  } 

class Menu extends StatelessWidget {
  const Menu(this.value,{super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: const EdgeInsets.only(left: 5),
      elevation: 0,
      color: Theme.of(context).highlightColor,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<menuItems>>[
        const PopupMenuItem<menuItems>(
          value: menuItems.save,
          onTap: saveFile,
          child: Text("Save"),
        ),
        const PopupMenuItem<menuItems>(
          value: menuItems.open,
          onTap: pickFile,
          child: Text("Open"),
        ),
        const PopupMenuItem<menuItems>(
          value: menuItems.fileInfo,
          //onSelect: showFileInfo,
          child: Text("File Info"),
        ),
        const PopupMenuItem<menuItems>(
          value: menuItems.close,
          onTap: closeApp,
          child: Text("Close"),
        ),
        const PopupMenuItem<menuItems>(
          value: menuItems.switchView,
          //onSelect: switchViewMode,
          child: Text("Switch Mode"),
        ),
        const PopupMenuItem<menuItems>(
          value: menuItems.switchTheme,
          //onSelect: switchTheme,
          child: Text("Change Theme"),
        ),   
      ]
    );
  }
}