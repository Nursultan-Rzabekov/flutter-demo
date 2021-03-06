import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Movie.dart';
import 'package:provider/provider.dart';

import '../base_model.dart';

class AddMoviePage extends StatefulWidget {
  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final controller = TextEditingController();
  List<Movie> _results = [];
  bool _progressBarActive = true;

  @override
  Widget build(BuildContext context) {
    final BaseModel app = Provider.of<BaseModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: DebouncedTextField(
            //   debounceDuration: Duration(milliseconds: 500),
            //   decoration:
            //       InputDecoration(hintText: 'Add a movie you have seen before'),
            //   controller: controller,
            //   onChanged: (v) async {
            //     final results = await app.networkRepository.findMovies(v);
            //     setState(() {
            //       _progressBarActive = false;
            //       _results = [];
            //     });
            //   },
            // ),
          ),
          Expanded(
            child: _progressBarActive == true
                ? new Center(child: const CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final item = _results[index];
                      return GestureDetector(
                        onTap: () => _markAsWatched(item),
                        child: AddMoviePage(),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  void _markAsWatched(Movie movie, [DateTime dateWatched]) async {
    final BaseModel app = Provider.of<BaseModel>(context);
    final date = dateWatched ?? DateTime.now();
    movie.watchedOn = date.millisecondsSinceEpoch;
    //app.storage.addToWatched(movie);
    Navigator.pop(context);
  }
}
