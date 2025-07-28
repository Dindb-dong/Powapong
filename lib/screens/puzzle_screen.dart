import 'package:flutter/material.dart';
import 'chapter_selection_screen.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5), // 연한 핑크 배경
      body: SafeArea(
        child: Column(
          children: [
            // 상단 레벨 표시 영역
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 프로필 아이콘
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 레벨 정보
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'LU: 27, 72%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 진행률 바
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.72,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 메인 콘텐츠 영역
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // 상단 하늘과 열차 영역
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFE4E1), // 연한 오렌지
                              Color(0xFFFFB6C1), // 연한 핑크
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Stack(
                          children: [
                            // 구름들
                            Positioned(
                              top: 20,
                              left: 30,
                              child: _buildCloud(40, 30),
                            ),
                            Positioned(
                              top: 40,
                              right: 50,
                              child: _buildCloud(50, 35),
                            ),
                            Positioned(
                              top: 15,
                              right: 20,
                              child: _buildCloud(35, 25),
                            ),
                            // 열차 (터치 가능)
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChapterSelectionScreen(),
                                    ),
                                  );
                                },
                                child: _buildTrain(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 중간 캐릭터 영역
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: const Color(0xFF90EE90), // 연한 초록
                        child: Stack(
                          children: [
                            // 작은 나무들
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: _buildSmallBush(30, 20),
                            ),
                            Positioned(
                              bottom: 30,
                              right: 30,
                              child: _buildSmallBush(25, 15),
                            ),
                            // 메인 캐릭터
                            Center(child: _buildMainCharacter()),
                          ],
                        ),
                      ),
                    ),

                    // 하단 집 영역
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: const Color(0xFF90EE90), // 연한 초록
                        child: Stack(
                          children: [
                            // 집
                            Positioned(
                              bottom: 10,
                              right: 20,
                              child: _buildHouse(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 하단 기능 영역 (아직 기능 없음)
            Container(
              height: 80,
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.pink.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.pink.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '추가 기능 준비 중...',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloud(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }

  Widget _buildTrain() {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          // 기관차
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF2F4F4F), // 다크 틸
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // 창문
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // 굴뚝
                Positioned(
                  top: 5,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // 객차
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF8B4513), // 갈색
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // 창문들
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallBush(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF228B22), // 포레스트 그린
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }

  Widget _buildMainCharacter() {
    return SizedBox(
      width: 100,
      height: 120,
      child: Stack(
        children: [
          // 몸체 (구름 모양)
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFFB6C1), // 연한 핑크
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          // 얼굴
          Positioned(
            top: 20,
            left: 35,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  // 눈
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // 눈물
                  Positioned(
                    top: 12,
                    left: 6,
                    child: Container(
                      width: 4,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHouse() {
    return SizedBox(
      width: 60,
      height: 50,
      child: Stack(
        children: [
          // 집 몸체
          Positioned(
            bottom: 0,
            child: Container(
              width: 50,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513), // 갈색
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  // 문
                  Positioned(
                    bottom: 0,
                    left: 8,
                    child: Container(
                      width: 12,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF654321), // 어두운 갈색
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 창문
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 지붕
          Positioned(
            top: 0,
            left: 5,
            child: Container(
              width: 40,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFCD853F), // 페루
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
