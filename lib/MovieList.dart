import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_list/MovieItem.dart';
import 'package:movie_list/boxes.dart';

import 'MovieAdd.dart';
import 'model/movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  buildContent(List<Movie> movieList) {
    return ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return MovieItem(
              name: movieList[index].name,
              director: movieList[index].director,
              image: movieList[index].image);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie List"),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MovieAdd()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: ValueListenableBuilder<Box<Movie>>(
        valueListenable: Boxes.getMovies().listenable(),
        builder: (context, box, _) {
          final movie = box.values.toList().cast<Movie>();
          return buildContent(movie);
        },
      ),
    );
  }
}
