import 'package:flutter/material.dart';
import 'stage_selection_screen.dart';
import '../widgets/bottom_navigation.dart';

class ChapterSelectionScreen extends StatelessWidget {
  const ChapterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        title: const Text(
          '챕터 선택',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            // 상단 설명
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                '챕터를 선택하여 스테이지를 진행하세요!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // 챕터 그리드
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0, // 1.2에서 1.0으로 변경
                ),
                itemCount: 10, // 10개 챕터
                itemBuilder: (context, index) {
                  final chapterNumber = index + 1;
                  final isUnlocked = chapterNumber <= 3; // 처음 3개 챕터만 열림

                  return GestureDetector(
                    onTap: isUnlocked
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StageSelectionScreen(
                                  chapterNumber: chapterNumber,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isUnlocked ? Colors.white : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isUnlocked
                            ? [
                                BoxShadow(
                                  color: Colors.pink.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                            : null,
                        border: isUnlocked
                            ? Border.all(
                                color: Colors.pink.withValues(alpha: 0.3),
                                width: 2,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 챕터 아이콘
                          Container(
                            width: 50, // 60에서 50으로 변경
                            height: 50, // 60에서 50으로 변경
                            decoration: BoxDecoration(
                              color: isUnlocked ? Colors.pink : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getChapterIcon(chapterNumber),
                              color: Colors.white,
                              size: 25, // 30에서 25로 변경
                            ),
                          ),
                          const SizedBox(height: 8), // 12에서 8로 변경
                          // 챕터 제목
                          Text(
                            '챕터 $chapterNumber',
                            style: TextStyle(
                              fontSize: 14, // 16에서 14로 변경
                              fontWeight: FontWeight.bold,
                              color: isUnlocked
                                  ? Colors.pink
                                  : Colors.grey[600],
                            ),
                          ),

                          const SizedBox(height: 2), // 4에서 2로 변경
                          // 챕터 설명
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              _getChapterDescription(chapterNumber),
                              style: TextStyle(
                                fontSize: 10, // 12에서 10으로 변경
                                color: isUnlocked
                                    ? Colors.grey[600]
                                    : Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(height: 2),
                          // 중력 방향 표시
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isUnlocked
                                  ? Colors.blue.withValues(alpha: 0.1)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isUnlocked
                                    ? Colors.blue.withValues(alpha: 0.3)
                                    : Colors.grey[400]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '중력: ${_getGravityDirectionText(_getChapterGravityDirection(chapterNumber))}',
                              style: TextStyle(
                                fontSize: 8,
                                color: isUnlocked
                                    ? Colors.blue[700]
                                    : Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          if (!isUnlocked) ...[
                            const SizedBox(height: 4), // 8에서 4로 변경
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6, // 8에서 6으로 변경
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                  10,
                                ), // 12에서 10으로 변경
                              ),
                              child: const Text(
                                '잠김',
                                style: TextStyle(
                                  fontSize: 9, // 10에서 9로 변경
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
        return '숲의 시작';
      case 2:
        return '물의 힘';
      case 3:
        return '불의 열정';
      case 4:
        return '바람의 자유';
      case 5:
        return '전기의 속도';
      case 6:
        return '얼음의 차가움';
      case 7:
        return '독의 위험';
      case 8:
        return '바위의 견고함';
      case 9:
        return '금속의 강함';
      case 10:
        return '빛의 희망';
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

  String _getGravityDirectionText(int direction) {
    switch (direction) {
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
}
