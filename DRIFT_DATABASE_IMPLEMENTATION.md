# Drift Database Implementation Guide

## Overview
This document describes the Drift local database implementation added to the DeuKarten app. The implementation provides a robust local persistence layer without requiring major UI refactoring.

## Architecture

### Design Principles
1. **Non-Breaking**: Existing repository interfaces remain unchanged
2. **Dual Support**: Both mock and Drift implementations coexist
3. **Gradual Migration**: Features can be migrated incrementally
4. **Type Safety**: Full type conversion between Freezed models and Drift entities

### Components

#### 1. Database Schema (`lib/core/database/drift_database.dart`)
- **WordCards**: Stores vocabulary words with spaced repetition data
- **ArticleCards**: Stores der/die/das article practice cards
- **SentenceCards**: Stores fill-in-the-blank sentence exercises
- **Decks**: Stores deck metadata and progress
- **LearningSessions**: Stores learning session history
- **UserProfiles**: Stores user profiles and settings
- **XpHistory**: Stores XP earning history
- **StreakData**: Stores streak tracking data
- **Tests**: Stores test definitions
- **TestSessions**: Stores test session history
- **Statistics**: Stores daily/weekly statistics

#### 2. Database Providers (`lib/core/database/database_providers.dart`)
- `databaseProvider`: Initializes the database singleton
- `dbProvider`: Provides sync access to initialized database
- Convenience providers for common queries: `allWordCards`, `allDecks`, etc.

#### 3. Type Converters (`lib/core/database/converters.dart`)
Converts between:
- Freezed models ↔ Drift data classes
- Enums ↔ String representation
- Complex types (List, DateTime) ↔ JSON strings

#### 4. Drift Repository Implementations
- `CardsRepositoryDrift`: Drift-based cards repository
- `DecksRepositoryDrift`: Drift-based decks repository
- `SessionRepositoryDrift`: Drift-based session repository
- `CardsProvidersDrift`: Riverpod providers for Drift repositories

#### 5. Data Management
- `DatabaseSeeder`: Seeds database with mock data
- `MigrationService`: Handles data migration from SharedPreferences

## Setup Instructions

### 1. Dependencies Added
```yaml
dependencies:
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.18
  path_provider: ^2.1.1
  path: ^1.8.3
  uuid: ^4.3.3

dev_dependencies:
  drift_dev: ^2.14.0
```

### 2. Run Code Generation
```bash
# Generate Drift database code
flutter pub run build_runner build --delete-conflicting-outputs

# Or for watch mode during development
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 3. Database Initialization
The database is automatically initialized in `main.dart`:
```dart
await AppDatabase.initialize();
```

## Usage Examples

### Using Drift Repositories (Recommended)
```dart
// In your widget or service
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
      error: (e, stack) => Text('Error: $e'),
    );
  }
}
```

### Using Database Directly (Advanced)
```dart
final db = await ref.watch(databaseProvider.future);
final decks = await db.getAllDecks();
```

### Writing Data
```dart
final sessionRepo = await ref.watch(sessionRepositoryDriftProvider.future);
await sessionRepo.createSession(deckId);
```

## Migration Strategy

### Option 1: Gradual Migration (Recommended)
1. Keep using existing mock-based providers for features not yet migrated
2. Switch specific features to use `*Drift` providers
3. Test each feature independently
4. Once all features are migrated, remove mock implementations

### Example: Migrating Deck List Screen
```dart
// Before (using mock)
final decksAsync = ref.watch(allDecksProvider);

// After (using Drift)
final decksAsync = ref.watch(allDecksDriftProvider);
```

### Option 2: Global Switch
Replace all repository provider instances in `cards_providers.dart`:
```dart
// Change from
final cardsRepositoryProvider = Provider<CardsRepository>((ref) {
  return CardsRepositoryImpl();
});

// To
final cardsRepositoryProvider = FutureProvider<CardsRepository>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return CardsRepositoryDrift(db);
});
```

## Database Seeding

The database is automatically seeded with mock data on first launch:
- 25 word cards
- 8 article cards
- 8 sentence cards
- 5 decks

To reseed data (for testing):
```dart
final seeder = DatabaseSeeder(AppDatabase.instance);
await seeder.reseed();
```

## Migration from SharedPreferences

To migrate existing user data from SharedPreferences to Drift:
```dart
final migrationService = MigrationService(
  AppDatabase.instance,
  profileRepository,
);
await migrationService.migrateFromSharedPreferences();
```

This will:
1. Seed mock data if database is empty
2. Migrate user profile from SharedPreferences
3. Migrate session history (if available)
4. Migrate statistics (if available)

## Data Models Compatibility

All existing Freezed models remain fully compatible:
- ✅ WordCard, ArticleCard, SentenceCard
- ✅ Deck, LearningSession
- ✅ UserProfile, AppSettings, LearningPreferences
- ✅ XpData, StreakData
- ✅ StatisticsModel, TestModel

The converters handle all transformations transparently.

## API Reference

### Database Access
```dart
// Get database instance
final db = AppDatabase.instance;

// Or use provider
final db = await ref.watch(databaseProvider.future);
```

### Common Queries
```dart
// Word cards
await db.getAllWordCards();
await db.getWordCardById(id);
await db.getWordCardsByLevel(level);

// Decks
await db.getAllDecks();
await db.getDeckById(id);
await db.getRecentDecks(limit: 5);

// Sessions
await db.getCurrentSession();
await db.getSessionHistory();

// Statistics
await db.getStatisticsByDateRange(start, end);
```

## Testing

### Running Tests with Drift
The database layer is designed to be testable. For testing:
```dart
test('database operations', () async {
  // Use in-memory database for tests
  final db = AppDatabase(NativeDatabase.memory());
  final seeder = DatabaseSeeder(db);
  await seeder.seedAll();
  
  // Run your tests...
});
```

## Benefits Over Hive/SharedPreferences

### Advantages of Drift
1. **Type Safety**: Compile-time type checking
2. **SQL Queries**: Complex queries with joins, aggregations
3. **Migrations**: Structured versioning and migrations
4. **Relations**: Better handling of related data
5. **Transactions**: ACID guarantees for data integrity
6. **Streaming**: Real-time data updates via queries
7. **Tooling**: Better debugging and inspection tools

### Performance
- Efficient indexing
- Query optimization
- Lazy loading support
- Batch operations

## Troubleshooting

### Build Errors
If you encounter build errors after adding dependencies:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Database Not Initialized
Error: "Database not initialized"
- Ensure `await AppDatabase.initialize()` is called in `main.dart`

### Migration Issues
If data migration fails:
- Check SharedPreferences keys in `ProfileRepository`
- Verify JSON parsing in converters
- Check error logs for specific failures

## Future Enhancements

1. **Streaming Queries**: Use Drift's watch capabilities for real-time UI updates
2. **Complex Queries**: Add joins and aggregations for statistics
3. **Offline Sync**: Prepare structure for future cloud sync
4. **Full-Text Search**: Implement search functionality with Drift
5. **Analytics**: Use SQL for advanced analytics queries

## Backward Compatibility

The implementation maintains full backward compatibility:
- All existing code continues to work without changes
- Mock repositories remain functional
- Gradual migration is supported
- No breaking changes to public APIs

## Conclusion

This Drift implementation provides a robust foundation for local data persistence while maintaining flexibility for incremental migration. The dual-repository approach allows teams to adopt the database at their own pace without disrupting existing functionality.
