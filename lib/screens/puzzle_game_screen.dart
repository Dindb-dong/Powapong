import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame/effects.dart';
import 'dart:math';
import '../widgets/puzzle_battle_area.dart';

// 12가지 속성 정의
enum GemType {
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

// 속성별 색상 매핑
const Map<GemType, Color> gemColors = {
  GemType.fire: Color(0xFFFF4444), // 🔥 빨강
  GemType.water: Color(0xFF4444FF), // 💧 파랑
  GemType.grass: Color(0xFF44FF44), // 🌿 초록
  GemType.wind: Color(0xFF90EE90), // 🌬 연두
  GemType.electric: Color(0xFFFFFF44), // ⚡ 노랑
  GemType.ice: Color(0xFF44FFFF), // ❄️ 하늘색
  GemType.poison: Color(0xFF800080), // 🧪 보라
  GemType.rock: Color(0xFF8B4513), // 🪨 갈색
  GemType.metal: Color(0xFFC0C0C0), // ⚙ 은색
  GemType.earth: Color(0xFFA0522D), // 🪵 흙색
  GemType.dark: Color(0xFF444444), // 🌑 검정
  GemType.light: Color(0xFFFFFFFF), // ✨ 흰색
};

// 중력 방향
enum GravityDirection {
  down(0), // 1
  left(1), // 2
  up(2), // 3
  right(3); // 4

  const GravityDirection(this.value);
  final int value;
}

// 캐릭터 클래스
class Character {
  final String name;
  final List<GemType> attributes;
  final int level;

  Character({required this.name, required this.attributes, this.level = 1})
    : assert(attributes.isNotEmpty, '캐릭터는 최소 하나의 속성을 가져야 합니다.');
}

// 그리드 배경 컴포넌트 (Flame)
class GridBackgroundComponent extends PositionComponent
    with HasGameReference<PuzzleGame> {
  final int gridX;
  final int gridY;
  Color backgroundColor = Colors.transparent;

  GridBackgroundComponent({
    required this.gridX,
    required this.gridY,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    if (backgroundColor != Colors.transparent) {
      final paint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;

      // 둥근 모서리로 그리기
      final rect = Rect.fromLTWH(0, 0, size.x, size.y);
      final radius = Radius.circular(size.x * 0.1);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
    }
  }

  void setColor(Color color) {
    backgroundColor = color;
  }

  void resetColor() {
    backgroundColor = Colors.transparent;
  }
}

// 젬 컴포넌트 (Flame)
class GemComponent extends PositionComponent with HasGameReference<PuzzleGame> {
  final GemType type;
  int gridX; // final 제거
  int gridY; // final 제거
  bool isMatched = false;
  bool isMoving = false;
  Vector2? targetPosition;

  GemComponent({
    required this.type,
    required this.gridX,
    required this.gridY,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = gemColors[type]!
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // 그림자
    canvas.drawCircle(
      Offset(size.x / 2 + 2, size.y / 2 + 2),
      size.x / 2 - 4,
      shadowPaint,
    );

    // 젬
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2 - 4, paint);

    // 하이라이트
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.x / 2 - 4, size.y / 2 - 4),
      size.x / 4,
      highlightPaint,
    );

    // 속성 이모티콘 표시
    final emoji = _getAttributeEmoji(type);
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: TextStyle(
          fontSize: size.x * 0.4, // 젬 크기의 40%
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }

  // 속성별 이모티콘 반환
  String _getAttributeEmoji(GemType type) {
    switch (type) {
      case GemType.fire:
        return '🔥';
      case GemType.water:
        return '💧';
      case GemType.grass:
        return '🌿';
      case GemType.wind:
        return '🌬️';
      case GemType.electric:
        return '⚡';
      case GemType.ice:
        return '❄️';
      case GemType.poison:
        return '🧪';
      case GemType.rock:
        return '🪨';
      case GemType.metal:
        return '⚙️';
      case GemType.earth:
        return '🪵';
      case GemType.dark:
        return '🌑';
      case GemType.light:
        return '✨';
    }
  }

  void moveTo(Vector2 newPosition, {double duration = 0.3}) {
    isMoving = true;
    targetPosition = newPosition;

    add(
      MoveToEffect(
        newPosition,
        EffectController(duration: duration),
        onComplete: () {
          isMoving = false;
          targetPosition = null;
        },
      ),
    );
  }

  void explode() {
    isMatched = true;

    // 폭발 파티클 효과
    final particle = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.5,
        generator: (i) => AcceleratedParticle(
          speed: Vector2.random() * 100,
          acceleration: Vector2(0, 200),
          child: CircleParticle(paint: Paint()..color = gemColors[type]!),
        ),
      ),
    );

