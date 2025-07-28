import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/inventory_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/puzzle_screen.dart';
import 'screens/friend_screen.dart';
import 'screens/character_screen.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 전체 화면 모드 설정 (안드로이드 네비게이션 바 숨김)
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );

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
    const CharacterScreen(),
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
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
