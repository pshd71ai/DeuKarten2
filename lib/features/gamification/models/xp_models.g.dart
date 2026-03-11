// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$XpDataImpl _$$XpDataImplFromJson(Map<String, dynamic> json) => _$XpDataImpl(
      currentXp: json['currentXp'] as int,
      level: json['level'] as int,
      xpForNextLevel: json['xpForNextLevel'] as int,
      xpInCurrentLevel: json['xpInCurrentLevel'] as int,
      totalXpEarned: json['totalXpEarned'] as int,
      history: (json['history'] as List<dynamic>)
          .map((e) => XpHistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$XpDataImplToJson(_$XpDataImpl instance) =>
    <String, dynamic>{
      'currentXp': instance.currentXp,
      'level': instance.level,
      'xpForNextLevel': instance.xpForNextLevel,
      'xpInCurrentLevel': instance.xpInCurrentLevel,
      'totalXpEarned': instance.totalXpEarned,
      'history': instance.history,
    };

_$XpHistoryEntryImpl _$$XpHistoryEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$XpHistoryEntryImpl(
      amount: json['amount'] as int,
      source: json['source'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$XpHistoryEntryImplToJson(
        _$XpHistoryEntryImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'source': instance.source,
      'timestamp': instance.timestamp.toIso8601String(),
      'description': instance.description,
    };
