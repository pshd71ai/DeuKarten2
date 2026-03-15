# Drift Database Module

This module provides local SQLite database functionality using Drift (formerly Moor) for the DeuKarten app.

## Structure

```
lib/core/database/
├── database.dart                 # Barrel export
├── drift_database.dart           # Database schema and definition
├── drift_database.g.dart         # Generated database code
├── database_providers.dart       # Riverpod providers for database
├── database_providers.g.dart     # Generated provider code
├── converters.dart               # Type converters between models
├── seed_data.dart                # Database seeding utilities
├── migration_service.dart        # Data migration service
└── README.md                     # This file
```

## Key Components

### 1. Database Schema (`drift_database.dart`)

Defines all database tables:
- **WordCards**: Vocabulary words with spaced repetition
- **ArticleCards**: der/die/das article practice
- **SentenceCards**: Fill-in-the-blank exercises
- **Decks**: Deck metadata and progress
- **LearningSessions**: Session history
- **UserProfiles**: User profiles and settings
- **XpHistory**: XP earning history
- **StreakData**: Streak tracking
- **Tests**: Test definitions
- **TestSessions**: Test session history
- **Statistics**: Daily/weekly statistics

### 2. Database Providers (`database_providers.dart`)

Riverpod providers for database access:
- `databaseProvider`: Async database initialization
- `dbProvider`: Sync database access (after initialization)
- Convenience providers for common queries

### 3. Converters (`converters.dart`)

Handles type conversions:
- Freezed models ↔ Drift data classes
- Enums ↔ String representation
- Complex types (List, DateTime) ↔ JSON strings

### 4. Seed Data (`seed_data.dart`)

Utilities for database seeding:
- `seedAll()`: Seed all tables with mock data
- `clearAll()`: Remove all data (for testing)
- `reseed()`: Clear and reseed

### 5. Migration Service (`migration_service.dart`)

Handles data migration:
- Migrate from SharedPreferences to Drift
- Perform initial setup
- Check migration status

## Usage

### Initialization

Database is initialized in `main.dart`:

```dart
import 'package:deu_karten/core/database/database_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  await AppDatabase.initialize();
  
  runApp(MyApp());
}
```

### Basic Usage

#### Using Providers (Recommended)

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);
    
    return decksAsync.when(
      data: (decks) => ListView.builder(
        itemCount: decks.length,
        itemBuilder: (context, index) => DeckCard(decks[index]),
      ),
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

#### Direct Database Access

```dart
final db = await ref.read(databaseProvider.future);
final decks = await db.getAllDecks();
```

### Type Conversion

Always use converters when working with data:

```dart
// Convert from Drift data to model
final deckData = await db.getDeckById(id);
final deck = deckFromData(deckData);

// Convert from model to Drift data
final updatedDeck = deck.copyWith(progress: 0.5);
await db.update(decks).replace(deckToData(updatedDeck));
```

### Writing Data

```dart
// Insert
await db.into(decks).insert(deckToData(newDeck));

// Update
await db.update(decks).replace(deckToData(updatedDeck));

// Delete
await db.delete(decks).where((tbl) => tbl.id.equals(deckId));
```

### Complex Queries

```dart
// Filtering
final a1Decks = await (select(decks)
  ..where((tbl) => tbl.level.equals('a1'))
  ..orderBy([(tbl) => OrderingTerm.desc(tbl.lastStudied)])
  ..limit(10))
  .get();

// Joins and aggregations can be implemented as needed
```

## Code Generation

Run code generation to create generated files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

For watch mode during development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

Generated files:
- `drift_database.g.dart`: Database class code
- `database_providers.g.dart`: Provider code
- `*.g.dart` from Freezed models (already generated)

## Seeding Data

The database is automatically seeded with mock data on first launch:
- 25 word cards
- 8 article cards
- 8 sentence cards
- 5 decks

To manually reseed:

```dart
final seeder = DatabaseSeeder(AppDatabase.instance);
await seeder.reseed();
```

## Migration

Migrate existing data from SharedPreferences:

```dart
final migrationService = MigrationService(
  AppDatabase.instance,
  profileRepository,
);
await migrationService.migrateFromSharedPreferences();
```

## Testing

Use in-memory database for tests:

```dart
test('database operations', () async {
  final db = AppDatabase(NativeDatabase.memory());
  final seeder = DatabaseSeeder(db);
  await seeder.seedAll();
  
  // Run tests...
});
```

## Best Practices

1. **Use Providers**: Prefer provider-based access for better state management
2. **Type Safety**: Always use converters, don't cast
3. **Async Handling**: Database operations are async, use proper async/await
4. **Error Handling**: Wrap database calls in try-catch
5. **Transactions**: Use transactions for multiple related operations
6. **Indexes**: Add indexes to frequently queried columns
7. **Batch Operations**: Use batch inserts/updates for better performance

## Common Patterns

### Loading with State

```dart
class DeckScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends ConsumerState<DeckScreen> {
  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  Future<void> _loadDecks() async {
    // Data will be loaded automatically via providers
    // No manual loading needed
  }

  @override
  Widget build(BuildContext context) {
    final decksAsync = ref.watch(allDecksDriftProvider);
    // Build UI based on state
  }
}
```

### Updating Data

```dart
Future<void> updateDeckProgress(String deckId, double progress) async {
  final db = await ref.read(databaseProvider.future);
  final deckData = await db.getDeckById(deckId);
  
  if (deckData != null) {
    final deck = deckFromData(deckData);
    final updated = deck.copyWith(progress: progress);
    await db.update(decks).replace(deckToData(updated));
  }
}
```

### Filtering and Searching

```dart
Future<List<WordCard>> searchCards(String query) async {
  final cardsRepo = await ref.read(cardsRepositoryDriftProvider.future);
  final allCards = await cardsRepo.getWordCards();
  
  return allCards
      .where((card) =>
          card.germanWord.toLowerCase().contains(query.toLowerCase()) ||
          card.translation.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
```

## Troubleshooting

### "Database not initialized"
Ensure `await AppDatabase.initialize()` is called in `main.dart`

### "Provider not found"
Ensure database provider is watched before use:
```dart
final db = await ref.watch(databaseProvider.future);
```

### Type errors
Always use converters:
```dart
// Wrong
final deck = data as Deck;

// Correct
final deck = deckFromData(data);
```

### Build errors
Clean and rebuild:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Future Enhancements

1. **Streaming Queries**: Use Drift's watch for real-time updates
2. **Full-Text Search**: Implement search with FTS
3. **Offline Sync**: Prepare structure for cloud sync
4. **Analytics**: Advanced SQL queries for analytics
5. **Performance**: Add indexes and optimize queries

## Related Documentation

- [Drift Database Implementation Guide](../../../DRIFT_DATABASE_IMPLEMENTATION.md)
- [Migration Guide](../../../MIGRATION_GUIDE.md)
- [Usage Examples](../../../examples/drift_usage_examples.dart)
- [Drift Official Documentation](https://drift.simonbinder.eu/)

## Support

For issues or questions:
1. Check the main documentation files
2. Review the code examples
3. Consult Drift documentation
4. Open an issue in the repository
