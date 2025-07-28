import 'package:flutter/material.dart';
import '../screens/puzzle_game_screen.dart';
import 'options_modal.dart';

class PuzzleBattleArea extends StatelessWidget {
  final PuzzleGame game;
  final int? gravityDirection;

  const PuzzleBattleArea({
    super.key,
    required this.game,
    required this.gravityDirection,
  });

  String _getGravityDirectionText(int? direction) {
    final dir = direction ?? 1;
    switch (dir) {
      case 1:
        return '아래';
      case 2:
        return '왼쪽';
      case 3:
        return '위';
      case 4:
        return '오른쪽';
      default:
        return '아래';
    }
  }

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const OptionsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Battle Area',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 중력 방향 표시 (읽기 전용)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '중력 방향: ${_getGravityDirectionText(gravityDirection)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 캐릭터 정보
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '캐릭터: ${game.characters.map((c) {
                    try {
                      final attrNames = c.attributes.isNotEmpty ? c.attributes.map((a) => a.name).join(", ") : "무속성";
                      return "${c.name}($attrNames)";
                    } catch (e) {
                      return "${c.name}(오류)";
                    }
                  }).join(", ")}',
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),

          // 옵션 버튼 (우측 상단)
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showOptionsModal(context);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pink.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
