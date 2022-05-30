class AnimeModel {
  String episodio;
  String nome;
  String info;
  String link;
  String releaseDate;

  AnimeModel(
      {this.episodio, this.nome, this.info, this.link, this.releaseDate});

  AnimeModel.fromJson(Map<String, dynamic> json) {
    episodio = json['episodio'];
    nome = json['nome'];
    info = json['info'];
    link = json['link'];
    releaseDate = json['release_date'];
  }
}
