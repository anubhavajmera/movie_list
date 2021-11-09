import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'MovieItem.dart';
import 'boxes.dart';
import 'model/movie.dart';

class MovieEditPage extends StatefulWidget {
  final MovieItem movie;
  const MovieEditPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieEditPageState createState() => _MovieEditPageState();
}

class _MovieEditPageState extends State<MovieEditPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController directorController = new TextEditingController();

  late String name;
  late String director;

  @override
  void initState() {
    name = widget.movie.name;
    director = widget.movie.director;
    nameController.text = widget.movie.name;
    directorController.text = widget.movie.director;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String oldName = widget.movie.name;
    String filePath = widget.movie.image;

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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name of the movie'),
              initialValue: widget.movie.name,
              onChanged: (e) {
                name = e;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Director of the movie'),
              initialValue: widget.movie.director,
              onChanged: (e) {
                director = e;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path.toString());
                filePath = file.path;
              } else {
                // User canceled the picker
              }
            },
            child: Text("Select Image"),
          ),
          SizedBox(
            height: 20,
          ),
          Image.file(
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
              style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith<double?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return 16;
                  return null;
                }),
              ),
              onPressed: () {
                final box = Boxes.getMovies();
                box.delete(oldName);
                box.put(name, new Movie(name, director, filePath));
                Navigator.of(context).pop();
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
