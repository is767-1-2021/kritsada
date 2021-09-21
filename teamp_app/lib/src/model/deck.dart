import 'package:teamp_app/playing_cards.dart';
import 'package:teamp_app/src/model/playing-card.dart';
import 'package:teamp_app/src/model/suit.dart';

/// Generates a standard 52 card deck.
List<PlayingCard> standardFiftyTwoCardDeck() {
  List<PlayingCard> cards = [];
  for (Suit suit in Suit.values) {
    for (CardValue v in CardValue.values) {
      cards.add(PlayingCard(suit, v));
    }
  }
  return cards;
}
