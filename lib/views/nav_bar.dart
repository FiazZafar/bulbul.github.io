// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/app_logo.dart';
import 'package:flutter/material.dart';

// ==================== RESPONSIVE NAVBAR ====================
class UniqueNavBar extends StatefulWidget {
  final void Function(String label) onItemTap;
  final int currentSection;

  const UniqueNavBar({
    super.key,
    required this.onItemTap,
    required this.currentSection,
  });

  @override
  State<UniqueNavBar> createState() => _UniqueNavBarState();
}

class _UniqueNavBarState extends State<UniqueNavBar> {
  String _hoveredItem = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Container(
      margin: EdgeInsets.all(isMobile ? 10 : 20),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 15 : 30,
        vertical: isMobile ? 10 : 15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D1B00).withOpacity(0.95),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: const Color(0xFFFF6B35).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.onItemTap('HOME'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: isMobile ? 40 : 50,
                  width: isMobile ? 100 : 120,
                  padding: EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                    ),
                  ),
                  child: BulbulLogo(width: isMobile ? 90 : 110),
                ),
              ),
            ),
          ),

          if (!isMobile)
            Row(
              children: [
                _buildNavItem('HOME', 0),
                _buildNavItem('STORY', 1),
                _buildNavItem('MENU', 2),
                _buildNavItem('REVIEWS', 3),
                _buildNavItem('CONNECT', 4),
              ],
            ),

          // Mobile hamburger menu
          if (isMobile)
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 28,
              ),
              onSelected: widget.onItemTap,
              color: const Color(0xFF2D1B00),
              itemBuilder: (BuildContext context) =>
                  ['HOME', 'STORY', 'MENU', 'REVIEWS', 'CONNECT'].map((
                    String item,
                  ) {
                    final index = [
                      'HOME',
                      'STORY',
                      'MENU',
                      'REVIEWS',
                      'CONNECT',
                    ].indexOf(item);
                    final isActive = widget.currentSection == index;
                    return PopupMenuItem<String>(
                      value: item,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFFF6B35).withOpacity(0.2)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: isActive
                                ? const Color(0xFFFF6B35)
                                : Colors.white,
                            fontWeight: isActive
                                ? FontWeight.w900
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int sectionIndex) {
    final isHovered = _hoveredItem == label;
    final isActive = widget.currentSection == sectionIndex;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredItem = label),
      onExit: (_) => setState(() => _hoveredItem = ''),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: TextButton(
          onPressed: () => widget.onItemTap(label),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: isActive
                ? const Color(0xFFFF6B35)
                : isHovered
                ? const Color(0xFFFF6B35).withOpacity(0.5)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
              letterSpacing: isHovered || isActive ? 2 : 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
