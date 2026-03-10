import 'package:flutter/material.dart';
import '../providers/session_provider.dart';
import 'card_front.dart';
import 'card_back.dart';
import 'swipeable_card.dart';
import 'swipe_indicators.dart';

class CardStackArea extends StatefulWidget {
  final CardData card;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onFlip;

  const CardStackArea({
    super.key,
    required this.card,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onFlip,
  });

  @override
  State<CardStackArea> createState() => _CardStackAreaState();
}

class _CardStackAreaState extends State<CardStackArea> {
  bool _isFlipped = false;
  double _swipeProgress = 0;

  void _handleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
    widget.onFlip();
  }

  void _handleSwipeLeft() {
    setState(() {
      _isFlipped = false;
      _swipeProgress = 0;
    });
    widget.onSwipeLeft();
  }

  void _handleSwipeRight() {
    setState(() {
      _isFlipped = false;
      _swipeProgress = 0;
    });
    widget.onSwipeRight();
  }

  void _handleSwipeProgress(double progress) {
    setState(() {
      _swipeProgress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Swipe indicators
          SwipeIndicators(swipeProgress: _swipeProgress),

          // Main card
          SwipeableCard(
            isFlipped: _isFlipped,
            front: CardFront(card: widget.card),
            back: CardBack(card: widget.card),
            onSwipeLeft: _handleSwipeLeft,
            onSwipeRight: _handleSwipeRight,
            onFlip: _handleFlip,
            onSwipeProgress: _handleSwipeProgress,
          ),
        ],
      ),
    );
  }
}
