// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_cards_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayCardsProviderHash() => r'3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a';

/// See also [todayCardsProvider].
@ProviderFor(todayCardsProvider)
final todayCardsProvider = AutoDisposeFutureProvider<TodayCardsState>.internal(
  todayCardsProvider,
  name: r'todayCardsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayCardsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodayCardsProviderRef = AutoDisposeFutureProviderRef<TodayCardsState>;
String _$cardProgressNotifierHash() => r'1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b';

/// Copied from [CardProgressNotifier].
@ProviderFor(CardProgressNotifier)
const cardProgressNotifierProvider = CardProgressNotifierFamily();

/// Copied from [CardProgressNotifier].
class CardProgressNotifierFamily
    extends Family<AsyncValue<CardProgress?>> {
  /// Copied from [CardProgressNotifier].
  const CardProgressNotifierFamily();

  /// Copied from [CardProgressNotifier].
  CardProgressNotifierProvider call(
    String cardId,
  ) {
    return CardProgressNotifierProvider(
      cardId,
    );
  }

  @override
  CardProgressNotifierProvider getProviderOverride(
    covariant CardProgressNotifierProvider provider,
  ) {
    return call(provider.cardId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cardProgressNotifierProvider';
}

/// Copied from [CardProgressNotifier].
class CardProgressNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CardProgressNotifier,
        CardProgress?> {
  /// Copied from [CardProgressNotifier].
  CardProgressNotifierProvider(
    String cardId,
  ) : this._internal(
          () => CardProgressNotifier()..cardId = cardId,
          from: cardProgressNotifierProvider,
          name: r'cardProgressNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cardProgressNotifierHash,
          dependencies: CardProgressNotifierFamily._dependencies,
          allTransitiveDependencies:
              CardProgressNotifierFamily._allTransitiveDependencies,
          cardId: cardId,
        );

  CardProgressNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cardId,
  }) : super.internal();

  final String cardId;

  @override
  FutureOr<CardProgress?> runNotifierBuild(
    covariant CardProgressNotifier notifier,
  ) {
    return notifier.build(cardId);
  }

  @override
  Override overrideWith(CardProgressNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CardProgressNotifierProvider._internal(
        () => create()..cardId = cardId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cardId: cardId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CardProgressNotifier, CardProgress?>
      createElement() {
    return AutoDisposeAsyncNotifierProviderElement<CardProgressNotifier,
        CardProgress?>(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CardProgressNotifierProvider && other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CardProgressNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CardProgress?> {
  /// The parameter `cardId` of this provider.
  String get cardId;
}

class _CardProgressNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CardProgressNotifier,
        CardProgress?> with CardProgressNotifierRef {
  _CardProgressNotifierProviderElement(super.provider);

  @override
  String get cardId => (origin as CardProgressNotifierProvider).cardId;
}
