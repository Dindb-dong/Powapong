import '../models/character.dart';

class CharacterService {
  static final List<Character> _characters = [
    // 캐릭터 1: Fire + Electric
    Character(
      id: 'char_001',
      name: 'Blaze Storm',
      description: '화염과 번개의 힘을 다루는 전사',
      attributes: [Attribute.fire, Attribute.electric],
      weapon: Equipment(
        name: 'Flame Sword',
        description: '화염 속성 검',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Thunder Armor',
        description: '번개 방어구',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Fire Ring',
        description: '화염 강화 반지',
        type: 'accessory',
      ),
      level: 15,
      levelProgress: 0.75,
      passiveTraits: [
        PassiveTrait(
          name: 'Fire Mastery',
          description: '화염 공격력 20% 증가',
          category: PassiveCategory.combat,
          level: 3,
          maxLevel: 5,
        ),
        PassiveTrait(
          name: 'Lightning Reflex',
          description: '공격 속도 15% 증가',
          category: PassiveCategory.combat,
          level: 2,
          maxLevel: 3,
        ),
      ],
      skills: [
        Skill(
          name: 'Flame Burst',
          description: '강력한 화염 폭발 공격',
          category: SkillCategory.attack,
          level: 2,
          maxLevel: 5,
          gaugeProgress: 0.8,
        ),
        Skill(
          name: 'Thunder Shield',
          description: '번개로 이루어진 방어막',
          category: SkillCategory.defense,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.3,
        ),
      ],
      imagePath: 'assets/images/character1.png',
    ),

    // 캐릭터 2: Water + Ice
    Character(
      id: 'char_002',
      name: 'Frost Wave',
      description: '물과 얼음의 힘을 조합한 마법사',
      attributes: [Attribute.water, Attribute.ice],
      weapon: Equipment(
        name: 'Ice Staff',
        description: '얼음 마법 지팡이',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Water Robe',
        description: '물 속성 로브',
        type: 'armor',
      ),
      accessory: null,
      level: 12,
      levelProgress: 0.45,
      passiveTraits: [
        PassiveTrait(
          name: 'Ice Resistance',
          description: '얼음 속성 저항 30%',
          category: PassiveCategory.survival,
          level: 2,
          maxLevel: 4,
        ),
      ],
      skills: [
        Skill(
          name: 'Frozen Wave',
          description: '얼음 파도로 적을 공격',
          category: SkillCategory.attack,
          level: 3,
          maxLevel: 5,
          gaugeProgress: 1.0,
        ),
        Skill(
          name: 'Healing Water',
          description: '물의 힘으로 체력 회복',
          category: SkillCategory.support,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.6,
        ),
      ],
      imagePath: 'assets/images/character2.png',
    ),

    // 캐릭터 3: Earth + Grass
    Character(
      id: 'char_003',
      name: 'Terra Guardian',
      description: '대지와 자연의 수호자',
      attributes: [Attribute.earth, Attribute.grass],
      weapon: Equipment(
        name: 'Nature Bow',
        description: '자연의 활',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Earth Plate',
        description: '대지의 갑옷',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Nature Amulet',
        description: '자연의 부적',
        type: 'accessory',
      ),
      level: 18,
      levelProgress: 0.2,
      passiveTraits: [
        PassiveTrait(
          name: 'Earth Bond',
          description: '대지에서 체력 회복',
          category: PassiveCategory.survival,
          level: 4,
          maxLevel: 5,
        ),
        PassiveTrait(
          name: 'Nature\'s Blessing',
          description: '자연 속성 공격력 증가',
          category: PassiveCategory.combat,
          level: 2,
          maxLevel: 4,
        ),
      ],
      skills: [
        Skill(
          name: 'Earthquake',
          description: '대지를 흔들어 적을 공격',
          category: SkillCategory.attack,
          level: 4,
          maxLevel: 5,
          gaugeProgress: 0.9,
        ),
        Skill(
          name: 'Nature\'s Shield',
          description: '자연의 힘으로 방어',
          category: SkillCategory.defense,
          level: 2,
          maxLevel: 3,
          gaugeProgress: 0.4,
        ),
      ],
      imagePath: 'assets/images/character3.png',
    ),

    // 캐릭터 4: Light + Metal
    Character(
      id: 'char_004',
      name: 'Divine Light',
      description: '신성한 빛의 사도',
      attributes: [Attribute.light, Attribute.metal],
      weapon: Equipment(
        name: 'Holy Sword',
        description: '신성한 검',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Light Armor',
        description: '빛의 갑옷',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Divine Ring',
        description: '신성한 반지',
        type: 'accessory',
      ),
      level: 20,
      levelProgress: 0.95,
      passiveTraits: [
        PassiveTrait(
          name: 'Divine Protection',
          description: '신성한 보호막',
          category: PassiveCategory.survival,
          level: 5,
          maxLevel: 5,
        ),
        PassiveTrait(
          name: 'Light Mastery',
          description: '빛 속성 마스터리',
          category: PassiveCategory.combat,
          level: 3,
          maxLevel: 5,
        ),
      ],
      skills: [
        Skill(
          name: 'Divine Judgment',
          description: '신성한 심판의 검',
          category: SkillCategory.attack,
          level: 5,
          maxLevel: 5,
          gaugeProgress: 1.0,
        ),
        Skill(
          name: 'Holy Heal',
          description: '신성한 치유 마법',
          category: SkillCategory.support,
          level: 3,
          maxLevel: 5,
          gaugeProgress: 0.7,
        ),
      ],
      imagePath: 'assets/images/character4.png',
    ),

    // 캐릭터 5: Dark + Rock
    Character(
      id: 'char_005',
      name: 'Shadow Lord',
      description: '어둠과 바위의 군주',
      attributes: [Attribute.dark, Attribute.rock],
      weapon: Equipment(
        name: 'Chaos Blade',
        description: '혼돈의 검',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Shadow Cloak',
        description: '어둠의 망토',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Dark Crystal',
        description: '어둠의 결정',
        type: 'accessory',
      ),
      level: 16,
      levelProgress: 0.6,
      passiveTraits: [
        PassiveTrait(
          name: 'Shadow Step',
          description: '어둠 속에서 이동 속도 증가',
          category: PassiveCategory.utility,
          level: 3,
          maxLevel: 4,
        ),
        PassiveTrait(
          name: 'Rock Embrace',
          description: '바위의 힘으로 공격력 증가',
          category: PassiveCategory.combat,
          level: 2,
          maxLevel: 5,
        ),
      ],
      skills: [
        Skill(
          name: 'Dark Void',
          description: '어둠의 공허로 적을 흡수',
          category: SkillCategory.attack,
          level: 3,
          maxLevel: 5,
          gaugeProgress: 0.5,
        ),
        Skill(
          name: 'Rock Storm',
          description: '바위의 폭풍',
          category: SkillCategory.special,
          level: 2,
          maxLevel: 4,
          gaugeProgress: 0.8,
        ),
      ],
      imagePath: 'assets/images/character5.png',
    ),

    // 캐릭터 6: Wind + Electric
    Character(
      id: 'char_006',
      name: 'Storm Rider',
      description: '바람과 번개를 타는 기사',
      attributes: [Attribute.wind, Attribute.electric],
      weapon: Equipment(
        name: 'Wind Spear',
        description: '바람의 창',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Storm Armor',
        description: '폭풍의 갑옷',
        type: 'armor',
      ),
      accessory: null,
      level: 14,
      levelProgress: 0.3,
      passiveTraits: [
        PassiveTrait(
          name: 'Wind Walker',
          description: '바람을 타고 빠르게 이동',
          category: PassiveCategory.utility,
          level: 2,
          maxLevel: 3,
        ),
      ],
      skills: [
        Skill(
          name: 'Lightning Strike',
          description: '번개의 일격',
          category: SkillCategory.attack,
          level: 2,
          maxLevel: 4,
          gaugeProgress: 0.9,
        ),
        Skill(
          name: 'Wind Shield',
          description: '바람의 방어막',
          category: SkillCategory.defense,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.2,
        ),
      ],
      imagePath: 'assets/images/character6.png',
    ),

    // 캐릭터 7: Poison + Grass
    Character(
      id: 'char_007',
      name: 'Venom Weaver',
      description: '독과 자연을 조합한 암살자',
      attributes: [Attribute.poison, Attribute.grass],
      weapon: Equipment(
        name: 'Poison Dagger',
        description: '독이 묻은 단검',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Nature Hide',
        description: '자연의 가죽 갑옷',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Venom Ring',
        description: '독의 반지',
        type: 'accessory',
      ),
      level: 13,
      levelProgress: 0.8,
      passiveTraits: [
        PassiveTrait(
          name: 'Poison Immunity',
          description: '독 저항 100%',
          category: PassiveCategory.survival,
          level: 3,
          maxLevel: 3,
        ),
        PassiveTrait(
          name: 'Stealth Master',
          description: '은밀한 이동',
          category: PassiveCategory.utility,
          level: 2,
          maxLevel: 4,
        ),
      ],
      skills: [
        Skill(
          name: 'Poison Cloud',
          description: '독 구름으로 적을 공격',
          category: SkillCategory.attack,
          level: 3,
          maxLevel: 5,
          gaugeProgress: 0.6,
        ),
        Skill(
          name: 'Nature\'s Camouflage',
          description: '자연과 동화되어 은신',
          category: SkillCategory.special,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.4,
        ),
      ],
      imagePath: 'assets/images/character7.png',
    ),

    // 캐릭터 8: Fire + Light
    Character(
      id: 'char_008',
      name: 'Solar Knight',
      description: '태양의 기사',
      attributes: [Attribute.fire, Attribute.light],
      weapon: Equipment(
        name: 'Solar Blade',
        description: '태양의 검',
        type: 'weapon',
      ),
      armor: Equipment(
        name: 'Radiant Armor',
        description: '빛나는 갑옷',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Sun Gem',
        description: '태양의 보석',
        type: 'accessory',
      ),
      level: 17,
      levelProgress: 0.1,
      passiveTraits: [
        PassiveTrait(
          name: 'Solar Power',
          description: '태양의 힘으로 공격력 증가',
          category: PassiveCategory.combat,
          level: 4,
          maxLevel: 5,
        ),
      ],
      skills: [
        Skill(
          name: 'Solar Flare',
          description: '태양의 폭발',
          category: SkillCategory.attack,
          level: 3,
          maxLevel: 5,
          gaugeProgress: 0.7,
        ),
        Skill(
          name: 'Radiant Aura',
          description: '빛나는 오라로 방어',
          category: SkillCategory.defense,
          level: 2,
          maxLevel: 4,
          gaugeProgress: 0.3,
        ),
      ],
      imagePath: 'assets/images/character8.png',
    ),

    // 캐릭터 9: Water + Metal
    Character(
      id: 'char_009',
      name: 'Aqua Priest',
      description: '물의 성직자',
      attributes: [Attribute.water, Attribute.metal],
      weapon: Equipment(
        name: 'Holy Staff',
        description: '신성한 지팡이',
        type: 'weapon',
      ),
      armor: Equipment(name: 'Water Robe', description: '물의 로브', type: 'armor'),
      accessory: Equipment(
        name: 'Blessed Amulet',
        description: '축복받은 부적',
        type: 'accessory',
      ),
      level: 11,
      levelProgress: 0.5,
      passiveTraits: [
        PassiveTrait(
          name: 'Divine Healing',
          description: '신성한 치유 능력',
          category: PassiveCategory.support,
          level: 3,
          maxLevel: 5,
        ),
      ],
      skills: [
        Skill(
          name: 'Holy Water',
          description: '신성한 물의 치유',
          category: SkillCategory.support,
          level: 2,
          maxLevel: 4,
          gaugeProgress: 0.8,
        ),
        Skill(
          name: 'Water Barrier',
          description: '물의 방어막',
          category: SkillCategory.defense,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.2,
        ),
      ],
      imagePath: 'assets/images/character9.png',
    ),

    // 캐릭터 10: Earth + Dark
    Character(
      id: 'char_010',
      name: 'Shadow Miner',
      description: '어둠 속에서 광물을 캐는 광부',
      attributes: [Attribute.earth, Attribute.dark],
      weapon: Equipment(
        name: 'Dark Pickaxe',
        description: '어둠의 곡괭이',
        type: 'weapon',
      ),
      armor: Equipment(name: 'Stone Armor', description: '돌 갑옷', type: 'armor'),
      accessory: Equipment(
        name: 'Shadow Gem',
        description: '어둠의 보석',
        type: 'accessory',
      ),
      level: 10,
      levelProgress: 0.9,
      passiveTraits: [
        PassiveTrait(
          name: 'Mining Expert',
          description: '광물 채굴 능력 향상',
          category: PassiveCategory.utility,
          level: 2,
          maxLevel: 3,
        ),
        PassiveTrait(
          name: 'Dark Vision',
          description: '어둠 속에서도 시야 확보',
          category: PassiveCategory.survival,
          level: 1,
          maxLevel: 2,
        ),
      ],
      skills: [
        Skill(
          name: 'Earthquake',
          description: '대지를 흔들어 광물 노출',
          category: SkillCategory.utility,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.6,
        ),
        Skill(
          name: 'Shadow Strike',
          description: '어둠의 일격',
          category: SkillCategory.attack,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.4,
        ),
      ],
      imagePath: 'assets/images/character10.png',
    ),

    // 캐릭터 11: Wind + Light
    Character(
      id: 'char_011',
      name: 'Breeze Angel',
      description: '바람의 천사',
      attributes: [Attribute.wind, Attribute.light],
      weapon: Equipment(name: 'Wind Bow', description: '바람의 활', type: 'weapon'),
      armor: Equipment(
        name: 'Angel Wings',
        description: '천사의 날개',
        type: 'armor',
      ),
      accessory: Equipment(
        name: 'Light Feather',
        description: '빛의 깃털',
        type: 'accessory',
      ),
      level: 19,
      levelProgress: 0.4,
      passiveTraits: [
        PassiveTrait(
          name: 'Angel\'s Grace',
          description: '천사의 은총',
          category: PassiveCategory.support,
          level: 4,
          maxLevel: 5,
        ),
        PassiveTrait(
          name: 'Wind Mastery',
          description: '바람 속성 마스터리',
          category: PassiveCategory.combat,
          level: 3,
          maxLevel: 4,
        ),
      ],
      skills: [
        Skill(
          name: 'Light Arrow',
          description: '빛의 화살',
          category: SkillCategory.attack,
          level: 4,
          maxLevel: 5,
          gaugeProgress: 0.9,
        ),
        Skill(
          name: 'Healing Wind',
          description: '치유의 바람',
          category: SkillCategory.support,
          level: 2,
          maxLevel: 4,
          gaugeProgress: 0.5,
        ),
      ],
      imagePath: 'assets/images/character11.png',
    ),

    // 캐릭터 12: Ice + Rock
    Character(
      id: 'char_012',
      name: 'Frost Demon',
      description: '얼음과 바위의 악마',
      attributes: [Attribute.ice, Attribute.rock],
      weapon: Equipment(
        name: 'Chaos Axe',
        description: '혼돈의 도끼',
        type: 'weapon',
      ),
      armor: Equipment(name: 'Ice Plate', description: '얼음 갑옷', type: 'armor'),
      accessory: Equipment(
        name: 'Frost Crystal',
        description: '서리의 결정',
        type: 'accessory',
      ),
      level: 15,
      levelProgress: 0.7,
      passiveTraits: [
        PassiveTrait(
          name: 'Frost Aura',
          description: '서리 오라로 적을 둔화',
          category: PassiveCategory.combat,
          level: 3,
          maxLevel: 4,
        ),
        PassiveTrait(
          name: 'Rock Resistance',
          description: '바위 속성 저항',
          category: PassiveCategory.survival,
          level: 2,
          maxLevel: 3,
        ),
      ],
      skills: [
        Skill(
          name: 'Frozen Rock',
          description: '얼어붙은 바위',
          category: SkillCategory.special,
          level: 2,
          maxLevel: 4,
          gaugeProgress: 0.8,
        ),
        Skill(
          name: 'Ice Prison',
          description: '얼음 감옥',
          category: SkillCategory.defense,
          level: 1,
          maxLevel: 3,
          gaugeProgress: 0.3,
        ),
      ],
      imagePath: 'assets/images/character12.png',
    ),
  ];

