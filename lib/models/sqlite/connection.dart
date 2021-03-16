class Anime {
  int id;
  String nome;
  String favorite;
  String imgCard;
  String lastView;
  String linkEp;

  Anime(this.id, this.nome, this.favorite, this.imgCard, this.lastView,
      this.linkEp);
//Converte para Map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'favorite': favorite,
      'imgCard': imgCard,
      'lastView': lastView,
    };
    return map;
  }

// Converte de Map
  Anime.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    favorite = map['favorite'];
    imgCard = map['imgCard'];
    lastView = map['lastView'];
    linkEp = map['linkEp'];
  }
}
