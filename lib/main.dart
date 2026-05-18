// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/responsive_helper.dart';
import 'package:bulbul_project/views/about_section.dart';
import 'package:bulbul_project/views/contact_section.dart';
import 'package:bulbul_project/views/footer_section.dart';
import 'package:bulbul_project/views/hero_section.dart';
import 'package:bulbul_project/views/menu_section.dart';
import 'package:bulbul_project/views/nav_bar.dart';
import 'package:bulbul_project/views/reviews_section.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2D1B00),
        scaffoldBackgroundColor: const Color(0xFFFFF8E7),
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
          primary: const Color(0xFFFF6B35),
          secondary: const Color(0xFFF7931E),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  late AnimationController _floatingController;
  int _currentSection = 0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _scrollController.addListener(_updateCurrentSection);
  }

  void _updateCurrentSection() {
    if (_isScrolling) return;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          if (position.dy <= 150 && position.dy >= -200) {
            if (_currentSection != i) {
              setState(() => _currentSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int sectionIndex) async {
    setState(() {
      _currentSection = sectionIndex;
      _isScrolling = true;
    });

    final context = _sectionKeys[sectionIndex].currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }

    await Future.delayed(const Duration(milliseconds: 900));
    _isScrolling = false;
  }

  void _navigateToSection(String label) {
    const sections = ['HOME', 'STORY', 'MENU', 'REVIEWS', 'CONNECT'];
    final index = sections.indexOf(label);
    if (index != -1) {
      _scrollToSection(index);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      body: Stack(
        children: [
          // Animated floating background shapes — desktop only
          if (!isMobile)
            ...List.generate(5, (index) => _buildFloatingShape(index)),

          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                UniqueNavBar(
                  onItemTap: _navigateToSection,
                  currentSection: _currentSection,
                ),
                Container(
                  key: _sectionKeys[0],
                  child: const HeroSectionResponsive(),
                ),
                Container(
                  key: _sectionKeys[1],
                  child: const AboutSectionResponsive(),
                ),
                Container(
                  key: _sectionKeys[2],
                  child: const MenuSectionResponsive(),
                ),
                Container(
                  key: _sectionKeys[3],
                  child: const ReviewsSectionResponsive(),
                ),
                Container(
                  key: _sectionKeys[4],
                  child: ContactSectionResponsive(),
                ),
                const FooterSectionResponsive(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingShape(int index) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final offset =
            math.sin(_floatingController.value * 2 * math.pi + index) * 30;
        return Positioned(
          left: (index * 200.0) % MediaQuery.of(context).size.width,
          top: 100 + offset,
          child: Transform.rotate(
            angle: _floatingController.value * 2 * math.pi,
            child: Container(
              width: 80 + (index * 20),
              height: 80 + (index * 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF6B35).withOpacity(0.1),
                    const Color(0xFFF7931E).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20 + index * 5),
              ),
            ),
          ),
        );
      },
    );
  }
}