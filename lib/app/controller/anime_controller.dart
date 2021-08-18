import 'package:http/http.dart' as http;

var idLink;

class AnimeApi {
  static Future getAnime(String idLink) async {
    var baseUrl = Uri.parse(
      'https://raw.githubusercontent.com/ruandutrab/apirestanime/main/animes/$idLink',
    );
    idLink = idLink;
    return await http.get(baseUrl);
  }
}
