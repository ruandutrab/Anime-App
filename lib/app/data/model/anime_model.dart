class Anime {
  String episodio;
  String nome;
  String info;
  String link;
  String releaseDate;

  Anime({this.episodio, this.nome, this.info, this.link, this.releaseDate});

  Anime.fromJson(Map<String, dynamic> json) {
    episodio = json['episodio'];
    nome = json['nome'];
    info = json['info'];
    link = json['link'];
    releaseDate = json['release_date'];
  }
}
