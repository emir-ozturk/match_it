import 'package:equatable/equatable.dart';

/// Domain entity for a match card item in the matching game
/// This represents a single card with its state in the game
/// Immutable class following Clean Architecture principles
class MatchCardItem extends Equatable {
  /// The unique identifier for this card
  final String id;

  /// The path to the card's image asset
  final String imagePath;

  /// Whether this card has been successfully matched with its pair
  final bool isMatched;

  /// Whether this card is currently flipped (face-up)
  final bool isFlipped;

  /// Optional unique identifier for matching pairs
  /// Cards with the same pairId are considered a match
  final String? pairId;

  const MatchCardItem({
    required this.id,
    required this.imagePath,
    this.isMatched = false,
    this.isFlipped = false,
    this.pairId,
  });

  /// Named constructor for initial card creation
  /// Best practice: Use named constructors for specific use cases
  const MatchCardItem.initial({required this.id, required this.imagePath, this.pairId})
    : isMatched = false,
      isFlipped = false;

  /// Named constructor for creating pairs
  /// Creates two cards with the same pairId for matching
  static List<MatchCardItem> createPair({required String basePath, required String pairId}) {
    return [
      MatchCardItem.initial(id: '${pairId}_1', imagePath: basePath, pairId: pairId),
      MatchCardItem.initial(id: '${pairId}_2', imagePath: basePath, pairId: pairId),
    ];
  }

  /// Business logic: Check if this card can be flipped
  bool get canBeFlipped => !isMatched && !isFlipped;

  /// Business logic: Check if this card is face-up and not matched
  bool get isActive => isFlipped && !isMatched;

  /// Business logic: Check if this card is in initial state
  bool get isInitialState => !isMatched && !isFlipped;

  /// Business logic: Check if two cards can be matched
  bool canMatchWith(MatchCardItem other) {
    return pairId != null &&
        pairId == other.pairId &&
        id != other.id &&
        !isMatched &&
        !other.isMatched;
  }

  /// Business logic: Validate card state
  bool get isValidState {
    // A matched card should also be flipped
    if (isMatched && !isFlipped) return false;
    return true;
  }

  /// Create a copy with modified properties (immutable pattern)
  MatchCardItem copyWith({
    String? id,
    String? imagePath,
    bool? isMatched,
    bool? isFlipped,
    String? pairId,
  }) {
    return MatchCardItem(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      isMatched: isMatched ?? this.isMatched,
      isFlipped: isFlipped ?? this.isFlipped,
      pairId: pairId ?? this.pairId,
    );
  }

  /// Business logic: Create a flipped version of this card
  MatchCardItem flip() {
    assert(canBeFlipped, 'Cannot flip a matched or already flipped card');
    return copyWith(isFlipped: !isFlipped);
  }

  /// Business logic: Mark this card as matched
  MatchCardItem markAsMatched() {
    assert(!isMatched, 'Card is already matched');
    return copyWith(isMatched: true, isFlipped: true);
  }

  /// Business logic: Reset card to initial state
  MatchCardItem reset() => copyWith(isMatched: false, isFlipped: false);

  /// Business logic: Hide card (flip face down if not matched)
  MatchCardItem hide() {
    if (isMatched) return this; // Matched cards stay visible
    return copyWith(isFlipped: false);
  }

  @override
  List<Object?> get props => [id, imagePath, isMatched, isFlipped, pairId];
}
