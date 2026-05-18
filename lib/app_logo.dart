// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';


class BulbulLogo extends StatelessWidget {
  final double width;

  const BulbulLogo({super.key, this.width = 100});

  @override
  Widget build(BuildContext context) {
    // 16:7 aspect ratio — same as original logo
    final height = width * (7 / 16);
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _BulbulLogoPainter()),
    );
  }
}

// ── Color constants ──────────────────────────────────────────────
const Color _goldBright = Color(0xFFFFE066);
const Color _goldMid    = Color(0xFFD4A017);
const Color _goldDark   = Color(0xFF8B6914);
const Color _chrome     = Color(0xFFE8E8E8);
const Color _shadow     = Color(0xFF3A1F00);

class _BulbulLogoPainter extends CustomPainter {

  Shader _goldVertShader(Rect rect) => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_goldBright, _goldMid, _chrome, _goldMid, _goldDark],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  ).createShader(rect);

  Shader _goldHorizShader(Rect rect) => const LinearGradient(
    colors: [_goldDark, _goldMid, _goldBright, _goldMid, _goldDark],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  ).createShader(rect);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    _drawLeaves(canvas, w, h);
    _drawBird(canvas, w, h);
    _drawText(canvas, 'BULBUL', w, h, row: 0);
    _drawDivider(canvas, w, h);
    _drawText(canvas, 'HOTEL', w, h, row: 1);
  }

  // ── Gold text: shadow + stroke + fill + chrome shimmer ──────
  void _drawText(Canvas canvas, String text, double w, double h,
      {required int row}) {
    final isTop   = row == 0;
    final fontSize = isTop ? h * 0.40 : h * 0.35;
    final cy       = isTop ? h * 0.38 : h * 0.82;
    final rect     = Rect.fromCenter(
      center: Offset(w / 2, cy),
      width: w * 0.88,
      height: fontSize,
    );

    // Shadow
    _tp(canvas, text, Offset(w / 2 + 2, cy + 3), TextStyle(
      fontSize: fontSize, fontWeight: FontWeight.w900, fontFamily: 'Georgia',
      letterSpacing: fontSize * 0.05,
      color: _shadow.withOpacity(0.45),
    ));
    // Border stroke
    _tp(canvas, text, Offset(w / 2, cy), TextStyle(
      fontSize: fontSize, fontWeight: FontWeight.w900, fontFamily: 'Georgia',
      letterSpacing: fontSize * 0.05,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = fontSize * 0.045
        ..shader = _goldHorizShader(rect),
    ));
    // Gold fill
    _tp(canvas, text, Offset(w / 2, cy), TextStyle(
      fontSize: fontSize, fontWeight: FontWeight.w900, fontFamily: 'Georgia',
      letterSpacing: fontSize * 0.05,
      foreground: Paint()..shader = _goldVertShader(rect),
    ));
    // Chrome shimmer
    _tp(canvas, text, Offset(w / 2, cy), TextStyle(
      fontSize: fontSize, fontWeight: FontWeight.w900, fontFamily: 'Georgia',
      letterSpacing: fontSize * 0.05,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = fontSize * 0.012
        ..color = _chrome.withOpacity(0.45),
    ));
  }

  void _tp(Canvas canvas, String text, Offset center, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  // ── Bird silhouette ─────────────────────────────────────────
  void _drawBird(Canvas canvas, double w, double h) {
    final cx = w * 0.50;
    final cy = h * 0.10;
    final s  = w / 680;

    final bodyRect = Rect.fromCenter(
      center: Offset(cx, cy), width: 60 * s, height: 28 * s,
    );
    final goldFill   = Paint()..shader = _goldVertShader(bodyRect);
    final goldStroke = Paint()
      ..color = _goldDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2 * s;

    // Shadow
    canvas.drawOval(bodyRect.shift(Offset(2 * s, 3 * s)),
      Paint()..color = _shadow.withOpacity(0.35));

    // Body
    final body = Path()
      ..moveTo(cx - 24 * s, cy + 6  * s)
      ..quadraticBezierTo(cx - 8 * s, cy - 10 * s, cx + 8 * s, cy - 4 * s)
      ..quadraticBezierTo(cx + 24 * s, cy,          cx + 18 * s, cy + 10 * s)
      ..quadraticBezierTo(cx + 6  * s, cy + 13 * s, cx - 6  * s, cy + 10 * s)
      ..close();
    canvas.drawPath(body, goldFill);
    canvas.drawPath(body, goldStroke);

    // Tail
    final tail = Path()
      ..moveTo(cx - 24 * s, cy + 6  * s)
      ..lineTo(cx - 38 * s, cy)
      ..lineTo(cx - 30 * s, cy + 10 * s)
      ..lineTo(cx - 42 * s, cy + 8  * s)
      ..lineTo(cx - 28 * s, cy + 16 * s)
      ..close();
    canvas.drawPath(tail, Paint()..shader = _goldHorizShader(bodyRect));
    canvas.drawPath(tail, goldStroke);

    // Beak
    canvas.drawPath(
      Path()
        ..moveTo(cx + 18 * s, cy + 2 * s)
        ..lineTo(cx + 34 * s, cy + 5 * s)
        ..lineTo(cx + 18 * s, cy + 9 * s)
        ..close(),
      Paint()..color = _goldMid,
    );

    // Crest
    canvas.drawPath(
      Path()
        ..moveTo(cx + 4  * s, cy - 4  * s)
        ..quadraticBezierTo(cx + 8 * s, cy - 18 * s, cx + 12 * s, cy - 26 * s)
        ..quadraticBezierTo(cx + 16 * s, cy - 16 * s, cx + 10 * s, cy - 6  * s),
      Paint()
        ..color = _goldMid
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8 * s
        ..strokeCap = StrokeCap.round,
    );

    // Eye
    canvas.drawCircle(Offset(cx + 10 * s, cy + 2 * s), 2.5 * s,
      Paint()..color = _goldDark);
    canvas.drawCircle(Offset(cx + 9.5 * s, cy + 1.5 * s), 1 * s,
      Paint()..color = _chrome.withOpacity(0.5));

    // Wing line
    canvas.drawPath(
      Path()
        ..moveTo(cx - 8 * s, cy + 4 * s)
        ..quadraticBezierTo(cx + 4 * s, cy - 2 * s, cx + 14 * s, cy + 2 * s),
      Paint()
        ..color = _goldDark.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9 * s,
    );
  }

  // ── Decorative vines ────────────────────────────────────────
  void _drawLeaves(Canvas canvas, double w, double h) {
    final vp = Paint()
      ..color = _goldMid.withOpacity(0.88)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.002
      ..strokeCap = StrokeCap.round;
    final lp = Paint()..color = _goldMid.withOpacity(0.72);

    _vine(canvas, vp, lp,
      start: Offset(w * 0.10, h * 0.52), ctrl: Offset(w * 0.06, h * 0.32),
      end: Offset(w * 0.10, h * 0.12), leafCount: 3, leftSide: true,  scale: w * 0.018);

    _vine(canvas, vp, lp,
      start: Offset(w * 0.90, h * 0.52), ctrl: Offset(w * 0.94, h * 0.32),
      end: Offset(w * 0.90, h * 0.12), leafCount: 3, leftSide: false, scale: w * 0.018);

    _vine(canvas, vp..color = _goldMid.withOpacity(0.60), lp,
      start: Offset(w * 0.90, h * 0.88), ctrl: Offset(w * 0.94, h * 0.72),
      end: Offset(w * 0.88, h * 0.58), leafCount: 2, leftSide: false, scale: w * 0.014);
  }

  void _vine(Canvas canvas, Paint stroke, Paint fill, {
    required Offset start, required Offset ctrl, required Offset end,
    required int leafCount, required bool leftSide, required double scale,
  }) {
    canvas.drawPath(
      Path()..moveTo(start.dx, start.dy)
             ..quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy),
      stroke,
    );
    for (int i = 1; i <= leafCount; i++) {
      final t  = i / (leafCount + 1);
      final lx = _lerp(_lerp(start.dx, ctrl.dx, t), _lerp(ctrl.dx, end.dx, t), t);
      final ly = _lerp(_lerp(start.dy, ctrl.dy, t), _lerp(ctrl.dy, end.dy, t), t);
      _leaf(canvas, fill, stroke, Offset(lx, ly), leftSide, scale);
    }
  }

  void _leaf(Canvas canvas, Paint fill, Paint stroke,
      Offset pos, bool leftSide, double s) {
    final dir  = leftSide ? -1.0 : 1.0;
    final leaf = Path()
      ..moveTo(pos.dx, pos.dy)
      ..quadraticBezierTo(
        pos.dx + dir * s * 2.0, pos.dy - s * 1.6,
        pos.dx + dir * s * 0.3, pos.dy - s * 2.8,
      )
      ..quadraticBezierTo(
        pos.dx - dir * s * 1.2, pos.dy - s * 1.4,
        pos.dx, pos.dy,
      )..close();
    canvas.drawPath(leaf, fill);
    canvas.drawPath(leaf, stroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = _goldDark.withOpacity(0.5));
    canvas.drawLine(
      pos,
      Offset(pos.dx + dir * s * 0.3, pos.dy - s * 2.8),
      stroke..strokeWidth = 0.4,
    );
  }

  // ── Swirl divider ───────────────────────────────────────────
  void _drawDivider(Canvas canvas, double w, double h) {
    final mid = h * 0.565;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.15, mid)
        ..quadraticBezierTo(w * 0.28, mid - h * 0.03, w / 2, mid)
        ..quadraticBezierTo(w * 0.72, mid + h * 0.03, w * 0.85, mid),
      Paint()
        ..color = _goldMid.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.0015
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(Offset(w / 2, mid),           w * 0.007, Paint()..color = _goldMid.withOpacity(0.85));
    canvas.drawCircle(Offset(w / 2 - w * 0.04, mid), w * 0.004, Paint()..color = _goldMid.withOpacity(0.55));
    canvas.drawCircle(Offset(w / 2 + w * 0.04, mid), w * 0.004, Paint()..color = _goldMid.withOpacity(0.55));
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}