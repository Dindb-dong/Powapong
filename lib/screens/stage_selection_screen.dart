import 'package:flutter/material.dart';
import 'puzzle_game_screen.dart';
import '../widgets/bottom_navigation.dart';

class StageSelectionScreen extends StatelessWidget {
  final int chapterNumber;

  const StageSelectionScreen({super.key, required this.chapterNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        title: Text(
          '챕터 $chapterNumber',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 챕터 정보
            Container(
              padding: const EdgeInsets.all(16), // 20에서 16으로 변경
              child: Column(
                children: [
                  // 챕터 아이콘과 제목
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40, // 50에서 40으로 변경
                        height: 40, // 50에서 40으로 변경
                        decoration: const BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getChapterIcon(chapterNumber),
                          color: Colors.white,
                          size: 20, // 25에서 20으로 변경
                        ),
                      ),
                      const SizedBox(width: 8), // 12에서 8로 변경
                      Text(
                        '챕터 $chapterNumber',
                        style: const TextStyle(
                          fontSize: 20, // 24에서 20으로 변경
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4), // 8에서 4로 변경
                  Text(
                    _getChapterDescription(chapterNumber),
                    style: const TextStyle(
                      fontSize: 14, // 16에서 14로 변경
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // 스테이지 그리드
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8, // 12에서 8로 변경
                  mainAxisSpacing: 8, // 12에서 8로 변경
                  childAspectRatio: 0.9, // 0.8에서 0.9로 변경
                ),
                itemCount: 10, // 10개 스테이지
                itemBuilder: (context, index) {
                  final stageNumber = index + 1;
                  final isUnlocked = stageNumber <= 5; // 처음 5개 스테이지만 열림
                  final isCompleted = stageNumber <= 3; // 처음 3개 스테이지만 완료

                  return GestureDetector(
                    onTap: isUnlocked
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PuzzleGameScreen(
                                  gravityDirection: _getChapterGravityDirection(
                                    chapterNumber,
                                  ),
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isUnlocked ? Colors.white : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12), // 15에서 12로 변경
                        boxShadow: isUnlocked
                            ? [
                                BoxShadow(
                                  color: Colors.pink.withValues(alpha: 0.2),
                                  blurRadius: 6, // 8에서 6으로 변경
                                  offset: const Offset(0, 2), // 3에서 2로 변경
                                ),
                              ]
                            : null,
                        border: isUnlocked
                            ? Border.all(
                                color: isCompleted
                                    ? Colors.green
                                    : Colors.pink.withValues(alpha: 0.3),
                                width: 2,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 스테이지 번호
                          Container(
                            width: 32, // 40에서 32로 변경
                            height: 32, // 40에서 32로 변경
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? Colors.green
                                  : (isUnlocked ? Colors.pink : Colors.grey),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$stageNumber',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14, // 16에서 14로 변경
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 4), // 8에서 4로 변경
                          // 스테이지 제목
                          Text(
                            '스테이지 $stageNumber',
                            style: TextStyle(
                              fontSize: 10, // 12에서 10으로 변경
                              fontWeight: FontWeight.bold,
                              color: isUnlocked
                                  ? Colors.pink
                                  : Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          if (isCompleted) ...[
                            const SizedBox(height: 2), // 4에서 2로 변경
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 12, // 16에서 12로 변경
                            ),
                          ] else if (!isUnlocked) ...[
                            const SizedBox(height: 2), // 4에서 2로 변경
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4, // 6에서 4로 변경
                                vertical: 1, // 2에서 1로 변경
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                  6,
                                ), // 8에서 6으로 변경
                              ),
                              child: const Text(
                                '잠김',
                                style: TextStyle(
                                  fontSize: 7, // 8에서 7로 변경
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 2, // 퍼즐 탭이 선택됨
        onItemTapped: (index) {
          // 이 화면에서는 탭 변경 불가
        },
      ),
    );
  }

  IconData _getChapterIcon(int chapterNumber) {
    switch (chapterNumber) {
      case 1:
        return Icons.forest; // 숲
      case 2:
        return Icons.water; // 물
      case 3:
        return Icons.local_fire_department; // 불
      case 4:
        return Icons.air; // 바람
      case 5:
        return Icons.electric_bolt; // 전기
      case 6:
        return Icons.ac_unit; // 얼음
      case 7:
        return Icons.science; // 독
      case 8:
        return Icons.landscape; // 바위
      case 9:
        return Icons.build; // 금속
      case 10:
        return Icons.auto_awesome; // 빛
      default:
        return Icons.star;
    }
  }

  String _getChapterDescription(int chapterNumber) {
    switch (chapterNumber) {
      case 1:
        return '숲의 시작 - 자연의 힘을 느껴보세요';
      case 2:
        return '물의 힘 - 유연함과 적응력을 배우세요';
      case 3:
        return '불의 열정 - 뜨거운 의지로 도전하세요';
      case 4:
        return '바람의 자유 - 자유로운 영혼을 찾아보세요';
      case 5:
        return '전기의 속도 - 빠른 반응으로 승리하세요';
      case 6:
        return '얼음의 차가움 - 냉정한 판단으로 승리하세요';
      case 7:
        return '독의 위험 - 위험한 선택의 결과를 보세요';
      case 8:
        return '바위의 견고함 - 강한 의지로 버티세요';
      case 9:
        return '금속의 강함 - 변하지 않는 강함을 보여주세요';
      case 10:
        return '빛의 희망 - 희망의 빛으로 승리하세요';
      default:
        return '특별한 챕터';
    }
  }

  int _getChapterGravityDirection(int chapterNumber) {
    switch (chapterNumber) {
      case 1:
        return 1; // 아래
      case 2:
        return 2; // 왼쪽
      case 3:
        return 3; // 위
      case 4:
        return 4; // 오른쪽
      case 5:
        return 1; // 아래
      case 6:
        return 2; // 왼쪽
      case 7:
        return 3; // 위
      case 8:
        return 4; // 오른쪽
      case 9:
        return 1; // 아래
      case 10:
        return 2; // 왼쪽
      default:
        return 1; // 기본값: 아래
    }
  }
}
