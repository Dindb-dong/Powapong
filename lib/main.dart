import 'package:flutter/material.dart';
import 'screens/inventory_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/puzzle_screen.dart';
import 'screens/friend_screen.dart';
import 'screens/pet_screen.dart';

const Color kTabBg = Color(0xFFFFD1F7); // 연분홍
const Color kTabIcon = Color(0xFFE05EFF); // 분홍
const Color kTabIconActive = Color(0xFFD100FF); // 진한 분홍

void main() {
  runApp(const PowapongApp());
}

class PowapongApp extends StatelessWidget {
  const PowapongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Powapong',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // 앱 전체 배경을 흰색으로
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Default to Puzzle (Main)

  static final List<Widget> _pages = <Widget>[
    const InventoryScreen(),
    const ShopScreen(),
    const PuzzleScreen(),
    const FriendScreen(),
    const PetScreen(),
  ];

  static const List<String> _iconPaths = [
    'lib/assets/icons/icon_inventory.png',
    'lib/assets/icons/icon_shop.png',
    'lib/assets/icons/icon_puzzle.png',
    'lib/assets/icons/icon_friend.png',
    'lib/assets/icons/icon_pet.png',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱 전체 배경은 흰색, 하단 탭만 핑크
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: kTabBg,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_iconPaths.length, (index) {
            final isActive = _selectedIndex == index;
            final double iconSize = isActive ? 48 : 40; // 활성 탭 아이콘 확대
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                decoration: isActive
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      )
                    : null,
                padding: const EdgeInsets.all(14),
                child: Image.asset(
                  _iconPaths[index],
                  width: iconSize,
                  height: iconSize,
                  color: isActive
                      ? kTabIconActive
                      : kTabIcon.withValues(alpha: 0.4),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
