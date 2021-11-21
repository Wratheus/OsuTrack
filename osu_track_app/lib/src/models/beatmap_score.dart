// Score includes beatmap class to avoid beatmap request
class BeatmapScore{
  int? scoreId;
  List<dynamic> mods = [];
  var scorePoints;
  var accuracy;
  int? maxCombo;
  Map<dynamic, dynamic>? mapStatistics;
  String? mapRank;
  String? dateOfScore;
  int? bestScoreOnMapId;
  var gainedPP;
  var avatarURL;
  var userId;
  var username;
  var coverURL;
  var countryCode;

  BeatmapScore({
    required this.scoreId,
    required this.accuracy,
    required this.mods,
    required this.scorePoints,
    required this.maxCombo,
    required this.mapStatistics,
    required this.mapRank,
    required this.dateOfScore,
    required this.bestScoreOnMapId,
    required this.gainedPP,
    required this.avatarURL,
    required this.userId,
    required this.username,
    required this.coverURL,
    required this.countryCode,
  });
  factory BeatmapScore.fromJson(Map<String, dynamic> json){
    return BeatmapScore(
      scoreId: json['id'],
      accuracy: json['accuracy'],
      mods: json['mods'],
      scorePoints: json['score'],
      maxCombo: json['max_combo'],
      mapStatistics: json['statistics'],
      mapRank: json['rank'],
      dateOfScore: json['created_at'],
      bestScoreOnMapId: json['best_id'],
      gainedPP: json['pp'],
      userId: json['user_id'],
      avatarURL: json['user']['avatar_url'],
      username: json['user']['username'],
      coverURL: json['user']['cover']['url'],
      countryCode: json['user']['country_code']
    );
  }
}