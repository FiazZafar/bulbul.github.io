// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HeroSectionResponsive extends StatefulWidget {
  const HeroSectionResponsive({super.key});

  @override
  State<HeroSectionResponsive> createState() => _HeroSectionResponsiveState();
}

class _HeroSectionResponsiveState extends State<HeroSectionResponsive>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          // Background image - Pakistani food spread
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1567337710282-00832b415979?w=1600&q=80',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.65),
              colorBlendMode: BlendMode.darken,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(color: const Color(0xFF2D1B00));
              },
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFF2D1B00)),
            ),
          ),

          // Animated gradient overlay
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        const Color(0xFF2D1B00).withOpacity(0.7),
                        const Color(0xFF4A2C00).withOpacity(0.7),
                        math.sin(_controller.value * 2 * math.pi) * 0.5 + 0.5,
                      )!,
                      Colors.transparent,
                      Color.lerp(
                        const Color(0xFF1A0F00).withOpacity(0.5),
                        const Color(0xFF2D1B00).withOpacity(0.5),
                        math.cos(_controller.value * 2 * math.pi) * 0.5 + 0.5,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),

          // Background text - hide on mobile
          if (!isMobile)
            Positioned(
              right: -100,
              top: size.height * 0.2,
              child: Opacity(
                opacity: 0.04,
                child: Transform.rotate(
                  angle: -0.1,
                  child: Text(
                    'FOOD',
                    style: TextStyle(
                      fontSize: isTablet ? 150 : 300,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Main content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
                  vertical: isMobile ? 40 : 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: isMobile ? 80 : 100),

                    // Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 15 : 20,
                        vertical: isMobile ? 6 : 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFF6B35),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'EST. 1985',
                        style: TextStyle(
                          color: const Color(0xFFFF6B35),
                          fontSize: isMobile ? 10 : 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                        ),
                      ),
                    ),

                    SizedBox(height: isMobile ? 20 : 30),

                    // Main title
                    if (isMobile)
                      _buildMobileTitle()
                    else
                      _buildDesktopTitle(isTablet),

                    SizedBox(height: isMobile ? 20 : 30),

                    // Subtitle
                    Text(
                      'Where every bite tells a story of tradition,\npassion, and authentic Pakistani flavors.',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                        color: Colors.white70,
                        height: 1.6,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: isMobile ? 30 : 50),

                    // CTA Buttons
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _ResponsiveCTAButton(
                                text: 'EXPLORE MENU',
                                isPrimary: true,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 15),
                              _ResponsiveCTAButton(
                                text: 'RESERVE TABLE',
                                isPrimary: false,
                                onPressed: () {},
                              ),
                            ],
                          )
                        : Wrap(
                            spacing: 20,
                            runSpacing: 15,
                            children: [
                              _ResponsiveCTAButton(
                                text: 'EXPLORE MENU',
                                isPrimary: true,
                                onPressed: () {},
                              ),
                              _ResponsiveCTAButton(
                                text: 'RESERVE TABLE',
                                isPrimary: false,
                                onPressed: () {},
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),

          // Floating element - hide on mobile
          if (!isMobile)
            Positioned(
              right: isTablet ? 20 : 50,
              bottom: isTablet ? 20 : 50,
              child: _buildFloatingFoodElement(isTablet),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TASTE THE',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'REAL PAKISTAN',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopTitle(bool isTablet) {
    final fontSize = isTablet ? 50.0 : 90.0;
    final realFontSize = isTablet ? 45.0 : 80.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TASTE',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 0.9,
            letterSpacing: -2,
          ),
        ),
        Row(
          children: [
            Text(
              'THE',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 0.9,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20 : 30,
                vertical: isTablet ? 8 : 10,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'REAL',
                style: TextStyle(
                  fontSize: realFontSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
        Text(
          'PAKISTAN',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 0.9,
            letterSpacing: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingFoodElement(bool isTablet) {
    final size = isTablet ? 250.0 : 400.0;
    final innerSize = isTablet ? 180.0 : 300.0;
    final iconSize = isTablet ? 60.0 : 100.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            math.cos(_controller.value * 2 * math.pi) * 20,
            math.sin(_controller.value * 2 * math.pi) * 20,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFFF6B35).withOpacity(0.3),
                  const Color(0xFFFF6B35).withOpacity(0.0),
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: innerSize,
                height: innerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF7931E).withOpacity(0.1),
                  border: Border.all(
                    color: const Color(0xFFFF6B35).withOpacity(0.3),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.restaurant_rounded,
                    size: iconSize,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==================== RESPONSIVE CTA BUTTON ====================
class _ResponsiveCTAButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _ResponsiveCTAButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<_ResponsiveCTAButton> createState() => _ResponsiveCTAButtonState();
}

class _ResponsiveCTAButtonState extends State<_ResponsiveCTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 30 : 40,
            vertical: isMobile ? 15 : 20,
          ),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                  )
                : null,
            color: !widget.isPrimary ? Colors.transparent : null,
            border: !widget.isPrimary
                ? Border.all(color: Colors.white, width: 2)
                : null,
            borderRadius: BorderRadius.circular(0),
            boxShadow: _isHovered && widget.isPrimary
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF6B35).withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                _isHovered
                    ? Icons.arrow_forward_rounded
                    : Icons.arrow_right_alt_rounded,
                color: Colors.white,
                size: isMobile ? 18 : 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}