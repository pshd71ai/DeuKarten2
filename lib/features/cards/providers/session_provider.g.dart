// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,deprecated_member_use_from_same_package

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSessionHash() => r'5c7b5b9b5c7b5b9b5c7b5b9b5c7b5b9b5c7b5b9b';

/// See also [CurrentSession].
@ProviderFor(CurrentSession)
final currentSessionProvider = AutoDisposeAsyncNotifierProvider<CurrentSession,
    LearningSession?>.internal(
  CurrentSession.new,
  name: r'currentSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSession = AutoDisposeAsyncNotifier<LearningSession?>;
