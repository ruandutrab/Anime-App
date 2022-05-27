import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlaylistService {
  static getPlaylistYoutube() async {
    var yt = YoutubeExplode();
// Get playlist metadata.
    var playlist = await yt.playlists.get('xxxxx');

    var title = playlist.title;
    var author = playlist.author;

    await for (var video in yt.playlists.getVideos(playlist.id)) {
      var videoTitle = video.title;
      var videoAuthor = video.author;
    }
  }
}
