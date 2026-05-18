// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/responsive_helper.dart';
import 'package:flutter/material.dart';

class ReviewsSectionResponsive extends StatelessWidget {
  const ReviewsSectionResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final padding = ResponsiveHelper.getResponsivePadding(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF8E7),
            const Color(0xFFFF6B35).withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (!isMobile)
                Text(
                  'REVIEWS',
                  style: TextStyle(
                    fontSize: isTablet ? 80 : 120,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = const Color(0xFFFF6B35).withOpacity(0.1),
                  ),
                ),
              Text(
                'WHAT PEOPLE SAY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 24 : (isTablet ? 28 : 36),
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D1B00),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 40 : (isTablet ? 60 : 80)),

          SizedBox(
            height: isMobile ? 350 : 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 10),
              itemBuilder: (context, index) {
                return _ResponsiveReviewCard(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveReviewCard extends StatelessWidget {
  final int index;

  const _ResponsiveReviewCard({required this.index});

  static const List<String> _avatarUrls = [
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&q=80',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&q=80',
    'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150&q=80',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&q=80',
  ];

  static const List<String> _reviewerNames = [
    'Ahmed Khan',
    'Sara Malik',
    'Hassan Ali',
    'Ayesha Raza',
    'Usman Tariq',
  ];

  static const List<String> _reviewerTitles = [
    'Food Enthusiast',
    'Food Blogger',
    'Regular Customer',
    'Food Critic',
    'Local Guide',
  ];

  static const List<String> _reviewTexts = [
    '"The best biryani I\'ve ever tasted! Authentic flavors that remind me of home. The karahi is absolutely mind-blowing!"',
    '"Bulbul Cafe is my go-to place for Pakistani food. The seekh kabab melts in your mouth — truly unforgettable!"',
    '"Been coming here for years. The dal makhani and nihari are consistently outstanding. Love this place!"',
    '"Exceptional food quality and warm hospitality. The chicken tikka is smoky, juicy, and perfectly spiced."',
    '"Hidden gem in Sahiwal! Authentic taste, generous portions, and great value. Highly recommend the karahi!"',
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: isMobile ? width * 0.85 : 350,
      margin: EdgeInsets.only(right: isMobile ? 15 : 30),
      padding: EdgeInsets.all(isMobile ? 25 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFFF6B35).withOpacity(0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isMobile ? 50 : 60,
                height: isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    _avatarUrls[index % _avatarUrls.length],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _reviewerNames[index % _reviewerNames.length],
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2D1B00),
                      ),
                    ),
                    Text(
                      _reviewerTitles[index % _reviewerTitles.length],
                      style: TextStyle(
                        fontSize: isMobile ? 11 : 12,
                        color: const Color(0xFF9B8B7E),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          Row(
            children: List.generate(
              5,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.star_rounded,
                  color: const Color(0xFFFF6B35),
                  size: isMobile ? 18 : 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Text(
              _reviewTexts[index % _reviewTexts.length],
              style: TextStyle(
                fontSize: isMobile ? 14 : 15,
                height: 1.8,
                color: const Color(0xFF6B5B4E),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 15),

          Container(
            height: 3,
            width: 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
