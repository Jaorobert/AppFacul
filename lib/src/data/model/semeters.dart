class Semeter {
  final String? ds_curso;
  final int? semestre;
  final int? id_user;
  final int? id_curso;
  final String? name;
  final String? ra;
  Semeter(this.semestre, this.ds_curso, this.id_user, this.id_curso, this.name,
      this.ra);

  factory Semeter.fromJson(Map<String, dynamic> json) {
    return Semeter(json['semestre'], json['ds_curso'], json['id_user'],
        json['id_curso'], json['name'], json['ra']);
  }
}
