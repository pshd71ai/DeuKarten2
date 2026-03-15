# Drift Usage Examples

This directory contains practical code examples demonstrating how to use the Drift database in the DeuKarten app.

## Examples Overview

The `drift_usage_examples.dart` file contains 10 comprehensive examples:

1. **DeckListExample** - Basic widget using Drift provider
2. **DeckDetailExample** - Using family provider for specific items
3. **SessionExample** - Creating and updating data
4. **DirectDatabaseExample** - Direct database access (advanced)
5. **AdvancedQueryExample** - Complex queries with joins
6. **PaginatedCardsExample** - Pagination and filtering
7. **SearchCardsExample** - Search functionality
8. **TransactionExample** - Transaction support
9. **StatisticsQueryExample** - Statistics queries
10. **RealtimeUpdatesExample** - Real-time updates with watch

## How to Use These Examples

### Copy and Modify

You can copy any example widget into your codebase and modify it for your needs:

```dart
// From examples
class DeckListExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);
    // ...
  }
}

// Modified for your app
class MyDeckList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(allDecksDriftProvider);
    // Your custom implementation
  }
}
```

### Learning by Example

Each example demonstrates a specific concept:

- **Basic Usage**: Example 1, 2
- **Data Operations**: Example 3, 4, 8
- **Advanced Queries**: Example 5, 9
- **User Interactions**: Example 6, 7
- **Real-time Features**: Example 10

## Running Examples

To see the examples in action, you can:

1. Create a test screen in your app
2. Add the example widget
3. Navigate to the test screen
4. Observe the behavior

Example test screen:

```dart
class ExamplesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drift Examples')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Deck List'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DeckListExample()),
            ),
          ),
          ListTile(
            title: Text('Search Cards'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchCardsExample()),
            ),
          ),
          // ... more examples
        ],
      ),
    );
  }
}
```

## Key Concepts Demonstrated

### Provider Watching
```dart
final decksAsync = ref.watch(allDecksDriftProvider);
return decksAsync.when(
  data: (decks) => /* build with data */,
  loading: () => /* show loading */,
  error: (e, s) => /* show error */,
);
```

### Data Retrieval
```dart
final repo = await ref.read(cardsRepositoryDriftProvider.future);
final cards = await repo.getWordCards();
```

### Data Updates
```dart
final repo = await ref.read(sessionRepositoryDriftProvider.future);
await repo.createSession(deckId);
```

### Direct Database Access
```dart
final db = await ref.read(databaseProvider.future);
final decks = await db.getAllDecks();
```

## Adapting Examples

### Using Different Providers

Replace the provider in the example with the one you need:

```dart
// Example uses
final decksAsync = ref.watch(allDecksDriftProvider);

// You might use
final cardsAsync = ref.watch(allWordCardsDriftProvider);
final cardAsync = ref.watch(wordCardByIdDriftProvider(cardId));
```

### Adding Error Handling

Enhance examples with better error handling:

```dart
return decksAsync.when(
  data: (decks) => YourWidget(decks),
  loading: () => Center(child: CircularProgressIndicator()),
  error: (error, stack) => ErrorWidget(
    error: error,
    onRetry: () => ref.invalidate(allDecksDriftProvider),
  ),
);
```

### Adding Loading States

Customize loading indicators:

```dart
loading: () => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
      SizedBox(height: 16),
      Text('Loading decks...'),
    ],
  ),
),
```

## Best Practices Shown in Examples

1. **Use Providers**: Watch providers, don't call manually
2. **Handle Async**: Always handle loading and error states
3. **Type Safety**: Use converters, don't cast
4. **Separation**: Keep data access in repositories
5. **User Experience**: Show loading states and errors
6. **Performance**: Use pagination for large datasets

## Common Patterns

### Loading Single Item
```dart
final itemAsync = ref.watch(itemByIdDriftProvider(id));
itemAsync.when(
  data: (item) => item != null ? ItemWidget(item) : EmptyWidget(),
  loading: () => LoadingWidget(),
  error: (e, s) => ErrorWidget(e),
);
```

### Loading List
```dart
final itemsAsync = ref.watch(allItemsDriftProvider);
itemsAsync.when(
  data: (items) => ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ItemWidget(items[index]),
  ),
  loading: () => LoadingWidget(),
  error: (e, s) => ErrorWidget(e),
);
```

### Creating Item
```dart
Future<void> createItem() async {
  final repo = await ref.read(repositoryDriftProvider.future);
  await repo.createItem(params);
}
```

### Updating Item
```dart
Future<void> updateItem(String id) async {
  final repo = await ref.read(repositoryDriftProvider.future);
  await repo.updateItem(id, updates);
}
```

## Testing Examples

You can test the examples in isolation:

```dart
testWidgets('DeckListExample loads decks', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(home: DeckListExample()),
    ),
  );
  
  expect(find.text('Decks'), findsOneWidget);
  // Add more assertions
});
```

## Next Steps

After reviewing examples:

1. Choose an example relevant to your feature
2. Copy it to your codebase
3. Adapt it to your needs
4. Test it thoroughly
5. Refactor if needed

## Additional Resources

- [Drift Documentation](https://drift.simonbinder.eu/)
- [Riverpod Documentation](https://riverpod.dev/)
- [QUICKSTART_DRIFT.md](../QUICKSTART_DRIFT.md)
- [DRIFT_DATABASE_IMPLEMENTATION.md](../DRIFT_DATABASE_IMPLEMENTATION.md)

## Support

If you need help understanding an example:

1. Check the inline comments in the example
2. Review the main documentation files
3. Look at the provider implementations
4. Check Drift documentation

## Contributing

If you create useful examples that could help others:

1. Add them to `drift_usage_examples.dart`
2. Document what they demonstrate
3. Update this README with a brief description
4. Follow the existing code style