    game.add(particle);
    particle.position = position + size / 2;

    // 사라지는 애니메이션
    add(
      ScaleEffect.to(
        Vector2.zero(),
        EffectController(duration: 0.2),
        onComplete: () => removeFromParent(),
      ),
    );
  }
}

// 퍼즐 게임 메인 클래스
class PuzzleGame extends FlameGame {
  static const int gridSize = 6;
  late List<List<GemComponent?>> grid;
  late List<List<GridBackgroundComponent?>> gridBackgrounds;
  late Vector2 gemSize;
  late Vector2 gridOffset;

  List<Character> characters = [
    Character(name: "포아미", attributes: [GemType.light]),
    Character(name: "쿨쿨", attributes: [GemType.fire, GemType.earth]),
    Character(name: "방방", attributes: [GemType.water, GemType.wind]),
    Character(name: "꽁꽁", attributes: [GemType.grass, GemType.ice]),
  ];

  GravityDirection gravityDirection = GravityDirection.down;
  GemComponent? selectedGem;
  Vector2? dragStart;
  bool isProcessing = false;

  // 미리보기 스왑 관련 변수들
  GemComponent? previewGem1;
  GemComponent? previewGem2;
  Vector2? originalPos1;
  Vector2? originalPos2;
  bool isPreviewMode = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _initializeGrid();
  }

  void _initializeGrid() {
    // 그리드 크기 계산
    final screenSize = size;
    final gridWidth = screenSize.x;
    gemSize = Vector2(gridWidth / gridSize, gridWidth / gridSize);
    gridOffset = Vector2((screenSize.x - gridWidth) / 2, 0);

    // 그리드 초기화
    grid = List.generate(gridSize, (y) => List.generate(gridSize, (x) => null));
    gridBackgrounds = List.generate(
      gridSize,
      (y) => List.generate(gridSize, (x) => null as GridBackgroundComponent?),
    );

    // 그리드 배경 생성 및 배치
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        _createGridBackgroundAt(x, y);
      }
    }

    // 젬 생성 및 배치
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        _createGemAt(x, y);
      }
    }

    // 초기 매칭 검사
    _checkAndRemoveInitialMatches();
  }

  void _createGridBackgroundAt(int x, int y) {
    final position = _gridToScreenPosition(x, y);

    final background = GridBackgroundComponent(
      gridX: x,
      gridY: y,
      position: position,
      size: gemSize,
    );

    gridBackgrounds[y][x] = background;
    add(background);
  }

  void _createGemAt(int x, int y) {
    final gemType = _generateGemByCharacters();
    final position = _gridToScreenPosition(x, y);

    final gem = GemComponent(
      type: gemType,
      gridX: x,
      gridY: y,
      position: position,
      size: gemSize,
    );

    grid[y][x] = gem;
    add(gem);
  }

  // 캐릭터 속성에 따른 젬 생성 확률 계산
  GemType _generateGemByCharacters() {
    Map<GemType, int> attributeCounts = {};

    for (var character in characters) {
      if (character.attributes.isNotEmpty) {
        for (var attribute in character.attributes) {
          attributeCounts[attribute] = (attributeCounts[attribute] ?? 0) + 1;
        }
      }
    }

    if (attributeCounts.isEmpty) {
      return GemType.values[Random().nextInt(GemType.values.length)];
    }

    // 확률 계산
    int totalCount = attributeCounts.values.reduce((a, b) => a + b);
    int randomValue = Random().nextInt(totalCount);

    int currentSum = 0;
    for (var entry in attributeCounts.entries) {
      currentSum += entry.value;
      if (randomValue < currentSum) {
        return entry.key;
      }
    }

    return attributeCounts.keys.first;
  }

  Vector2 _gridToScreenPosition(int x, int y) {
    return gridOffset + Vector2(x * gemSize.x, y * gemSize.y);
  }

  (int, int)? _screenToGridPosition(Vector2 screenPos) {
    final relativePos = screenPos - gridOffset;

    // 젬의 전체 영역을 고려하여 그리드 좌표 계산
    final x = (relativePos.x / gemSize.x).floor();
    final y = (relativePos.y / gemSize.y).floor();

    // 그리드 범위 체크
    if (x >= 0 && x < gridSize && y >= 0 && y < gridSize) {
      // 젬이 실제로 존재하는지 확인
      if (grid[y][x] != null) {
        // 젬의 터치 영역 내에 있는지 확인 (젬 크기의 90% 영역)
        final gemCenterX = (x + 0.5) * gemSize.x;
        final gemCenterY = (y + 0.5) * gemSize.y;
        final touchAreaRadius = gemSize.x * 0.45; // 젬 크기의 90% 영역

        final distanceFromCenter = Vector2(
          relativePos.x - gemCenterX,
          relativePos.y - gemCenterY,
        ).length;

        if (distanceFromCenter <= touchAreaRadius) {
          return (x, y);
        }
      }
    }

    return null;
  }

  // 터치 이벤트 처리
  void onTap(Vector2 position) {
    final gridPos = _screenToGridPosition(position);
    if (gridPos != null) {
      final (x, y) = gridPos;
      selectedGem = grid[y][x];
    } else {
      selectedGem = null;
    }
  }

  void onDragStart(Vector2 position) {
    if (isProcessing) {
      print('드래그 시작 차단됨: isProcessing = $isProcessing');
      return;
    }

    final gridPos = _screenToGridPosition(position);
    if (gridPos != null) {
      final (x, y) = gridPos;
      print(
        '터치 위치: (${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}) -> 그리드: ($x, $y)',
      );
      selectedGem = grid[y][x];
      dragStart = position;
    } else {
      print(
        '터치 위치: (${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}) -> 유효하지 않은 영역',
      );
      selectedGem = null;
    }
  }

  void onDragUpdate(Vector2 position) {
    if (selectedGem == null || dragStart == null || isProcessing) {
      return;
    }

    final delta = position - dragStart!;

    // 드래그 감지 임계값 (젬 크기의 30%로 증가)
    if (delta.length > gemSize.x * 0.3) {
      _handlePreviewSwipe(delta);
    } else {
      // 임계값보다 작으면 미리보기 취소
      _cancelPreview();
    }
  }

  void onDragEnd() {
    if (isPreviewMode) {
      // 미리보기 모드에서 손을 놓으면 실제 스왑 실행
      _executePreviewSwap();
    } else {
      // 미리보기 모드가 아니면 그냥 리셋
      _resetDragState();
    }
  }

  void _resetDragState() {
    selectedGem = null;
    dragStart = null;
    isPreviewMode = false;
  }

  // 미리보기 스왑 처리
  void _handlePreviewSwipe(Vector2 delta) {
    if (selectedGem == null || isPreviewMode) return;

    final (fromX, fromY) = (selectedGem!.gridX, selectedGem!.gridY);
    int toX = fromX;
    int toY = fromY;

    // 스와이프 방향 결정
    if (delta.x.abs() > delta.y.abs()) {
      toX = fromX + (delta.x > 0 ? 1 : -1);
    } else {
      toY = fromY + (delta.y > 0 ? 1 : -1);
    }

    // 범위 체크
    if (toX < 0 || toX >= gridSize || toY < 0 || toY >= gridSize) return;

    // 미리보기 스왑 시작
    _startPreviewSwap(fromX, fromY, toX, toY);
  }

  // 미리보기 스왑 시작
  void _startPreviewSwap(int fromX, int fromY, int toX, int toY) {
    if (isPreviewMode) return;

    final gem1 = grid[fromY][fromX];
    final gem2 = grid[toY][toX];

    if (gem1 == null || gem2 == null) return;

    isPreviewMode = true;
    previewGem1 = gem1;
    previewGem2 = gem2;
    originalPos1 = _gridToScreenPosition(fromX, fromY);
    originalPos2 = _gridToScreenPosition(toX, toY);

    // 그리드 배경 색상 설정
    _setGridBackgroundColors(fromX, fromY, toX, toY);

    // 미리보기 애니메이션 (빠른 속도로)
    final pos1 = _gridToScreenPosition(toX, toY);
    final pos2 = _gridToScreenPosition(fromX, fromY);

    gem1.moveTo(pos1, duration: 0.15);
    gem2.moveTo(pos2, duration: 0.15);

    print('미리보기 스왑 시작: ($fromX, $fromY) ↔ ($toX, $toY)');
  }

  // 그리드 배경 색상 설정
  void _setGridBackgroundColors(int fromX, int fromY, int toX, int toY) {
    // 모든 배경 색상 리셋
    _resetAllGridBackgroundColors();

    // 선택된 젬 위치 (은은한 노란색)
    if (gridBackgrounds[fromY][fromX] != null) {
      gridBackgrounds[fromY][fromX]!.setColor(
        const Color(0x33FFD700),
      ); // 은은한 노란색
    }

    // 스왑 대상 젬 위치 (은은한 녹색)
    if (gridBackgrounds[toY][toX] != null) {
      gridBackgrounds[toY][toX]!.setColor(const Color(0x3390EE90)); // 은은한 녹색
    }
  }

  // 모든 그리드 배경 색상 리셋
  void _resetAllGridBackgroundColors() {
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        if (gridBackgrounds[y][x] != null) {
          gridBackgrounds[y][x]!.resetColor();
        }
      }
    }
  }

  // 미리보기 취소
  void _cancelPreview() {
    if (!isPreviewMode) return;

    // 원래 위치로 되돌리기
    if (previewGem1 != null && originalPos1 != null) {
      previewGem1!.moveTo(originalPos1!, duration: 0.15);
    }
    if (previewGem2 != null && originalPos2 != null) {
      previewGem2!.moveTo(originalPos2!, duration: 0.15);
    }

    // 그리드 배경 색상 리셋
    _resetAllGridBackgroundColors();

    // 미리보기 상태 리셋
    isPreviewMode = false;
    previewGem1 = null;
    previewGem2 = null;
    originalPos1 = null;
    originalPos2 = null;

    print('미리보기 스왑 취소');
  }

  // 미리보기 스왑 실행
  void _executePreviewSwap() {
    if (!isPreviewMode || previewGem1 == null || previewGem2 == null) {
      _resetDragState();
      return;
    }

    // 실제 스왑 실행
    final fromX = previewGem1!.gridX;
    final fromY = previewGem1!.gridY;
    final toX = previewGem2!.gridX;
    final toY = previewGem2!.gridY;

    // 그리드 업데이트
    grid[fromY][fromX] = previewGem2;
    grid[toY][toX] = previewGem1;
    previewGem1!.gridX = toX;
    previewGem1!.gridY = toY;
    previewGem2!.gridX = fromX;
    previewGem2!.gridY = fromY;

    print('실제 스왑 실행: ($fromX, $fromY) ↔ ($toX, $toY)');

    // 그리드 배경 색상 리셋
    _resetAllGridBackgroundColors();

    // 미리보기 상태 리셋
    isPreviewMode = false;
    previewGem1 = null;
    previewGem2 = null;
    originalPos1 = null;
    originalPos2 = null;

    // 매칭 검사
    Future.delayed(const Duration(milliseconds: 300), () {
      _checkAndProcessMatches();
    });
  }

  // 기존 스왑 함수 (미리보기 모드로 대체됨)
  // void _handleSwipe(Vector2 delta) {
  //   if (selectedGem == null) return;

  //   final (fromX, fromY) = (selectedGem!.gridX, selectedGem!.gridY);
  //   int toX = fromX;
  //   int toY = fromY;

  //   // 스와이프 방향 결정
  //   if (delta.x.abs() > delta.y.abs()) {
  //     toX = fromX + (delta.x > 0 ? 1 : -1);
  //   } else {
  //     toY = fromY + (delta.y > 0 ? 1 : -1);
  //   }

  //   // 범위 체크
  //   if (toX < 0 || toX >= gridSize || toY < 0 || toY >= gridSize) return;

  //   _swapGems(fromX, fromY, toX, toY);
  // }

  // void _swapGems(int fromX, int fromY, int toX, int toY) {
  //   if (isProcessing) return;

  //   final gem1 = grid[fromY][fromX];
  //   final gem2 = grid[toY][toX];

  //   if (gem1 == null || gem2 == null) return;

  //   // 스왑 시작 시 처리 상태로 설정
  //   isProcessing = true;

  //   // 스왑 애니메이션
  //   final pos1 = _gridToScreenPosition(fromX, fromY);
  //   final pos2 = _gridToScreenPosition(toX, toY);

  //   gem1.moveTo(pos2);
  //   gem2.moveTo(pos1);

  //   // 그리드 업데이트
  //   grid[fromY][fromX] = gem2;
  //   grid[toY][toX] = gem1;
  //   gem1.gridX = toX;
  //   gem1.gridY = toY;
  //   gem2.gridX = fromX;
  //   gem2.gridY = fromY;

  //   // 매칭 검사 (지연 시간 증가)
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     _checkAndProcessMatches();
  //   });
  // }

  void _checkAndProcessMatches() {
    final matches = _findMatches();
    if (matches.isNotEmpty) {
      print('매칭 발견: ${matches.length}개 매칭');
      _processMatches(matches);
    } else {
      // 매칭이 없으면 처리 완료 상태로 설정
      print('매칭 없음, isProcessing = false로 설정');
      isProcessing = false;
    }
  }

  void _checkAndRemoveInitialMatches() {
    final matches = _findMatches();
    if (matches.isNotEmpty) {
      _processMatches(matches);
    }
  }

  List<List<(int, int)>> _findMatches() {
    print('매칭 검사 시작');
    List<List<(int, int)>> matches = [];

    // 가로 매칭 검사
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize - 2; x++) {
        final gem1 = grid[y][x];
        final gem2 = grid[y][x + 1];
        final gem3 = grid[y][x + 2];

        if (gem1 != null &&
            gem2 != null &&
            gem3 != null &&
            gem1.type == gem2.type &&
            gem2.type == gem3.type) {
          matches.add([(x, y), (x + 1, y), (x + 2, y)]);
        }
      }
    }

    // 세로 매칭 검사
    for (int y = 0; y < gridSize - 2; y++) {
      for (int x = 0; x < gridSize; x++) {
        final gem1 = grid[y][x];
        final gem2 = grid[y + 1][x];
        final gem3 = grid[y + 2][x];

        if (gem1 != null &&
            gem2 != null &&
            gem3 != null &&
            gem1.type == gem2.type &&
            gem2.type == gem3.type) {
          matches.add([(x, y), (x, y + 1), (x, y + 2)]);
        }
      }
    }

    print('매칭 검사 완료: ${matches.length}개 매칭');

    return matches;
  }

  void _processMatches(List<List<(int, int)>> matches) {
    print('매칭 처리 시작: ${matches.length}개 매칭');

    // 매칭된 젬들 제거
    Set<(int, int)> positionsToRemove = {};
    for (var match in matches) {
      for (var pos in match) {
        positionsToRemove.add(pos);
      }
    }

    for (var (x, y) in positionsToRemove) {
      final gem = grid[y][x];
      if (gem != null) {
        gem.explode();
        grid[y][x] = null;
      }
    }

    print('매칭된 젬들 제거 완료, 중력 적용 시작');

    // 중력 적용 및 새 젬 생성 (연쇄 반응을 위해 재귀 호출)
    Future.delayed(const Duration(milliseconds: 600), () {
      _applyGravity();
    });
  }

  Future<void> _applyGravity() async {
    bool hasChanges = false;
    print('중력 적용 시작: $gravityDirection');
    switch (gravityDirection) {
      case GravityDirection.down:
        hasChanges = _applyGravityDown();
        break;
      case GravityDirection.left:
        hasChanges = _applyGravityLeft();
        break;
      case GravityDirection.up:
        hasChanges = _applyGravityUp();
        break;
      case GravityDirection.right:
        hasChanges = _applyGravityRight();
        break;
    }

    if (!hasChanges) {
      // 중력 적용할 변화가 없으면 처리 완료
      isProcessing = false;
    }
    // hasChanges가 true인 경우는 각 중력 함수에서 새 젬 생성 후 매칭 검사를 처리함
  }

  // 재귀적으로 매칭을 검사하고 처리 (연쇄 반응)
  void _checkAndProcessMatchesRecursively() {
    print('재귀 매칭 검사 시작');
    final matches = _findMatches();
    if (matches.isNotEmpty) {
      print('재귀 매칭 발견: ${matches.length}개 매칭');
      _processMatches(matches);
    } else {
      // 더 이상 매칭되는 것이 없으면 처리 완료
      print('재귀 매칭 없음, isProcessing = false로 설정');
      isProcessing = false;
    }
  }

  bool _applyGravityDown() {
    bool hasChanges = false;
    print('중력 적용 시작: Down');
    for (int x = 0; x < gridSize; x++) {
      print('($x+1) 열에서 중력 적용 시작');
      for (int y = gridSize - 1; y >= 0; y--) {
        if (grid[y][x] == null) {
          hasChanges = true;
          // 위에서 젬 찾아서 아래로 이동
          for (int aboveY = y - 1; aboveY >= 0; aboveY--) {
            print('($x+1) 열의 ($y+1) 행에서 위에서 젬 찾아서 아래로 이동');
            if (grid[aboveY][x] != null) {
              final gem = grid[aboveY][x]!;
              grid[aboveY][x] = null;
              grid[y][x] = gem;
              gem.gridY = y;
              gem.moveTo(_gridToScreenPosition(x, y));
              print('($x+1) 열의 ($y+1) 행에서 위에서 젬 찾아서 아래로 이동 완료');
              break;
            }
          }
        }
      }
    }

    // 기존 젬들이 이동한 후 새 젬 생성 (딜레이 추가)
    if (hasChanges) {
      Future.delayed(const Duration(milliseconds: 400), () {
        print('새 젬 생성 시작');
        for (int x = 0; x < gridSize; x++) {
          for (int y = 0; y < gridSize; y++) {
            if (grid[y][x] == null) {
              _createGemAt(x, y);
            }
          }
        }
        print('새 젬 생성 완료, 매칭 검사 시작');
        // 새 젬 생성 후 매칭 검사
        Future.delayed(const Duration(milliseconds: 300), () {
          _checkAndProcessMatchesRecursively();
        });
      });
    }

    return hasChanges;
  }

  bool _applyGravityLeft() {
    bool hasChanges = false;
    print('중력 적용 시작: Left');
    for (int y = 0; y < gridSize; y++) {
      print('($y+1) 행에서 중력 적용 시작');
      for (int x = 0; x < gridSize; x++) {
        if (grid[y][x] == null) {
          hasChanges = true;
          // 오른쪽에서 젬 찾아서 왼쪽으로 이동
          for (int rightX = x + 1; rightX < gridSize; rightX++) {
            print('($y+1) 행의 ($x+1) 열에서 오른쪽에서 젬 찾아서 왼쪽으로 이동');
            if (grid[y][rightX] != null) {
              final gem = grid[y][rightX]!;
              grid[y][rightX] = null;
              grid[y][x] = gem;
              gem.gridX = x;
              gem.moveTo(_gridToScreenPosition(x, y));
              print('($y+1) 행의 ($x+1) 열에서 오른쪽에서 젬 찾아서 왼쪽으로 이동 완료');
              break;
            }
          }
        }
      }
    }

    // 기존 젬들이 이동한 후 새 젬 생성 (딜레이 추가)
    if (hasChanges) {
      Future.delayed(const Duration(milliseconds: 400), () {
        print('새 젬 생성 시작 (Left)');
        for (int y = 0; y < gridSize; y++) {
          for (int x = gridSize - 1; x >= 0; x--) {
            if (grid[y][x] == null) {
              _createGemAt(x, y);
            }
          }
        }
        print('새 젬 생성 완료 (Left), 매칭 검사 시작');
        // 새 젬 생성 후 매칭 검사
        Future.delayed(const Duration(milliseconds: 300), () {
          _checkAndProcessMatchesRecursively();
        });
      });
    }

    return hasChanges;
  }

  bool _applyGravityUp() {
    bool hasChanges = false;
    print('중력 적용 시작: Up');
    for (int x = 0; x < gridSize; x++) {
      print('($x+1) 열에서 중력 적용 시작');
      for (int y = 0; y < gridSize; y++) {
        if (grid[y][x] == null) {
          hasChanges = true;
          // 아래에서 젬 찾아서 위로 이동
          for (int belowY = y + 1; belowY < gridSize; belowY++) {
            print('($x+1) 열의 ($y+1) 행에서 아래에서 젬 찾아서 위로 이동');
            if (grid[belowY][x] != null) {
              final gem = grid[belowY][x]!;
              grid[belowY][x] = null;
              grid[y][x] = gem;
              gem.gridY = y;
              gem.moveTo(_gridToScreenPosition(x, y));
              print('($x+1) 열의 ($y+1) 행에서 아래에서 젬 찾아서 위로 이동 완료');
              break;
            }
          }
        }
      }
    }

    // 기존 젬들이 이동한 후 새 젬 생성 (딜레이 추가)
    if (hasChanges) {
      Future.delayed(const Duration(milliseconds: 400), () {
        print('새 젬 생성 시작 (Up)');
        for (int x = 0; x < gridSize; x++) {
          for (int y = gridSize - 1; y >= 0; y--) {
            if (grid[y][x] == null) {
              _createGemAt(x, y);
            }
          }
        }
        print('새 젬 생성 완료 (Up), 매칭 검사 시작');
        // 새 젬 생성 후 매칭 검사
        Future.delayed(const Duration(milliseconds: 300), () {
          _checkAndProcessMatchesRecursively();
        });
      });
    }

    return hasChanges;
  }

  bool _applyGravityRight() {
    bool hasChanges = false;
    print('중력 적용 시작: Right');
    for (int y = 0; y < gridSize; y++) {
      print('($y+1) 행에서 중력 적용 시작');
      for (int x = gridSize - 1; x >= 0; x--) {
        if (grid[y][x] == null) {
          hasChanges = true;
          // 왼쪽에서 젬 찾아서 오른쪽으로 이동
          for (int leftX = x - 1; leftX >= 0; leftX--) {
            print('($y+1) 행의 ($x+1) 열에서 왼쪽에서 젬 찾아서 오른쪽으로 이동');
            if (grid[y][leftX] != null) {
              final gem = grid[y][leftX]!;
              grid[y][leftX] = null;
              grid[y][x] = gem;
              gem.gridX = x;
              gem.moveTo(_gridToScreenPosition(x, y));
              print('($y+1) 행의 ($x+1) 열에서 왼쪽에서 젬 찾아서 오른쪽으로 이동 완료');
              break;
            }
          }
        }
      }
    }

    // 기존 젬들이 이동한 후 새 젬 생성 (딜레이 추가)
    if (hasChanges) {
      Future.delayed(const Duration(milliseconds: 400), () {
        print('새 젬 생성 시작 (Right)');
        for (int y = 0; y < gridSize; y++) {
          for (int x = 0; x < gridSize; x++) {
            if (grid[y][x] == null) {
              _createGemAt(x, y);
            }
          }
        }
        print('새 젬 생성 완료 (Right), 매칭 검사 시작');
        // 새 젬 생성 후 매칭 검사
        Future.delayed(const Duration(milliseconds: 300), () {
          _checkAndProcessMatchesRecursively();
        });
      });
    }

    return hasChanges;
  }

  // 중력 방향 변경
  void setGravityDirection(int direction) {
    gravityDirection = GravityDirection.values[direction - 1];
  }

  // 캐릭터 추가/제거
  void addCharacter(Character character) {
    characters.add(character);
  }

  void removeCharacter(String name) {
    characters.removeWhere((c) => c.name == name);
  }
}