  // 모든 캐릭터 반환
  static List<Character> getAllCharacters() {
    return List.from(_characters);
  }

  // 필터링된 캐릭터 반환
  static List<Character> getFilteredCharacters({
    Attribute? attributeFilter,
    PassiveCategory? passiveCategoryFilter,
    SkillCategory? skillCategoryFilter,
  }) {
    return _characters.where((character) {
      bool matchesAttribute = true;
      bool matchesPassive = true;
      bool matchesSkill = true;

      // 속성 필터
      if (attributeFilter != null) {
        matchesAttribute = character.attributes.contains(attributeFilter);
      }

      // 패시브 특성 카테고리 필터
      if (passiveCategoryFilter != null) {
        matchesPassive = character.passiveTraits.any(
          (trait) => trait.category == passiveCategoryFilter,
        );
      }

      // 스킬 카테고리 필터
      if (skillCategoryFilter != null) {
        matchesSkill = character.skills.any(
          (skill) => skill.category == skillCategoryFilter,
        );
      }

      return matchesAttribute && matchesPassive && matchesSkill;
    }).toList();
  }

  // 정렬된 캐릭터 반환
  static List<Character> getSortedCharacters(
    List<Character> characters,
    bool ascending,
  ) {
    final sorted = List<Character>.from(characters);
    if (ascending) {
      sorted.sort((a, b) => a.level.compareTo(b.level));
    } else {
      sorted.sort((a, b) => b.level.compareTo(a.level));
    }
    return sorted;
  }
}
