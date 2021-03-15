import 'package:flutter/material.dart';
import 'package:flutter_video_cast/flutter_video_cast.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MediaPlayer extends StatefulWidget {
  final String linkEp;
  final String nome;
  final String episodio;

  const MediaPlayer({Key key, this.linkEp, this.nome, this.episodio})
      : super(key: key);
  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  ChromeCastController _controller;
  bool castOn = false;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);

    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('${widget.nome} EP ${widget.episodio}'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: ChromeCastButton(
              size: 30,
              onButtonCreated: (controller) {
                setState(() => _controller = controller);
                _controller?.addSessionListener();
              },
              onSessionStarted: () {
                _controller?.loadMedia('${widget.linkEp}');
                setState(() {
                  castOn = !castOn;
                });
              },
            ),
          ),
        ],
      ),
      body: !castOn
          ? Container(
              child: Stack(
                children: [
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: ChewieListItem(
                          videoPlayerController: VideoPlayerController.network(
                            '${widget.linkEp}',
                          ),
                          looping: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Icon(
                    Icons.cast_connected,
                    size: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Transmitindo',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Image(
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/fb/74/9a/fb749a2f2751fb60487a6fc8481cb1ab.gif'),
                          width: 70,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Chewie(
          controller: _chewieController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
