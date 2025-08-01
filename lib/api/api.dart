import 'dart:convert';


import '../constants.dart';
import '../models/movie.dart';
import 'package:http/http.dart'as http;


class Api{
  static const _trendingUrl ='https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apikey}';
  static const _topRatedUrl ='https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apikey}';
  static const _upcomingUrl ='https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apikey}';

  static const _searchUrl ='https://api.themoviedb.org/3/movie/search?api_key=${Constants.apikey}';

  Future<List<Movie>> getTrendingMovies() async{
    final response = await http.get(Uri.parse(_trendingUrl));
    if(response.statusCode==200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');
    }

  }

  Future<List<Movie>> getTopRatedMovies() async{
    final response = await http.get(Uri.parse(_topRatedUrl));
    if(response.statusCode==200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');
    }

  }
  Future<List<Movie>> getUpcomingMovies() async{
    final response = await http.get(Uri.parse(_upcomingUrl));
    if(response.statusCode==200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');
    }

  }
  Future<List<Movie>> getSearchMovies(String query) async {
    final Uri searchUri = Uri.parse('$_searchUrl&query=$query');
    final response = await http.get(searchUri);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

}