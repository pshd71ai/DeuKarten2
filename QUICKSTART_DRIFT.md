# Quick Start: Drift Database in DeuKarten

## 5-Minute Setup Guide

### Step 1: Install Dependencies (1 minute)

```bash
flutter pub get
```

### Step 2: Generate Code (2 minutes)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Run the App (1 minute)

```bash
flutter run
```

That's it! The database will:
- Auto-initialize on first run
- Seed with mock data
- Be ready to use

## Immediate Benefits

Even without migrating existing code, you can now:

1. ✅ Use Drift for new features
2. ✅ Test database operations
3. ✅ Explore the examples
4. ✅ Plan your migration strategy

## Quick Usage Examples

### Example 1: Display All Decks

```dart
import 'package:deu_karten/features/cards/providers/cards_providers_drift.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);
    
    return decksAsync.when(
      data: (decks) => Text('Found ${decks.length} decks'),
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

### Example 2: Get Specific Card

```dart
final cardAsync = ref.watch(wordCardByIdDriftProvider('card-1'));

cardAsync.when(
  data: (card) {
    if (card != null) {
      return Text('${card.article} ${card.germanWord}');
    }
    return Text('Card not found');
  },
  loading: () => CircularProgressIndicator(),
  error: (e, s) => Text('Error: $e'),
);
```

### Example 3: Direct Database Access

```dart
final db = await ref.read(databaseProvider.future);
final decks = await db.getAllDecks();
print('Total decks: ${decks.length}');
```

## What Happens on First Run

1. **Database Initialization**
   ```
   AppDatabase.initialize()
   ↓
   Creates deu_karten.db file
   ```

2. **Automatic Seeding**
   ```
   DatabaseSeeder.seedAll()
   ↓
   - 25 word cards
   - 8 article cards
   - 8 sentence cards
   - 5 decks
   ```

3. **Ready to Use**
   - All providers work immediately
   - No additional setup needed
   - Data persists across app restarts

## Next Steps

### For New Features
Use Drift providers directly:
```dart
final decksAsync = ref.watch(allDecksDriftProvider);
```

### For Existing Features
Keep using current providers:
```dart
final decksAsync = ref.watch(allDecksProvider);
```

### To Migrate Gradually
See [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md)

## Common Tasks

### Reset Database Data

```dart
final seeder = DatabaseSeeder(AppDatabase.instance);
await seeder.reseed();
```

### Check Database Status

```dart
final db = AppDatabase.instance;
final decks = await db.getAllDecks();
print('Database has ${decks.length} decks');
```

### Export Data

```dart
// Data is automatically persisted
// Located at: ApplicationDocumentsDirectory/deu_karten.db
```

## Architecture Summary

```
UI Layer (Widgets)
    ↓ watch
Provider Layer (allDecksDriftProvider)
    ↓ uses
Repository Layer (CardsRepositoryDrift)
    ↓ uses
Database Layer (AppDatabase)
    ↓ stores in
SQLite File (deu_karten.db)
```

## Key Files

| File | Purpose |
|------|---------|
| `lib/core/database/drift_database.dart` | Database schema |
| `lib/core/database/database_providers.dart` | Riverpod providers |
| `lib/core/database/converters.dart` | Type conversion |
| `lib/core/database/seed_data.dart` | Seed data |
| `lib/core/database/migration_service.dart` | Data migration |
| `lib/features/cards/providers/cards_providers_drift.dart` | Card providers |

## Provider Naming

- **Mock providers**: `allDecksProvider`
- **Drift providers**: `allDecksDriftProvider`

Simply add "Drift" to the provider name to use the database!

## Documentation

- **[DRIFT_IMPLEMENTATION_SUMMARY.md](./DRIFT_IMPLEMENTATION_SUMMARY.md)** - Complete overview
- **[DRIFT_DATABASE_IMPLEMENTATION.md](./DRIFT_DATABASE_IMPLEMENTATION.md)** - Detailed guide
- **[MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md)** - Step-by-step migration
- **[examples/drift_usage_examples.dart](./examples/drift_usage_examples.dart)** - Code examples
- **[lib/core/database/README.md](./lib/core/database/README.md)** - Module docs

## Troubleshooting

### Build Errors
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### "Database not initialized"
- Make sure `await AppDatabase.initialize()` is in `main.dart`
- Check that the app has storage permissions

### Provider Not Found
- Ensure you're using the correct provider name
- Add "Drift" suffix for database providers
- Example: `allDecksDriftProvider` not `allDecksProvider`

## Support

Need help?
1. Check documentation files listed above
2. Review code examples in `examples/`
3. Check Drift documentation: https://drift.simonbinder.eu/

## Summary

✅ Database ready to use immediately
✅ No code changes required
✅ Automatic seeding on first run
✅ Full backward compatibility
✅ Gradual migration available

**You're ready to go! 🚀**
