// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/app_logo.dart';
import 'package:bulbul_project/responsive_helper.dart';
import 'package:flutter/material.dart';

class FooterSectionResponsive extends StatelessWidget {
  const FooterSectionResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 30 : 60),
      color: const Color(0xFF1A0F00),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    _buildBrandSection(isMobile),
                    const SizedBox(height: 30),
                    _buildSocialIcons(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildBrandSection(isMobile), _buildSocialIcons()],
                ),

          SizedBox(height: isMobile ? 40 : 60),

          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.0),
                  const Color(0xFFFF6B35).withOpacity(0.3),
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, color: Color(0xFFFF6B35), size: 16),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '© ${DateTime.now().year} BULBUL CAFE. CRAFTED WITH PASSION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: isMobile ? 10 : 12,
                    letterSpacing: isMobile ? 1 : 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: isMobile ? 60 : 70,
            width: isMobile ? 150 : 170,
            padding: EdgeInsets.all(4),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
              ),
            ),
            child: BulbulLogo(width: isMobile ? 140 : 160),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Authentic Pakistani Cuisine',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: Colors.white54,
            fontSize: isMobile ? 12 : 14,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 15),
        _buildSocialIcon(Icons.camera_alt),
        const SizedBox(width: 15),
        _buildSocialIcon(Icons.phone_android),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFFF6B35).withOpacity(0.3),
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFFFF6B35), size: 20),
    );
  }
}
