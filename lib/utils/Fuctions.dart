import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class Functions {
  static void showCustomSnackBar({
    String text,
    bool hasIcon,
    IconData iconType,
    BuildContext context,
    Color iconColor,
  }) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          hasIcon ? Icon(
                  iconType,
                  color: iconColor,
                )
              : Container(height: 22.0,),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
      ),
    ));
  }

   static Future<File> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final String fileName = pickedFile.path.split('/').last;

      final imageFile = await MultipartFile.fromPath('file',pickedFile.path,
          filename: fileName,
          contentType: MediaType('image', fileName.split('.').last));

      return File(pickedFile.path);
      // setState(() {
      //   _editAccountInfo['image'] = imageFile;
      //   image = File(pickedFile.path);
      // });
    } else {
      return null;
    }

  }


}
