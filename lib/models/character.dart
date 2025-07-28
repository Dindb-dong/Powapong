import 'package:flutter/material.dart';

// 속성 열거형 (puzzle_game_screen에서 가져올 예정)
enum Attribute {
  fire, // 🔥불
  water, // 💧물
  grass, // 🌿풀
  wind, // 🌬바람
  electric, // ⚡전기
  ice, // ❄️얼음
  poison, // 🧪부식
  rock, // 🪨바위
  metal, // ⚙금속
  earth, // 🪵흙
  dark, // 🌑어둠
  light, // ✨빛
}

// 패시브 특성 카테고리
enum PassiveCategory { combat, survival, utility, social, support }

// 스킬 카테고리
enum SkillCategory { attack, defense, support, special, utility }

// 패시브 특성 클래스
class PassiveTrait {
  final String name;
  final String description;
  final PassiveCategory category;
  final int level;
  final int maxLevel;

  PassiveTrait({
    required this.name,
    required this.description,
    required this.category,
    required this.level,
    required this.maxLevel,
  });
}

// 스킬 클래스
class Skill {
  final String name;
  final String description;
  final SkillCategory category;
  final int level;
  final int maxLevel;
  final double gaugeProgress; // 0.0 ~ 1.0

  Skill({
    required this.name,
    required this.description,
    required this.category,
    required this.level,
    required this.maxLevel,
    required this.gaugeProgress,
  });
}

// 무기/장비 클래스 (나중에 상세 구현 예정)
class Equipment {
  final String name;
  final String description;
  final String type; // weapon, armor, accessory 등

  Equipment({
    required this.name,
    required this.description,
    required this.type,
  });
}

// 캐릭터 클래스
class Character {
  final String id;
  final String name;
  final String description;
  final List<Attribute> attributes; // 1~2개
  final Equipment? weapon;
  final Equipment? armor;
  final Equipment? accessory;
  final int level;
  final double levelProgress; // 0.0 ~ 1.0
  final List<PassiveTrait> passiveTraits;
  final List<Skill> skills;
  final String imagePath; // 임시로 사용할 이미지 경로

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.attributes,
    this.weapon,
    this.armor,
    this.accessory,
    required this.level,
    required this.levelProgress,
    required this.passiveTraits,
    required this.skills,
    required this.imagePath,
  });

  // 레벨 퍼센테이지 계산
  double get levelPercentage => levelProgress * 100;

  // 속성 이름 변환
  String getAttributeName(Attribute attribute) {
    switch (attribute) {
      case Attribute.fire:
        return 'Fire';
      case Attribute.water:
        return 'Water';
      case Attribute.grass:
        return 'Grass';
      case Attribute.wind:
        return 'Wind';
      case Attribute.electric:
        return 'Electric';
      case Attribute.ice:
        return 'Ice';
      case Attribute.poison:
        return 'Poison';
      case Attribute.rock:
        return 'Rock';
      case Attribute.metal:
        return 'Metal';
      case Attribute.earth:
        return 'Earth';
      case Attribute.dark:
        return 'Dark';
      case Attribute.light:
        return 'Light';
    }
  }

  // 속성 색상 반환
  Color getAttributeColor(Attribute attribute) {
    switch (attribute) {
      case Attribute.fire:
        return const Color(0xFFFF4444); // 🔥 빨강
      case Attribute.water:
        return const Color(0xFF4444FF); // 💧 파랑
      case Attribute.grass:
        return const Color(0xFF44FF44); // 🌿 초록
      case Attribute.wind:
        return const Color(0xFF90EE90); // 🌬 연두
      case Attribute.electric:
        return const Color(0xFFFFFF44); // ⚡ 노랑
      case Attribute.ice:
        return const Color(0xFF44FFFF); // ❄️ 하늘색
      case Attribute.poison:
        return const Color(0xFF800080); // 🧪 보라
      case Attribute.rock:
        return const Color(0xFF8B4513); // 🪨 갈색
      case Attribute.metal:
        return const Color(0xFFC0C0C0); // ⚙ 은색
      case Attribute.earth:
        return const Color(0xFFA0522D); // 🪵 흙색
      case Attribute.dark:
        return const Color(0xFF444444); // 🌑 검정
      case Attribute.light:
        return const Color(0xFFFFFFFF); // ✨ 흰색
    }
  }

  // 속성 이모지 반환
  String getAttributeEmoji(Attribute attribute) {
    switch (attribute) {
      case Attribute.fire:
        return '🔥'; // 불
      case Attribute.water:
        return '💧'; // 물
      case Attribute.grass:
        return '🌿'; // 풀
      case Attribute.wind:
        return '🌬'; // 바람
      case Attribute.electric:
        return '⚡'; // 전기
      case Attribute.ice:
        return '❄️'; // 얼음
      case Attribute.poison:
        return '🧪'; // 부식
      case Attribute.rock:
        return '🪨'; // 바위
      case Attribute.metal:
        return '⚙'; // 금속
      case Attribute.earth:
        return '🪵'; // 흙
      case Attribute.dark:
        return '🌑'; // 어둠
      case Attribute.light:
        return '✨'; // 빛
    }
  }
}