// UI 래퍼 위젯
class PuzzleGameScreen extends StatefulWidget {
  final int? gravityDirection;

  const PuzzleGameScreen({super.key, required this.gravityDirection});

  @override
  State<PuzzleGameScreen> createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  late PuzzleGame game;

  @override
  void initState() {
    super.initState();
    game = PuzzleGame();
    // 전달받은 중력 방향으로 설정
    game.setGravityDirection(widget.gravityDirection ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // 그리드 높이 계산 (화면의 40%)
    final gridHeight = width;
    final battleAreaHeight = height * 0.97 - gridHeight;

    return Column(
      children: [
        // 전투 영역
        SizedBox(
          height: battleAreaHeight,
          child: PuzzleBattleArea(
            game: game,
            gravityDirection: widget.gravityDirection,
          ),
        ),

        // 퍼즐 게임 영역
        SizedBox(
          height: gridHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) {
              final position = Vector2(
                details.localPosition.dx,
                details.localPosition.dy,
              );
              game.onTap(position);
            },
            onPanStart: (details) {
              final position = Vector2(
                details.localPosition.dx,
                details.localPosition.dy,
              );
              game.onDragStart(position);
            },
            onPanUpdate: (details) {
              final position = Vector2(
                details.localPosition.dx,
                details.localPosition.dy,
              );
              game.onDragUpdate(position);
            },
            onPanEnd: (details) {
              game.onDragEnd();
            },
            child: GameWidget(game: game),
          ),
        ),
      ],
    );
  }
}
