import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
          hasIcon
              ? Icon(
                  iconType,
                  color: iconColor,
                )
              : Container(
                  height: 22.0,
                ),
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
        final ImagePicker _picker = ImagePicker();

    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final String fileName = pickedFile.path.split('/').last;

      final imageFile = await MultipartFile.fromPath('file', pickedFile.path,
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

  static Future<List<File>> pickMultipleImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      return result != null
          ? (result.paths.map((path) => File(path)).toList())
          : null;
    } catch (err) {
      return null;
    }
  }
}
