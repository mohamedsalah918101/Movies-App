import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerWatch extends StatefulWidget {
  final dynamic trailerID;

  const TrailerWatch({super.key, required this.trailerID});

  @override
  State<TrailerWatch> createState() => _TrailerWatchState();
}

class _TrailerWatchState extends State<TrailerWatch> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(widget.trailerID);
    _controller = YoutubePlayerController(
      initialVideoId: videoID.toString(),
      flags: const YoutubePlayerFlags(
          enableCaption: true,
          autoPlay: false,
          mute: false,
          forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: YoutubePlayer(
        thumbnail: Image.network(
          "https://img.youtube.com/vi/" + widget.trailerID + "/hqdefault.jpg",
          fit: BoxFit.cover,
        ),
        controlsTimeOut: const Duration(milliseconds: 1500),
        aspectRatio: 16 / 9,
        controller: _controller,
        showVideoProgressIndicator: true,
        bufferIndicator: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
        ),
        progressIndicatorColor: Colors.amber,
        bottomActions: const [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
                playedColor: Colors.white, handleColor: Colors.amber),
          ),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
    );
  }
}
