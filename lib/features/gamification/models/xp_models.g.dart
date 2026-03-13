// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$XpDataImpl _$$XpDataImplFromJson(Map<String, dynamic> json) => _$XpDataImpl(
      currentXp: (json['currentXp'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      xpForNextLevel: (json['xpForNextLevel'] as num).toInt(),
      xpInCurrentLevel: (json['xpInCurrentLevel'] as num).toInt(),
      totalXpEarned: (json['totalXpEarned'] as num).toInt(),
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

_$XpHistoryEntryImpl _$$XpHistoryEntryImplFromJson(Map<String, dynamic> json) =>
    _$XpHistoryEntryImpl(
      amount: (json['amount'] as num).toInt(),
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
