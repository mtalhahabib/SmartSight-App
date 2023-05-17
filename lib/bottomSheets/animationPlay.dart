import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: Center(

        child: Stack(

          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            if (!_isPlaying)
              Positioned.fill(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.play_circle_fill_rounded),
                    iconSize: 96,
                    color: Colors.white.withOpacity(0.7),
                    onPressed: () {
                      setState(() {
                        _isPlaying = true;
                        _controller.play();
                      });
                    },
                  ),
                ),
              ),
            if (_isPlaying)
              Positioned.fill(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                          if (_isPlaying) {
                            _controller.play();
                          } else {
                            _controller.pause();
                          }
                        });
                      },
                      child: VideoPlayer(_controller),
                    ),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Theme.of(context).accentColor,
                        bufferedColor:
                        Theme.of(context).accentColor.withOpacity(0.3),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
