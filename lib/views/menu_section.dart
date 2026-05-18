// ignore_for_file: deprecated_member_use

import 'package:bulbul_project/responsive_helper.dart';
import 'package:flutter/material.dart';

class MenuSectionResponsive extends StatelessWidget {
  const MenuSectionResponsive({super.key});

  static const List<_MenuItemData> _menuItems = [
    _MenuItemData(
      title: 'CHICKEN\nKARAHI',
      price: '850',
      index: 0,
      imageUrl:
          'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=600&q=80',
    ),
    _MenuItemData(
      title: 'MUTTON\nBIRYANI',
      price: '950',
      index: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&q=80',
    ),
    _MenuItemData(
      title: 'SEEKH\nKABAB',
      price: '650',
      index: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=600&q=80',
    ),
    _MenuItemData(
      title: 'BEEF\nNIHARI',
      price: '750',
      index: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=600&q=80',
    ),
    _MenuItemData(
      title: 'DAL\nMAKHANI',
      price: '450',
      index: 4,
      imageUrl:
          'https://images.unsplash.com/photo-1546833998-877b37c2e5c6?w=600&q=80',
    ),
    _MenuItemData(
      title: 'CHICKEN\nTIKKA',
      price: '700',
      index: 5,
      imageUrl:
          'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final padding = ResponsiveHelper.getResponsivePadding(context);

    return Container(
      padding: padding,
      color: const Color(0xFF2D1B00),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    _buildMenuHeader(context),
                    const SizedBox(height: 20),
                    _buildViewAllButton(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildMenuHeader(context), _buildViewAllButton()],
                ),

          SizedBox(height: isMobile ? 40 : (isTablet ? 60 : 80)),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
            mainAxisSpacing: isMobile ? 20 : 30,
            crossAxisSpacing: isMobile ? 20 : 30,
            childAspectRatio: isMobile ? 1.2 : (isTablet ? 0.9 : 0.85),
            children: _menuItems
                .map((item) => _ResponsiveMenuCard(data: item))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuHeader(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'SIGNATURE',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 32 : (isTablet ? 45 : 60),
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1,
          ),
        ),
        Stack(
          children: [
            Text(
              'DISHES',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
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
      ],
    );
  }

  Widget _buildViewAllButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF6B35), width: 2),
      ),
      child: const Text(
        'VIEW ALL →',
        style: TextStyle(
          color: Color(0xFFFF6B35),
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _MenuItemData {
  final String title;
  final String price;
  final int index;
  final String imageUrl;

  const _MenuItemData({
    required this.title,
    required this.price,
    required this.index,
    required this.imageUrl,
  });
}

class _ResponsiveMenuCard extends StatefulWidget {
  final _MenuItemData data;

  const _ResponsiveMenuCard({required this.data});

  @override
  State<_ResponsiveMenuCard> createState() => _ResponsiveMenuCardState();
}

class _ResponsiveMenuCardState extends State<_ResponsiveMenuCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered && !isMobile ? -10.0 : 0.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHovered ? const Color(0xFFFF6B35) : Colors.white24,
            width: 2,
          ),
          color: _isHovered ? const Color(0xFF3D2B10) : Colors.transparent,
          borderRadius: BorderRadius.circular(isMobile ? 15 : 0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 15 : 0),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: Text(
                  '0${widget.data.index + 1}',
                  style: TextStyle(
                    fontSize: isMobile ? 40 : 80,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              Positioned.fill(
                child: Image.network(
                  widget.data.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFF3D2B10),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF6B35),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF3D2B10),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant_rounded,
                        color: Color(0xFFFF6B35),
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(isMobile ? 20 : 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(isMobile ? 8 : 12),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.restaurant_rounded,
                          color: Colors.white,
                          size: isMobile ? 20 : 30,
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 15),
                      Text(
                        widget.data.title,
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -1,
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RS. ${widget.data.price}',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 20,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFFF6B35),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(isMobile ? 6 : 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: isMobile ? 16 : 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}