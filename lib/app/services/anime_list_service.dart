import 'package:http/http.dart' as http;

class AnimeApi {
  static Future getAnime(String idLink) async {
    var baseUrl = Uri.parse(
      'https://raw.githubusercontent.com/ruandutrab/apirestanime/main/animes/$idLink',
    );
    return await http.get(baseUrl);
  }
}
