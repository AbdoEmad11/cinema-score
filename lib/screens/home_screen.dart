import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api.dart';
import '../models/movie.dart';
import '../widgets/Movies_Slider.dart';
import '../widgets/Trending_Slider.dart';
import 'Top rated movies_page.dart';
import 'Trending_page.dart';
import 'Upcoming_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/aaa.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Movies',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => TrendingMoviesPage()));
                      // Add your functionality for the "See All" button here
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TrendingSlider(snapshot: snapshot);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionWithSeeAllButton(
                'Top rated movies',
                topRatedMovies,
                () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => TopretedPage()));
                  // Navigate to screen showing all top rated movies
                },
              ),
              const SizedBox(height: 32),
              _buildSectionWithSeeAllButton(
                'Upcoming movies',
                upcomingMovies,
                () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => UpcomingPage()));
                  // Navigate to screen showing all upcoming movies
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithSeeAllButton(
    String title,
    Future<List<Movie>> future,
    VoidCallback onPressed,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text(
                'See All',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return MoviesSlider(snapshot: snapshot);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
