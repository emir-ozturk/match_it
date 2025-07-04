import 'package:match_it/features/match_it/domain/models/match_metadata.dart';

abstract class IMatchGame {
  Future<List<MatchMetadata>> getMatchMetadata();
  Future<List<String>> getImages(String folder);
}
