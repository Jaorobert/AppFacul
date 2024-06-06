class Semeter {
  final String? ds_curso;
  final int? semestre;
  final int? id_user;
  final int? id_curso;
  Semeter(this.semestre, this.ds_curso, this.id_user, this.id_curso);

  factory Semeter.fromJson(Map<String, dynamic> json) {
    return Semeter(
        json['semestre'], json['ds_curso'], json['id_user'], json['id_curso']);
  }
}
