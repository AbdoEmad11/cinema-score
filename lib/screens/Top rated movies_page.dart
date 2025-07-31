import 'package:flutter/material.dart';
import '../api/api.dart';
import '../colors.dart';
import '../models/movie.dart';
import '../widgets/Bottom_Nav_Bar.dart';
import '../widgets/MovieCard.dart';

class TopretedPage extends StatefulWidget {
  const TopretedPage({Key? key}) : super(key: key);

  @override
  _TopretedPageState createState() => _TopretedPageState();
}

class _TopretedPageState extends State<TopretedPage> {
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    super.initState();
    topRatedMovies = Api().getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top rated movies',
          style: TextStyle(color: Colors.white), // Modern white text
        ),
        backgroundColor: Colors.blue, // Customize app bar color
        elevation: 0.0, // Remove app bar shadow for a clean look
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BottomNavBar()),);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding
          child: FutureBuilder<List<Movie>>(
            future: topRatedMovies,
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
