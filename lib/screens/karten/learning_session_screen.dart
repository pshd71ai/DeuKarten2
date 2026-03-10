import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../../features/cards/providers/session_provider.dart';
import '../../features/cards/providers/cards_providers.dart';
import '../../features/cards/widgets/card_stack_area.dart';
import '../../features/cards/widgets/session_progress_bar.dart';
import '../../features/cards/widgets/session_action_buttons.dart';
import '../../features/cards/widgets/session_views.dart';
import '../../features/cards/widgets/session_app_bar.dart';

class LearningSessionScreen extends ConsumerStatefulWidget {
  final String? deckId;

  const LearningSessionScreen({
    super.key,
    this.deckId,
  });

  @override
  ConsumerState<LearningSessionScreen> createState() =>
      _LearningSessionScreenState();
}

class _LearningSessionScreenState extends ConsumerState<LearningSessionScreen> {
  @override
  void initState() {
    super.initState();
    // Start session if deckId is provided
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.deckId != null) {
        ref.read(currentSessionProvider.notifier).startSession(widget.deckId!);
      }
    });
  }

  void _handleDontKnow(String cardId) {
    HapticFeedback.lightImpact();
    ref.read(currentSessionProvider.notifier).answerCard(cardId, false);
    _moveToNextCard();
  }

  void _handleKnow(String cardId) {
    HapticFeedback.lightImpact();
    ref.read(currentSessionProvider.notifier).answerCard(cardId, true);
    _moveToNextCard();
  }

  void _moveToNextCard() {
    final session = ref.read(currentSessionProvider).value;
    if (session == null) return;

    final currentIndex = ref.read(currentCardIndexProvider);

    if (currentIndex < session.cards.length - 1) {
      // Move to next card
      ref.read(currentCardIndexProvider.notifier).state = currentIndex + 1;
    } else {
      // Session complete
      _completeSession();
    }
  }

  void _completeSession() async {
    await ref.read(currentSessionProvider.notifier).completeSession();

    if (mounted) {
      context.go('/karten/result');
    }
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session beenden?'),
        content: const Text(
          'Möchtest du die Lernsession wirklich beenden? Dein Fortschritt wird nicht gespeichert.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Weiterlernen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(currentSessionProvider.notifier).resetSession();
              ref.read(currentCardIndexProvider.notifier).state = 0;
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Beenden'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(currentSessionProvider);
    final currentIndex = ref.watch(currentCardIndexProvider);

    return sessionAsync.when(
      loading: () => const SessionLoadingView(),
      error: (err, _) => SessionErrorView(
        error: err,
        onRetry: () {
          if (widget.deckId != null) {
            ref
                .read(currentSessionProvider.notifier)
                .startSession(widget.deckId!);
          }
        },
      ),
      data: (session) {
        if (session == null || session.cards.isEmpty) {
          return SessionEmptyView(
            onBack: () => context.pop(),
          );
        }

        // Check if session is complete
        if (currentIndex >= session.cards.length) {
          return SessionCompletedView(
            onFinish: () => context.go('/karten/result'),
          );
        }

        final currentSessionCard = session.cards[currentIndex];
        final progress = (currentIndex + 1) / session.cards.length;

        return FutureBuilder(
          future: ref.watch(
            currentCardDataProvider(currentSessionCard.cardId).future,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SessionLoadingView();
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return SessionErrorView(
                error: snapshot.error ?? 'Karte konnte nicht geladen werden',
              );
            }

            final cardData = snapshot.data!;

            return Scaffold(
              appBar: SessionAppBar(
                progress: progress,
                onClose: _showExitConfirmation,
              ),
              body: Column(
                children: [
                  // Progress indicator
                  SessionProgressBar(
                    progress: progress,
                    currentCard: currentIndex + 1,
                    totalCards: session.cards.length,
                  ),

                  // Card stack area
                  Expanded(
                    child: CardStackArea(
                      card: cardData,
                      onSwipeLeft: () => _handleDontKnow(currentSessionCard.cardId),
                      onSwipeRight: () => _handleKnow(currentSessionCard.cardId),
                      onFlip: () {
                        // Card was flipped
                      },
                    ),
                  ),

                  // Action buttons (if not swiping)
                  SessionActionButtons(
                    onDontKnow: () => _handleDontKnow(currentSessionCard.cardId),
                    onKnow: () => _handleKnow(currentSessionCard.cardId),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
