// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inGameUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InGameUser _$InGameUserFromJson(Map<String, dynamic> json) {
  return InGameUser(
    money: json['money'] as int,
    ownedPassives: (json['ownedPassives'] as List)
        ?.map((e) =>
            e == null ? null : Passive.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    troopMultiplier: (json['troopMultiplier'] as num)?.toDouble(),
    moneyMultiplier: (json['moneyMultiplier'] as num)?.toDouble(),
    genTroops: json['genTroops'] as int,
    genMoney: json['genMoney'] as int,
    userName: json['username'] as String,
    faction: json['faction'] as String,
    turnID: json['turnID'] as int,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$InGameUserToJson(InGameUser instance) =>
    <String, dynamic>{
      'money': instance.money,
      'ownedPassives':
          instance.ownedPassives?.map((e) => e?.toJson())?.toList(),
      'troopMultiplier': instance.troopMultiplier,
      'moneyMultiplier': instance.moneyMultiplier,
      'genTroops': instance.genTroops,
      'genMoney': instance.genMoney,
      'username': instance.userName,
      'faction': instance.faction,
      'turnID': instance.turnID,
      'role': instance.role,
    };
