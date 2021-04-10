import 'package:flutter/material.dart';
import 'package:flutter_video_cast/flutter_video_cast.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MediaPlayer extends StatefulWidget {
  final String linkEp;
  final String nome;
  final String episodio;
  static const _iconSize = 50.0;

  const MediaPlayer({Key key, this.linkEp, this.nome, this.episodio})
      : super(key: key);
  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  ChromeCastController _controller;
  AppState _state = AppState.idle;
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);

    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text('${widget.nome} EP ${widget.episodio}'),
        ),
        actions: <Widget>[
          AirPlayButton(
            size: MediaPlayer._iconSize,
            color: Colors.white,
            activeColor: Colors.amber,
            onRoutesOpening: () => print('opening'),
            onRoutesClosed: () => print('closed'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: ChromeCastButton(
              size: MediaPlayer._iconSize,
              color: Colors.white,
              onButtonCreated: _onButtonCreated,
              onSessionStarted: _onSessionStarted,
              onSessionEnded: () => setState(() => _state = AppState.idle),
              onRequestCompleted: _onRequestCompleted,
              onRequestFailed: _onRequestFailed,
            ),
          ),
        ],
      ),
      body: _handleState(),
    );
  }

  Widget _handleState() {
    switch (_state) {
      case AppState.idle:
        return Stack(
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
        );
      case AppState.connected:
        return Container(
          width: double.infinity,
          height: double.infinity,
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
                color: Colors.blue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Transmitindo',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image(
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/fb/74/9a/fb749a2f2751fb60487a6fc8481cb1ab.gif'),
                      width: 70,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      case AppState.mediaLoaded:
        return Center(child: _mediaControls());
      case AppState.error:
        return Text('An error has occurred');
      default:
        return Container();
    }
  }

  Widget _mediaControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _RoundIconButton(
          icon: Icons.replay_10,
          onPressed: () => _controller.seek(relative: true, interval: -10.0),
        ),
        _RoundIconButton(
            icon: _playing ? Icons.pause : Icons.play_arrow,
            onPressed: _playPause),
        _RoundIconButton(
          icon: Icons.forward_10,
          onPressed: () => _controller.seek(relative: true, interval: 10.0),
        )
      ],
    );
  }

  Future<void> _playPause() async {
    final playing = await _controller.isPlaying();
    if (playing) {
      await _controller.pause();
    } else {
      await _controller.play();
    }
    setState(() => _playing = !playing);
  }

  Future<void> _onButtonCreated(ChromeCastController controller) async {
    _controller = controller;

    await _controller.addSessionListener();
  }

  Future<void> _onSessionStarted() async {
    setState(() => _state = AppState.connected);
    await _controller.loadMedia('${widget.linkEp}');
  }

  Future<void> _onRequestCompleted() async {
    final playing = await _controller.isPlaying();
    setState(() {
      _state = AppState.mediaLoaded;
      _playing = playing;
    });
  }

  Future<void> _onRequestFailed(String error) async {
    setState(() => _state = AppState.error);
    print(error);
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  _RoundIconButton({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Icon(icon, color: Colors.white),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          primary: Colors.blue,
          shape: CircleBorder(),
        ),
        onPressed: onPressed);
  }
}

enum AppState { idle, connected, mediaLoaded, error }

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
