import 'package:flutter/material.dart';
import '../api/api.dart';
import '../colors.dart';
import '../models/movie.dart';
import '../widgets/Bottom_Nav_Bar.dart';
import '../widgets/MovieCard.dart';

class TrendingMoviesPage extends StatefulWidget {
  const TrendingMoviesPage({Key? key}) : super(key: key);

  @override
  _TrendingMoviesPageState createState() => _TrendingMoviesPageState();
}

class _TrendingMoviesPageState extends State<TrendingMoviesPage> {
  late Future<List<Movie>> _trendingMovies;

  @override
  void initState() {
    super.initState();
    _trendingMovies = Api().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trending Movies',
          style: TextStyle(color: Colors.white), // Modern white text
        ),
        backgroundColor:Colors.blue, // Customize app bar color
        elevation: 0.0, // Remove app bar shadow for a clean look
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BottomNavBar()),);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding
          child: FutureBuilder<List<Movie>>(
            future: _trendingMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final List<Movie> movies = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two cards per row
                    mainAxisSpacing: 20.0, // Increase spacing between rows
                    crossAxisSpacing: 16.0, // Increase spacing between cards
                    childAspectRatio: 0.6, // Adjust aspect ratio for card size
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(movie: movie);
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
