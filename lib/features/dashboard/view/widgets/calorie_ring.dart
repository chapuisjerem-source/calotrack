import 'dart:math' as math;

import 'package:flutter/material.dart';

class CalorieRing extends StatelessWidget {
  final int consumed;
  final int goal;
  final double size;

  const CalorieRing({
    super.key,
    required this.consumed,
    required this.goal,
    this.size = 220,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = goal == 0 ? 0.0 : (consumed / goal).clamp(0.0, 1.5);
    final remaining = goal - consumed;
    final primary = Theme.of(context).colorScheme.primary;
    final track = Colors.grey.shade200;
    final over = ratio > 1.0;

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: ratio),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (_, value, __) {
          return CustomPaint(
            painter: _RingPainter(
              ratio: value,
              color: over ? Colors.redAccent : primary,
              trackColor: track,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$consumed',
                    style: TextStyle(
                      fontSize: size * 0.18,
                      fontWeight: FontWeight.bold,
                      color: over ? Colors.redAccent : primary,
                    ),
                  ),
                  Text('/ $goal kcal',
                      style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(
                    remaining >= 0
                        ? 'Il reste $remaining kcal'
                        : 'Dépassement de ${-remaining} kcal',
                    style: TextStyle(
                      fontSize: 12,
                      color: remaining >= 0 ? Colors.grey.shade700 : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double ratio;
  final Color color;
  final Color trackColor;
  _RingPainter({required this.ratio, required this.color, required this.trackColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 14;
    final stroke = 14.0;

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = trackColor;

    final fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;

    canvas.drawCircle(center, radius, trackPaint);

    final sweep = (ratio.clamp(0.0, 1.0)) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweep,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.ratio != ratio || old.color != color;
}
