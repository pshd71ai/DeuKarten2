# Migration Guide: Moving from Mock to Drift Database

## Overview
This guide helps you migrate from mock data implementations to Drift database implementation in the DeuKarten app.

## Prerequisites

1. Read the [Drift Database Implementation Guide](./DRIFT_DATABASE_IMPLEMENTATION.md)
2. Ensure you have the latest dependencies: `flutter pub get`
3. Run code generation: `flutter pub run build_runner build --delete-conflicting-outputs`

## Step-by-Step Migration

### Step 1: Verify Database Initialization

Ensure your `main.dart` includes database initialization:

```dart
import 'core/database/database_providers.dart';
import 'core/database/migration_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Drift Database
  await AppDatabase.initialize();
  
  // ... rest of main.dart
}
```

### Step 2: Choose Migration Strategy

#### Option A: Feature-by-Feature Migration (Recommended)
Migrate one feature at a time to minimize risk.

#### Option B: Global Switch
Replace all mock implementations at once.

This guide uses Option A.

### Step 3: Migrate Cards Feature

#### 3.1 Update Cards Provider Imports

In files using cards providers:

```dart
// Before
import 'package:deu_karten/features/cards/providers/cards_providers.dart';

// After
import 'package:deu_karten/features/cards/providers/cards_providers_drift.dart';
```

#### 3.2 Update Provider References

```dart
// Before
final decksAsync = ref.watch(allDecksProvider);

// After
final decksAsync = ref.watch(allDecksDriftProvider);
```

#### 3.3 Common Provider Name Changes

| Old Provider | New Provider |
|-------------|--------------|
| `allDecksProvider` | `allDecksDriftProvider` |
| `deckByIdProvider` | `deckByIdDriftProvider` |
| `decksByLevelProvider` | `decksByLevelDriftProvider` |
| `recentDecksProvider` | `recentDecksDriftProvider` |
| `allWordCardsProvider` | `allWordCardsDriftProvider` |
| `wordCardByIdProvider` | `wordCardByIdDriftProvider` |
| `cardsForSessionProvider` | `cardsForSessionDriftProvider` |
| `currentSessionProvider` | `currentSessionDriftProvider` |

### Step 4: Migrate Gamification Feature

#### 4.1 Create Drift-based Gamification Repository

Create `lib/features/gamification/repositories/xp_repository_drift.dart`:

```dart
import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/features/gamification/models/xp_models.dart';

class XpRepositoryDrift implements XpRepository {
  final AppDatabase _db;

  XpRepositoryDrift(this._db);

  @override
  Future<XpData> getXpData() async {
    // Get all XP history entries
    final entries = await _db.select(xpHistory).get();
    
    // Calculate totals
    final currentXp = entries.fold<int>(0, (sum, e) => sum + e.amount);
    final history = entries.map(xpHistoryFromData).toList();
    
    return XpData(
      currentXp: currentXp,
      level: _calculateLevel(currentXp),
      xpForNextLevel: _xpForLevel(_calculateLevel(currentXp) + 1),
      xpInCurrentLevel: currentXp - _xpForLevel(_calculateLevel(currentXp)),
      totalXpEarned: currentXp,
      history: history,
    );
  }

  @override
  Future<void> addXp(int amount, String source, {String? description}) async {
    final entry = XpHistoryEntry(
      amount: amount,
      source: source,
      timestamp: DateTime.now(),
      description: description,
    );
    await _db.into(xpHistory).insert(xpHistoryToData(entry));
  }

  // ... implement other methods
}
```

#### 4.2 Create Drift-based Providers

Create `lib/features/gamification/providers/xp_providers_drift.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:deu_karten/core/database/database_providers.dart';
import '../repositories/xp_repository_drift.dart';

part 'xp_providers_drift.g.dart';

@Riverpod(keepAlive: true)
Future<XpRepository> xpRepositoryDrift(XpRepositoryDriftRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return XpRepositoryDrift(db);
}
```

### Step 5: Migrate Statistics Feature

#### 5.1 Create Drift-based Statistics Repository

Create `lib/features/statistics/repositories/statistics_repository_drift.dart`:

```dart
import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/features/statistics/models/statistics_model.dart';

class StatisticsRepositoryDrift implements StatisticsRepository {
  final AppDatabase _db;

  StatisticsRepositoryDrift(this._db);

  @override
  Future<List<StatisticsModel>> getDailyStatistics({int days = 30}) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    final data = await _db.getStatisticsByDateRange(startDate, DateTime.now());
    return data.map(statisticsFromData).toList();
  }

  @override
  Future<void> recordStatistics(StatisticsModel stats) async {
    // Check if stats for this date exist
    final existing = await (_db.select(statistics)
          ..where((tbl) => tbl.date.equals(stats.date)))
        .getSingleOrNull();
    
    if (existing != null) {
      await _db.update(statistics).replace(statisticsToData(stats));
    } else {
      await _db.into(statistics).insert(statisticsToData(stats));
    }
  }

  // ... implement other methods
}
```

