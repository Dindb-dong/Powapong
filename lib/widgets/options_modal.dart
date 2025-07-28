import 'package:flutter/material.dart';

class OptionsModal extends StatelessWidget {
  const OptionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 핸들 바
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 제목
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '게임 옵션',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),

          // 옵션 목록
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              // 게임 포기 버튼
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                title: const Text(
                  '게임 포기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  '현재 게임을 포기하고 이전 화면으로 돌아갑니다',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  _showGameAbandonDialog(context);
                },
              ),

              const Divider(),

              // 설정 버튼
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                title: const Text(
                  '게임 설정',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  '게임 설정을 변경합니다',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  // TODO: 게임 설정 화면으로 이동
                  Navigator.pop(context);
                },
              ),

              const Divider(),

              // 도움말 버튼
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.help_outline,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                title: const Text(
                  '도움말',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  '게임 방법을 확인합니다',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  // TODO: 도움말 화면으로 이동
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          // 하단 여백
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showGameAbandonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange, size: 24),
              SizedBox(width: 8),
              Text(
                '게임 포기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            '정말로 현재 게임을 포기하시겠습니까?\n\n진행 상황이 모두 사라집니다.',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 옵션 모달 닫기
                Navigator.pop(context); // 게임 화면 닫기 (이전 화면으로 이동)
              },
              child: const Text(
                '포기',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
