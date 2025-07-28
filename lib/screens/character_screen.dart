import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/character_service.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<Character> _filteredCharacters = [];

  // 필터 상태
  Attribute? _selectedAttribute;
  PassiveCategory? _selectedPassiveCategory;
  SkillCategory? _selectedSkillCategory;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  void _loadCharacters() {
    _applyFilters();
  }

  void _applyFilters() {
    _filteredCharacters = CharacterService.getFilteredCharacters(
      attributeFilter: _selectedAttribute,
      passiveCategoryFilter: _selectedPassiveCategory,
      skillCategoryFilter: _selectedSkillCategory,
    );

    // 정렬 적용
    _filteredCharacters = CharacterService.getSortedCharacters(
      _filteredCharacters,
      _isAscending,
    );

    setState(() {});
  }

  void _resetFilters() {
    _selectedAttribute = null;
    _selectedPassiveCategory = null;
    _selectedSkillCategory = null;
    _isAscending = true;
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 필터/정렬 바
            _buildFilterBar(),

            // 캐릭터 그리드
            Expanded(
              child: _filteredCharacters.isEmpty
                  ? _buildEmptyState()
                  : _buildCharacterGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD1F7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 필터 행
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  '속성',
                  Attribute.values.map((attr) => attr.name).toList(),
                  _selectedAttribute?.name,
                  (value) {
                    setState(() {
                      _selectedAttribute = value != null
                          ? Attribute.values.firstWhere((e) => e.name == value)
                          : null;
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFilterDropdown(
                  '패시브',
                  PassiveCategory.values.map((cat) => cat.name).toList(),
                  _selectedPassiveCategory?.name,
                  (value) {
                    setState(() {
                      _selectedPassiveCategory = value != null
                          ? PassiveCategory.values.firstWhere(
                              (e) => e.name == value,
                            )
                          : null;
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFilterDropdown(
                  '스킬',
                  SkillCategory.values.map((cat) => cat.name).toList(),
                  _selectedSkillCategory?.name,
                  (value) {
                    setState(() {
                      _selectedSkillCategory = value != null
                          ? SkillCategory.values.firstWhere(
                              (e) => e.name == value,
                            )
                          : null;
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 정렬 및 초기화 행
          Row(
            children: [
              // 정렬 버튼
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAscending = !_isAscending;
                    });
                    _applyFilters();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE05EFF)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: const Color(0xFFE05EFF),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '레벨 ${_isAscending ? '오름차순' : '내림차순'}',
                          style: const TextStyle(
                            color: Color(0xFFE05EFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // 초기화 버튼
              Expanded(
                child: GestureDetector(
                  onTap: _resetFilters,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE05EFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '초기화',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    List<String> options,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE05EFF)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            label,
            style: const TextStyle(
              color: Color(0xFFE05EFF),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE05EFF)),
          isExpanded: true,
          items: [
            const DropdownMenuItem<String>(
              value: null,
              child: Text('전체', style: TextStyle(fontSize: 12)),
            ),
            ...options.map(
              (option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option, style: const TextStyle(fontSize: 12)),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildCharacterGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: _filteredCharacters.length,
      itemBuilder: (context, index) {
        return _buildCharacterCard(_filteredCharacters[index]);
      },
    );
  }

  Widget _buildCharacterCard(Character character) {
    return GestureDetector(
      onTap: () {
        // TODO: 캐릭터 상세 화면으로 이동
        _showCharacterDetail(character);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // 캐릭터 이미지 영역
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: 140, // Increased height for card to prevent overflow
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Stack(
                  children: [
                    // 임시 캐릭터 이미지 (색상으로 대체)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: character.attributes.length >= 2
                            ? LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  character.getAttributeColor(
                                        character.attributes[0],
                                      ) ??
                                      Colors.grey,
                                  character.getAttributeColor(
                                        character.attributes[1],
                                      ) ??
                                      Colors.grey,
                                ],
                              )
                            : null,
                        color:
                            character.attributes.isNotEmpty &&
                                character.attributes.length == 1
                            ? (character.getAttributeColor(
                                    character.attributes.first,
                                  ) ??
                                  Colors.grey)
                            : (character.attributes.isEmpty
                                  ? Colors.grey
                                  : null),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          character.name[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // 속성 이모지 표시 (여러 개)
                    if (character.attributes.isNotEmpty)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: character.attributes
                              .map(
                                (attr) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: character.attributes.length == 1
                                      ? Text(
                                          character.getAttributeEmoji(attr),
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      : Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            character.getAttributeEmoji(attr),
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // 캐릭터 정보 영역
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 캐릭터 이름
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // 레벨 정보
                    Row(
                      children: [
                        Text(
                          'Lv.${character.level}',
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE05EFF),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${character.levelPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // 레벨 진행률 바
                    Flexible(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: LinearProgressIndicator(
                          value: character.levelProgress,
                          backgroundColor: Colors.grey.withValues(alpha: 0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFE05EFF),
                          ),
                          minHeight: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '조건에 맞는 캐릭터가 없습니다',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '필터 조건을 변경해보세요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  void _showCharacterDetail(Character character) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // 핸들 바
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 캐릭터 상세 정보
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 캐릭터 헤더
                    Row(
                      children: [
                        // 캐릭터 이미지
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: character.attributes.isNotEmpty
                                ? character.getAttributeColor(
                                    character.attributes.first,
                                  )
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              character.name[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // 캐릭터 기본 정보
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                character.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Lv.${character.level}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE05EFF),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${character.levelPercentage.toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 속성 정보
                    _buildDetailSection('속성', [
                      ...character.attributes.map(
                        (attr) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: character.getAttributeColor(attr),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            character.getAttributeName(attr),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),

                    const SizedBox(height: 16),

                    // 장비 정보
                    if (character.weapon != null ||
                        character.armor != null ||
                        character.accessory != null)
                      _buildDetailSection('장비', [
                        if (character.weapon != null)
                          _buildEquipmentItem(character.weapon!),
                        if (character.armor != null)
                          _buildEquipmentItem(character.armor!),
                        if (character.accessory != null)
                          _buildEquipmentItem(character.accessory!),
                      ]),

                    const SizedBox(height: 16),

                    // 패시브 특성
                    _buildDetailSection(
                      '패시브 특성',
                      character.passiveTraits
                          .map((trait) => _buildTraitItem(trait))
                          .toList(),
                    ),

                    const SizedBox(height: 16),

                    // 스킬
                    _buildDetailSection(
                      '스킬',
                      character.skills
                          .map((skill) => _buildSkillItem(skill))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: children),
      ],
    );
  }

  Widget _buildEquipmentItem(Equipment equipment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            equipment.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            equipment.description,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildTraitItem(PassiveTrait trait) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE05EFF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE05EFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                trait.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE05EFF),
                ),
              ),
              const Spacer(),
              Text(
                'Lv.${trait.level}/${trait.maxLevel}',
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            trait.description,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(Skill skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD100FF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD100FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                skill.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD100FF),
                ),
              ),
              const Spacer(),
              Text(
                'Lv.${skill.level}/${skill.maxLevel}',
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            skill.description,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: skill.gaugeProgress,
            backgroundColor: Colors.grey.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD100FF)),
            minHeight: 2,
          ),
        ],
      ),
    );
  }
}
