import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/core/database/database_providers.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/features/cards/models/deck.dart';
import 'package:deu_karten/features/cards/models/word_card.dart';
import 'package:deu_karten/features/cards/providers/cards_providers_drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Example 1: Basic Widget Using Drift Provider
class DeckListExample extends ConsumerWidget {
  const DeckListExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Decks')),
      body: decksAsync.when(
        data: (decks) => ListView.builder(
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            return ListTile(
              title: Text(deck.name),
              subtitle: Text('${deck.cardsLearned ?? 0}/${deck.totalCards} cards'),
              trailing: CircularProgressIndicator(value: deck.progress ?? 0),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading decks: $error'),
        ),
      ),
    );
  }
}

// Example 2: Using Family Provider for Specific Item
class DeckDetailExample extends ConsumerWidget {
  final String deckId;

  const DeckDetailExample({super.key, required this.deckId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckAsync = ref.watch(deckByIdDriftProvider(deckId));

    return deckAsync.when(
      data: (deck) {
        if (deck == null) return const Text('Deck not found');
        return Column(
          children: [
            Text(deck.name, style: Theme.of(context).textTheme.headlineSmall),
            Text(deck.description),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

// Example 3: Creating and Updating Data
class SessionExample extends ConsumerStatefulWidget {
  final String deckId;

  const SessionExample({super.key, required this.deckId});

  @override
  ConsumerState<SessionExample> createState() => _SessionExampleState();
}

class _SessionExampleState extends ConsumerState<SessionExample> {
  @override
  void initState() {
    super.initState();
    _startSession();
  }

  Future<void> _startSession() async {
    final sessionRepo = await ref.read(sessionRepositoryDriftProvider.future);
    final session = await sessionRepo.createSession(widget.deckId);
    debugPrint('Session started: ${session.id}');
  }

  Future<void> _answerCard(String cardId, bool wasCorrect) async {
    final cardsRepo = await ref.read(cardsRepositoryDriftProvider.future);
    await cardsRepo.updateCardProgress(cardId, wasCorrect);

    final currentSession = await ref.read(currentSessionDriftProvider.future);
    if (currentSession != null) {
      final updated = currentSession.copyWith(
        cardsStudied: (currentSession.cardsStudied ?? 0) + 1,
        correctAnswers: (currentSession.correctAnswers ?? 0) + (wasCorrect ? 1 : 0),
      );

      final sessionRepo = await ref.read(sessionRepositoryDriftProvider.future);
      await sessionRepo.saveSessionProgress(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Session in progress')),
    );
  }
}

// Example 4: Direct Database Access (Advanced)
class DirectDatabaseExample extends ConsumerWidget {
  const DirectDatabaseExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final db = await ref.read(databaseProvider.future);

        final allDecks = await db.getAllDecks();
        debugPrint('Total decks: ${allDecks.length}');

        final a1Decks = allDecks
            .where((deckData) => deckData.level == 'a1')
            .map(deckFromData)
            .toList();
        debugPrint('A1 decks: ${a1Decks.length}');

        final newDeck = DeckData(
          id: 'custom-deck-1',
          name: 'My Custom Deck',
          description: 'A custom deck created by user',
          category: 'Custom',
          level: 'a1',
          cardIds: '[]',
          totalCards: 0,
          cardsLearned: 0,
          progress: 0.0,
          thumbnailEmoji: '📚',
          createdAt: DateTime.now(),
          lastStudied: null,
        );
        await db.into(db.decks).insert(newDeck);
      },
      child: const Text('Direct Database Access'),
    );
  }
}

// Example 5: Complex Query with Joins
class AdvancedQueryExample extends ConsumerWidget {
  const AdvancedQueryExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _getDeckStatistics(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final stats = snapshot.data!;
        return ListView(
          children: stats.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text('${entry.value} cards'),
            );
          }).toList(),
        );
      },
    );
  }

  Future<Map<String, int>> _getDeckStatistics(WidgetRef ref) async {
    final db = await ref.read(databaseProvider.future);
    final deckDataList = await db.getAllDecks();

    final Map<String, int> deckCardCount = {};

    for (final deckData in deckDataList) {
      final deck = deckFromData(deckData);
      final cardIds = deck.cardIds;

      int count = 0;
      for (final cardId in cardIds) {
        final cardData = await db.getWordCardById(cardId);
        if (cardData != null) count++;
      }

      deckCardCount[deck.name] = count;
    }

    return deckCardCount;
  }
}

