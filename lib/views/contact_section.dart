// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:bulbul_project/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'dart:html' hide VoidCallback;
import 'dart:ui_web' as ui;

class ContactSectionResponsive extends StatelessWidget {
  ContactSectionResponsive({super.key}) {
    ui.platformViewRegistry.registerViewFactory(
      'map-iframe-responsive',
      (int viewId) => IFrameElement()
        ..src =
            'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3432.3176797293563!2d73.1192334!3d30.653181699999994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3922b7c123226b53%3A0x16d26960d9b4fb77!2sBulbul%20Hotel%20pakpattan%20chowk!5e0!3m2!1sen!2s!4v1763971643322!5m2!1sen!2s'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final padding = ResponsiveHelper.getResponsivePadding(context);

    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D1B00), Color(0xFF1A0F00)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Column(
              children: [
                _buildLeftContent(context),
                const SizedBox(height: 40),
                _buildRightContent(context),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildLeftContent(context)),
                SizedBox(width: isTablet ? 40 : 60),
                Expanded(flex: 2, child: _buildRightContent(context)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN',
          style: TextStyle(
            fontSize: isMobile ? 32 : (isTablet ? 45 : 60),
            fontWeight: FontWeight.w300,
            color: Colors.white,
            height: 1,
          ),
        ),
        Stack(
          children: [
            Text(
              'TOUCH',
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
        SizedBox(height: isMobile ? 20 : 40),
        Text(
          'Visit us, call us, or drop by for the best Pakistani food experience in Sahiwal.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 18,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        SizedBox(height: isMobile ? 30 : 50),
        _buildContactRow(
            Icons.location_on_rounded, 'Main Street, Sahiwal, Pakistan', isMobile),
        const SizedBox(height: 20),
        _buildContactRow(Icons.phone_rounded, '+92 300 1234567', isMobile),
        const SizedBox(height: 20),
        _buildContactRow(Icons.email_rounded, 'info@bulbulcafe.com', isMobile),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text, bool isMobile) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 10 : 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF6B35), width: 2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFFF6B35), size: isMobile ? 20 : 24),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildRightContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      children: [
        // Hours card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 20 : 30),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF6B35), width: 3),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 15 : 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: isMobile ? 30 : 40,
                ),
              ),
              SizedBox(height: isMobile ? 15 : 20),
              Text(
                'OPEN HOURS',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: isMobile ? 10 : 15),
              Text(
                'Monday - Sunday',
                style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.white70),
              ),
              SizedBox(height: isMobile ? 6 : 8),
              Text(
                '8:00 AM - 11:00 PM',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 26,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFFF6B35),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          height: isMobile ? 250 : (isTablet ? 300 : 350),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF6B35), width: 3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: const HtmlElementView(viewType: 'map-iframe-responsive'),
          ),
        ),
      ],
    );
  }
}