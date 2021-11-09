import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_list/MovieEdit.dart';

import 'boxes.dart';

class MovieItem extends StatefulWidget {
  final String name, director, image;
  const MovieItem(
      {Key? key,
      required this.name,
      required this.director,
      required this.image})
      : super(key: key);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: FileImage(File(widget.image)),
                radius: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(widget.name),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieEditPage(
                          movie: MovieItem(
                            name: widget.name,
                            director: widget.director,
                            image: widget.image,
                          ),
                        ))),
                child: Icon(Icons.create_rounded),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  final box = Boxes.getMovies();
                  box.delete(widget.name);
                },
                child: Icon(Icons.delete_rounded),
              ),
            ],
          )
        ],
      ),
    );
  }
}
