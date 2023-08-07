enum AssetType {
  question('q'),
  answer('a');

  const AssetType(this.abbreviation);
  final String abbreviation;
}

class AssetManager {
  static String path({required int id, required AssetType assetType}) {
    return 'assets/${assetType.abbreviation}$id.png';
  }

  static const howto = 'assets/howto.png';

  static List<String> get questionPaths => List.generate(
      5, (index) => path(id: index + 1, assetType: AssetType.question));

  static const drag_target_q_id = 'assets/q2';

  //TODO: Introduce GameState or other instance to maintain levels!
  static const drag_target_a_id = 'assets/a5';

  static List<String> get answerPaths => List.generate(
      5, (index) => path(id: index + 1, assetType: AssetType.answer));
}
