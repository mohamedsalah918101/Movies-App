import 'package:flutter/material.dart';
import 'package:flutter_movies_app/details/movie_details.dart';
import 'package:flutter_movies_app/details/tvseries_details.dart';

class DescriptionCheckUI extends StatefulWidget {
  final dynamic newID;
  final dynamic newType;
  const DescriptionCheckUI({super.key, this.newID, this.newType});

  @override
  State<DescriptionCheckUI> createState() => _DescriptionCheckUIState();
}

class _DescriptionCheckUIState extends State<DescriptionCheckUI> {
  checkType(){
    if(widget.newType == 'movie'){
      return MovieDetails(movieID: widget.newID,);
    } else if(widget.newType == 'tv'){
      return TvSeriesDetails(tvID: widget.newID,);
    }
    else {
      return errorUI();
    }
  }
  @override
  Widget build(BuildContext context) {
    return checkType();
  }

  Widget errorUI() {
    return const Scaffold(
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}