### Step 6: Migrate Tests Feature

#### 6.1 Create Drift-based Tests Repository

Similar pattern to cards and statistics.

### Step 7: Migrate Profile Feature

#### 7.1 Update Profile Repository to Use Drift

The profile feature already has a repository structure. Update `ProfileRepositoryImpl` to use the database:

```dart
class ProfileRepositoryImpl implements ProfileRepository {
  final AppDatabase _db;
  final SharedPreferences _prefs;

  ProfileRepositoryImpl(this._db, this._prefs);

  @override
  Future<UserProfile?> getUserProfile() async {
    // Try database first
    final profiles = await _db.select(userProfiles).limit(1).get();
    if (profiles.isNotEmpty) {
      return userProfileFromData(profiles.first);
    }
    
    // Fallback to SharedPreferences for migration
    final json = _prefs.getString('user_profile');
    if (json != null) {
      return UserProfile.fromJson(jsonDecode(json));
    }
    
    return null;
  }

  @override
  Future<void> saveUserProfile(UserProfile profile) async {
    // Save to database
    final existing = await (_db.select(userProfiles)
          ..where((tbl) => tbl.id.equals(profile.id)))
        .getSingleOrNull();
    
    if (existing != null) {
      await _db.update(userProfiles).replace(userProfileToData(profile));
    } else {
      await _db.into(userProfiles).insert(userProfileToData(profile));
    }
    
    // Also keep SharedPreferences as backup during migration
    await _prefs.setString('user_profile', jsonEncode(profile.toJson()));
  }

  // ... implement other methods
}
```

### Step 8: Update UI Components

After migrating repositories, update UI components to use the new providers:

#### Example: Deck List Screen

```dart
class DeckListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Change provider
    final decksAsync = ref.watch(allDecksDriftProvider);
    
    return decksAsync.when(
      data: (decks) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: decks.length,
        itemBuilder: (context, index) {
          return DeckCard(decks[index]);
        },
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
```

### Step 9: Test Thoroughly

1. **Unit Tests**: Test repository methods
2. **Integration Tests**: Test database operations
3. **UI Tests**: Test screens with new providers
4. **Migration Tests**: Test data migration from SharedPreferences

### Step 10: Clean Up

After successful migration:

1. Remove mock repository implementations
2. Remove `cards_providers.dart` (replaced by `cards_providers_drift.dart`)
3. Update imports throughout the codebase
4. Update documentation

## Common Issues and Solutions

### Issue: Provider Not Found

**Problem**: `ProviderNotFoundException` when using Drift providers

**Solution**: Ensure the database is initialized before accessing providers:
```dart
// In main.dart
await AppDatabase.initialize();
```

### Issue: Type Mismatch

**Problem**: Type errors between Freezed models and Drift data classes

**Solution**: Always use converters:
```dart
// Wrong
final data = await db.getWordCardById(id);
return data as WordCard;

// Correct
final data = await db.getWordCardById(id);
return wordCardFromData(data);
```

### Issue: Null Safety

**Problem**: Null check errors when migrating from mock data

**Solution**: Handle nullable values properly:
```dart
final deckAsync = ref.watch(deckByIdDriftProvider(id));
return deckAsync.when(
  data: (deck) => deck != null ? DeckWidget(deck) : EmptyWidget(),
  // ...
);
```

### Issue: Data Not Persisting

**Problem**: Data lost after app restart

**Solution**: Ensure you're using the database, not in-memory:
```dart
// In drift_database.dart
static Future<void> initialize() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'deu_karten.db'));
  _instance = AppDatabase(NativeDatabase.createInBackground(file));
}
```

## Verification Checklist

After migration, verify:

- [ ] Database initializes successfully
- [ ] Mock data is seeded correctly
- [ ] All screens load without errors
- [ ] Data persists across app restarts
- [ ] User profile is saved and retrieved
- [ ] Statistics are recorded correctly
- [ ] XP system works as expected
- [ ] Session history is preserved
- [ ] All tests pass

## Rollback Plan

If issues arise:

1. Revert provider imports to use mock implementations
2. Keep database initialization code (it won't affect mock data)
3. Fix issues in Drift implementation
4. Retry migration

## Performance Considerations

After migration, monitor:

- Database query performance
- Memory usage
- App startup time
- Battery consumption

If performance issues occur:

1. Add database indexes
2. Optimize queries
3. Use lazy loading
4. Implement query caching

## Next Steps

After successful migration:

1. Implement streaming queries for real-time updates
2. Add complex queries for advanced statistics
3. Implement offline sync with cloud backend
4. Add full-text search functionality
5. Implement data export/import features

## Support

For questions or issues:
1. Check the [Drift Database Implementation Guide](./DRIFT_DATABASE_IMPLEMENTATION.md)
2. Review the [Drift documentation](https://drift.simonbinder.eu/)
3. Check existing code in `lib/core/database/`

## Conclusion

This migration provides a robust, type-safe database foundation while maintaining backward compatibility. Take your time, test thoroughly, and migrate incrementally for the best results.
