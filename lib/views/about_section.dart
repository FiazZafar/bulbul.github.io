// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/responsive_helper.dart';
import 'package:flutter/material.dart';

class AboutSectionResponsive extends StatelessWidget {
  const AboutSectionResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final padding = ResponsiveHelper.getResponsivePadding(context);

    return Container(
      padding: padding,
      color: const Color(0xFFFFF8E7),
      child: isMobile
          ? Column(
              children: [
                _buildLeftContent(context),
                const SizedBox(height: 40),
                _buildRightContent(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLeftContent(context)),
                SizedBox(width: isTablet ? 40 : 100),
                Expanded(child: _buildRightContent(context)),
              ],
            ),
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 12 : 15),
          decoration: const BoxDecoration(
            color: Color(0xFFFF6B35),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: isMobile ? 24 : 30,
          ),
        ),
        SizedBox(height: isMobile ? 20 : 30),
        Text(
          'OUR',
          style: TextStyle(
            fontSize: isMobile ? 32 : (isTablet ? 45 : 60),
            fontWeight: FontWeight.w300,
            color: const Color(0xFF2D1B00),
            height: 1,
          ),
        ),
        Stack(
          children: [
            Text(
              'STORY',
              style: TextStyle(
                fontSize: isMobile ? 32 : (isTablet ? 45 : 60),
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color(0xFFFF6B35),
                height: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 20 : 30),
        Container(
          height: 4,
          width: isMobile ? 60 : 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
            ),
          ),
        ),
        SizedBox(height: isMobile ? 20 : 30),
        Text(
          'Since 1985, we\'ve been crafting authentic Pakistani cuisine that brings people together. Our secret? Fresh ingredients, traditional recipes, and a whole lot of heart.',
          style: TextStyle(
            fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
            height: 1.8,
            color: const Color(0xFF6B5B4E),
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: isMobile ? 15 : 20),
        Text(
          'Every dish we serve is a celebration of our rich culinary heritage, prepared with the same passion and dedication that started it all.',
          style: TextStyle(
            fontSize: isMobile ? 13 : (isTablet ? 14 : 16),
            height: 1.8,
            color: const Color(0xFF9B8B7E),
          ),
        ),
        SizedBox(height: isMobile ? 30 : 40),
        isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      _ResponsiveStatCard(
                        number: '38+',
                        label: 'YEARS',
                        color: Color(0xFFFF6B35),
                      ),
                      SizedBox(width: 15),
                      _ResponsiveStatCard(
                        number: '50K+',
                        label: 'SERVED',
                        color: Color(0xFFF7931E),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  _ResponsiveStatCard(
                    number: '100+',
                    label: 'DISHES',
                    color: Color(0xFFFF6B35),
                  ),
                ],
              )
            : Row(
                children: const [
                  _ResponsiveStatCard(
                    number: '38+',
                    label: 'YEARS',
                    color: Color(0xFFFF6B35),
                  ),
                  SizedBox(width: 15),
                  _ResponsiveStatCard(
                    number: '50K+',
                    label: 'SERVED',
                    color: Color(0xFFF7931E),
                  ),
                  SizedBox(width: 15),
                  _ResponsiveStatCard(
                    number: '100+',
                    label: 'DISHES',
                    color: Color(0xFFFF6B35),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildRightContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 500),
        child: Column(
          children: [
            Row(
              children: [
                // Pakistani restaurant / cooking image
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: isMobile ? 150 : (isTablet ? 180 : 250),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D1B00),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFFF6B35),
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80',
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.15),
                          colorBlendMode: BlendMode.darken,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.restaurant_rounded,
                                  size: 60,
                                  color: Color(0xFFFF6B35),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Karahi / fire cooking image
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: isMobile ? 150 : (isTablet ? 180 : 250),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1574653853027-5382a3d23a15?w=600&q=80',
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.2),
                          colorBlendMode: BlendMode.darken,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.local_fire_department_rounded,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Traditional spices / ingredients image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: isMobile ? 100 : (isTablet ? 120 : 150),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7931E).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF7931E), width: 2),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800&q=80',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.45),
                        colorBlendMode: BlendMode.darken,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                    Center(
                      child: Text(
                        '✨ AUTHENTIC FLAVORS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : (isTablet ? 20 : 24),
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveStatCard extends StatelessWidget {
  final String number;
  final String label;
  final Color color;

  const _ResponsiveStatCard({
    required this.number,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          SizedBox(height: isMobile ? 3 : 5),
          Text(
            label,
            style: TextStyle(
              fontSize: isMobile ? 10 : 12,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2D1B00),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
