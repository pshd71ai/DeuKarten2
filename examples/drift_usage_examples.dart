// Drift Database Usage Examples
// This file demonstrates how to use the Drift database in the DeuKarten app

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deu_karten/core/database/database_providers.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/features/cards/providers/cards_providers_drift.dart';
import 'package:deu_karten/features/cards/models/deck.dart';
import 'package:deu_karten/features/cards/models/word_card.dart';

// Example 1: Basic Widget Using Drift Provider
class DeckListExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the decks provider
    final decksAsync = ref.watch(allDecksDriftProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Decks')),
      body: decksAsync.when(
        data: (decks) => ListView.builder(
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            return ListTile(
              title: Text(deck.name),
              subtitle: Text('${deck.cardsLearned}/${deck.totalCards} cards'),
              trailing: CircularProgressIndicator(value: deck.progress),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
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

  DeckDetailExample({required this.deckId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch a specific deck
    final deckAsync = ref.watch(deckByIdDriftProvider(deckId));

    return deckAsync.when(
      data: (deck) {
        if (deck == null) return Text('Deck not found');
        return Column(
          children: [
            Text(deck.name, style: Theme.of(context).textTheme.headlineSmall),
            Text(deck.description),
            // ... more UI
          ],
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

// Example 3: Creating and Updating Data
class SessionExample extends ConsumerStatefulWidget {
  final String deckId;

  SessionExample({required this.deckId});

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
    // Get the session repository
    final sessionRepo = await ref.read(sessionRepositoryDriftProvider.future);
    
    // Create a new session
    final sessionId = await sessionRepo.createSession(widget.deckId);
    print('Session started: $sessionId');
  }

  Future<void> _answerCard(String cardId, bool wasCorrect) async {
    // Update card progress
    final cardsRepo = await ref.read(cardsRepositoryDriftProvider.future);
    await cardsRepo.updateCardProgress(cardId, wasCorrect);

    // Update session progress
    final currentSession = await ref.read(currentSessionDriftProvider.future);
    if (currentSession != null) {
      final updated = currentSession.copyWith(
        cardsStudied: currentSession.cardsStudied + 1,
        correctAnswers: currentSession.correctAnswers + (wasCorrect ? 1 : 0),
      );
      await ref.read(sessionRepositoryDriftProvider.future).saveSessionProgress(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Session in progress')),
    );
  }
}

// Example 4: Direct Database Access (Advanced)
class DirectDatabaseExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        // Get direct database access
        final db = await ref.read(databaseProvider.future);

        // Execute custom query
        final allDecks = await db.getAllDecks();
        print('Total decks: ${allDecks.length}');

        // Filter manually
        final a1Decks = allDecks
            .where((deckData) => deckData.level == 'a1')
            .map(deckFromData)
            .toList();
        print('A1 decks: ${a1Decks.length}');

        // Insert new data
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
        await db.into(decks).insert(newDeck);
      },
      child: Text('Direct Database Access'),
    );
  }
}

// Example 5: Complex Query with Joins
class AdvancedQueryExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _getDeckStatistics(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
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

    // Get all decks
    final deckDataList = await db.getAllDecks();

    // Count cards per deck
    final Map<String, int> deckCardCount = {};

    for (final deckData in deckDataList) {
      final deck = deckFromData(deckData);
      final cardIds = deck.cardIds;

      // Count word cards in this deck
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

    // Apply filters (e.g., only A1 level)
    final filtered = allCards
        .where((card) => card.level.toString() == 'DifficultyLevel.a1')
        .toList();

    // Apply pagination
    final start = _page * _pageSize;
    final end = start + _pageSize;
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
          return Center(child: CircularProgressIndicator());
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
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
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

    // Filter cards based on search query
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final db = await ref.read(databaseProvider.future);

        // Perform multiple operations in a transaction
        await db.transaction(() async {
          // Update deck progress
          final deckData = await db.getDeckById('deck-1');
          if (deckData != null) {
            final deck = deckFromData(deckData);
            await db.update(decks).replace(
              deckToData(deck.copyWith(
                progress: 0.5,
                lastStudied: DateTime.now(),
              )),
            );
          }

          // Record statistics
          await db.into(statistics).insert(StatisticsData(
            id: 'stats-${DateTime.now().millisecondsSinceEpoch}',
            date: DateTime.now(),
            cardsLearned: 10,
            cardsReviewed: 15,
            testsTaken: 1,
            averageScore: 85.0,
            studyTimeMinutes: 30,
            xpEarned: 100,
            retentionCards: 12,
          ));

          // If any operation fails, all changes are rolled back
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaction completed successfully')),
        );
      },
      child: Text('Execute Transaction'),
    );
  }
}

// Example 9: Statistics Query
class StatisticsQueryExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _getWeeklyStats(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
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
    final weekAgo = now.subtract(Duration(days: 7));

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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);

    return decksAsync.when(
      data: (decks) => RefreshIndicator(
        onRefresh: () async {
          // Invalidate the provider to trigger a refresh
          ref.invalidate(allDecksDriftProvider);
        },
        child: ListView.builder(
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            return ListTile(
              title: Text(deck.name),
              subtitle: Text('Progress: ${(deck.progress * 100).toStringAsFixed(0)}%'),
              trailing: deck.progress >= 1.0
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : CircularProgressIndicator(value: deck.progress),
            );
          },
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
