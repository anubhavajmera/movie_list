import 'package:hive/hive.dart';
import 'model/movie.dart';

class Boxes {
  static Box<Movie> getMovies() => Hive.box<Movie>('movies');
}