// Example 6: Pagination and Filtering
class PaginatedCardsExample extends ConsumerStatefulWidget {
  const PaginatedCardsExample({super.key});

  @override
  ConsumerState<PaginatedCardsExample> createState() => _PaginatedCardsExampleState();
}

class _PaginatedCardsExampleState extends ConsumerState<PaginatedCardsExample> {
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  final int _pageSize = 20;
  List<WordCard> _allCards = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCards();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadCards() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final cardsRepo = await ref.read(cardsRepositoryDriftProvider.future);
    final allCards = await cardsRepo.getWordCards();

    final filtered = allCards
        .where((card) => card.level.toString() == 'DifficultyLevel.a1')
        .toList();

    final start = _page * _pageSize;
    final pageCards = filtered.skip(start).take(_pageSize).toList();

    setState(() {
      _allCards.addAll(pageCards);
      _page++;
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _allCards.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _allCards.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final card = _allCards[index];
        return ListTile(
          title: Text(card.germanWord),
          subtitle: Text(card.translation),
          trailing: Text(card.article),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// Example 7: Search Functionality
class SearchCardsExample extends ConsumerStatefulWidget {
  const SearchCardsExample({super.key});

  @override
  ConsumerState<SearchCardsExample> createState() => _SearchCardsExampleState();
}

class _SearchCardsExampleState extends ConsumerState<SearchCardsExample> {
  final TextEditingController _searchController = TextEditingController();
  List<WordCard> _results = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search cards...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _onSearch,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final card = _results[index];
              return ListTile(
                title: Text(card.germanWord),
                subtitle: Text(card.translation),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }

    final cardsRepo = await ref.read(cardsRepositoryDriftProvider.future);
    final allCards = await cardsRepo.getWordCards();

    final filtered = allCards
        .where((card) =>
    card.germanWord.toLowerCase().contains(query.toLowerCase()) ||
        card.translation.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() => _results = filtered);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// Example 8: Transaction Support
class TransactionExample extends ConsumerWidget {
  const TransactionExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final db = await ref.read(databaseProvider.future);

        await db.transaction(() async {
          final deckData = await db.getDeckById('deck-1');
          if (deckData != null) {
            final deck = deckFromData(deckData);
            await db.update(db.decks).replace(
              deckToData(
                deck.copyWith(
                  progress: 0.5,
                  lastStudied: DateTime.now(),
                ),
              ),
            );
          }

          await db.into(db.statistics).insert(
            StatisticsData(
              id: 'stats-${DateTime.now().millisecondsSinceEpoch}',
              date: DateTime.now(),
              cardsLearned: 10,
              cardsReviewed: 15,
              testsTaken: 1,
              averageScore: 85.0,
              studyTimeMinutes: 30,
              xpEarned: 100,
              retentionCards: 12,
            ),
          );
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction completed successfully')),
          );
        }
      },
      child: const Text('Execute Transaction'),
    );
  }
}

// Example 9: Statistics Query
class StatisticsQueryExample extends ConsumerWidget {
  const StatisticsQueryExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _getWeeklyStats(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final stats = snapshot.data!;
        return Column(
          children: [
            Text('Cards learned: ${stats['cardsLearned']}'),
            Text('Study time: ${stats['studyTimeMinutes']} minutes'),
            Text('XP earned: ${stats['xpEarned']}'),
          ],
        );
      },
    );
  }

  Future<Map<String, int>> _getWeeklyStats(WidgetRef ref) async {
    final db = await ref.read(databaseProvider.future);

    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final statsList = await db.getStatisticsByDateRange(weekAgo, now);

    return {
      'cardsLearned': statsList.fold(0, (sum, s) => sum + s.cardsLearned),
      'studyTimeMinutes': statsList.fold(0, (sum, s) => sum + s.studyTimeMinutes),
      'xpEarned': statsList.fold(0, (sum, s) => sum + s.xpEarned),
    };
  }
}

// Example 10: Real-time Updates with Watch
class RealtimeUpdatesExample extends ConsumerWidget {
  const RealtimeUpdatesExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);

    return decksAsync.when(
      data: (decks) => RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(allDecksDriftProvider);
        },
        child: ListView.builder(
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            final progress = deck.progress ?? 0.0;

            return ListTile(
              title: Text(deck.name),
              subtitle: Text('Progress: ${(progress * 100).toStringAsFixed(0)}%'),
              trailing: progress >= 1.0
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : CircularProgressIndicator(value: progress),
            );
          },
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}