import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import '../models/chat_message_model.dart';

class ChatCacheService {
  final Map<String, CachedResponse> _cache = {};
  static const int _maxCacheSize = 100;
  final List<String> _accessOrder = [];

  ChatMessageModel? getCachedResponse(String message) {
    final key = _generateCacheKey(message);
    final cached = _cache[key];

    if (cached != null && !_isExpired(cached)) {
      _updateAccessOrder(key);
      return cached.message.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
      );
    }

    return null;
  }

  void cacheResponse(String message, ChatMessageModel response) {
    final key = _generateCacheKey(message);

    // Remove oldest if cache is full
    if (_cache.length >= _maxCacheSize) {
      final oldestKey = _accessOrder.removeAt(0);
      _cache.remove(oldestKey);
    }

    _cache[key] = CachedResponse(
      message: response,
      timestamp: DateTime.now(),
    );
    _updateAccessOrder(key);
  }

  void clearCache() {
    _cache.clear();
    _accessOrder.clear();
  }

  void clearExpiredCache() {
    final now = DateTime.now();
    final expiredKeys = <String>[];

    _cache.forEach((key, cached) {
      if (_isExpired(cached, now)) {
        expiredKeys.add(key);
      }
    });

    for (final key in expiredKeys) {
      _cache.remove(key);
      _accessOrder.remove(key);
    }
  }

  int get cacheSize => _cache.length;

  String _generateCacheKey(String message) {
    final bytes = message.codeUnits;
    final hash = _simpleHash(bytes);
    return hash.toString();
  }

  void _updateAccessOrder(String key) {
    _accessOrder.remove(key);
    _accessOrder.add(key);
  }

  bool _isExpired(CachedResponse cached, [DateTime? now]) {
    final checkTime = now ?? DateTime.now();
    return cached.timestamp
        .add(const Duration(hours: 24))
        .isBefore(checkTime);
  }

  int _simpleHash(List<int> bytes) {
    var hash = 0;
    for (final byte in bytes) {
      hash = ((hash << 5) - hash + byte) & 0xFFFFFFFF;
    }
    return hash;
  }
}

class CachedResponse {
  final ChatMessageModel message;
  final DateTime timestamp;

  CachedResponse({
    required this.message,
    required this.timestamp,
  });
}
