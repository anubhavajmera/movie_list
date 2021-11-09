import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/MovieItem.dart';
import 'package:movie_list/boxes.dart';
import 'model/movie.dart';

class MovieAdd extends StatefulWidget {
  const MovieAdd({Key? key}) : super(key: key);

  @override
  _MovieAddState createState() => _MovieAddState();
}

class _MovieAddState extends State<MovieAdd> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController directorController = new TextEditingController();
  late String filePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Movie"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name of the movie'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: directorController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Director of the movie'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path.toString());
                  filePath = file.path;
                } else {
                  // User canceled the picker
                }
              },
              child: Row(
                children: [Text("Select Image")],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          filePath.isEmpty
              ? Icon(Icons.add, size: 30, color: Colors.grey)
              : Image.file(
                  File(filePath),
                  width: 200,
                  height: 200,
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                final box = Boxes.getMovies();
                box.put(
                    nameController.text,
                    new Movie(nameController.text, directorController.text,
                        filePath));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Save'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
