import 'package:flutter/material.dart';

const Color kTabBg = Color(0xFFFFD1F7); // 연분홍
const Color kTabIcon = Color(0xFFE05EFF); // 분홍
const Color kTabIconActive = Color(0xFFD100FF); // 진한 분홍

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  static const List<String> _iconPaths = [
    'lib/assets/icons/icon_inventory.png',
    'lib/assets/icons/icon_shop.png',
    'lib/assets/icons/icon_puzzle.png',
    'lib/assets/icons/icon_friend.png',
    'lib/assets/icons/icon_pet.png',
  ];

  static const List<String> _tabLabels = [
    'Bag',
    'Shop',
    'Main',
    'Friend',
    'Character',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.1,
      child: Container(
        color: kTabBg,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_iconPaths.length, (index) {
            final isActive = selectedIndex == index;
            final double iconSize = isActive ? 40 : 32;
            return GestureDetector(
              onTap: () => onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                decoration: isActive
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      )
                    : null,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _iconPaths[index],
                      width: iconSize,
                      height: iconSize,
                      color: isActive
                          ? kTabIconActive
                          : kTabIcon.withValues(alpha: 0.4),
                    ),
                    Text(
                      _tabLabels[index],
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: isActive ? kTabIconActive : kTabIcon,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
