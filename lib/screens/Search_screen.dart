import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../colors.dart';
import '../constants.dart';
import '../models/movie.dart';
import 'details_screen.dart'; // Import your existing details screen

class Search extends StatefulWidget {
  static const String routeName = 'search';

  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> searchResults = [];
  bool isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colours.scaffoldBgColor, Colours.scaffoldBgColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Movie Search',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search for a movie',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _performSearch(value);
                } else {
                  setState(() {
                    searchResults.clear();
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : searchResults.isEmpty
                  ? Center(
                child: Text(
                  'No results found',
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(movie: movie),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: ListTile(
                        title: Text(
                          movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Released: ${movie.releaseDate}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${Constants.imagePath}${movie.posterPath}',
                            width: 50,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch(String searchTerm) async {
    setState(() {
      isLoading = true;
    });

    try {
      final url =
          'https://api.themoviedb.org/3/search/movie?query=$searchTerm&include_adult=false&language=en-US&page=1';

      final response = await http.get(Uri.parse(url), headers: {
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZWQ1YjVjNGMxODMwOTRmMjFkZDEzYTk4NDUyMTZkMSIsInN1YiI6IjY1NGEzZmRhNjMzMmY3MDBhZDdlMzE2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mku0CavQ88UZHN0FeAUl1T9_ymo41rptGNrmZsDN-X8',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['results'] != null) {
          List<Movie> results = (data['results'] as List)
              .map((result) => Movie(
            title: result['title'],
            releaseDate: result['release_date'],
            voteAverage: result['vote_average'].toDouble(),
            overview: result['overview'],
            posterPath: result['poster_path'], backDropPath: '', originalTitle: '', imageUrl: '',
          ))
              .toList();

          setState(() {
            searchResults = results;
          });
        } else {
          setState(() {
            searchResults.clear();
          });
        }
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
        // Show an error message to the user
      }
    } catch (e) {
      // Handle error
      print('Error occurred: $e');
      // Show an error message to the user
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
