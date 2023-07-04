import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';

class CreditScoreArc extends CustomPainter {
  final double creditScore;
  final double startAngle;
  final double sweepAngle;
  final double strokeWidth;
  final Color baseColor;
  final Color indicatorColor;

  CreditScoreArc({
    required this.creditScore,
    required this.startAngle,
    required this.sweepAngle,
    required this.strokeWidth,
    required this.baseColor,
    required this.indicatorColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double radius = (size.width - strokeWidth) / 2;

    // Draw the base arc
    final Paint basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerX), radius: radius),
      startAngle,
      sweepAngle,
      false,
      basePaint,
    );

    // Draw the indicator arc
    final Paint indicatorPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = indicatorColor;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerX), radius: radius),
      startAngle,
      creditScore * sweepAngle / 900,
      false,
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CreditScoreWidget extends StatefulWidget {
  final double creditScore;

  const CreditScoreWidget({super.key, required this.creditScore});

  @override
  _CreditScoreWidgetState createState() => _CreditScoreWidgetState();
}

class _CreditScoreWidgetState extends State<CreditScoreWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.creditScore).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(CreditScoreWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animation = Tween<double>(
      begin: oldWidget.creditScore,
      end: widget.creditScore,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: CreditScoreArc(
              creditScore: _animation.value,
              startAngle: -math.pi / 1,
              sweepAngle: math.pi / 1,
              strokeWidth: 10.0,
              baseColor: Colors.grey.shade400,
              indicatorColor: _animation.value <= 579
                  ? Colors.pinkAccent
                  : _animation.value <= 669
                      ? Colors.purpleAccent
                      : _animation.value <= 739
                          ? Colors.deepPurpleAccent
                          : _animation.value <= 799
                              ? Colors.lightBlueAccent
                              : _animation.value <= 900
                                  ? Colors.blueAccent
                                  : Colors.redAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _animation.value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 Text(
                    _animation.value <= 579
                        ? "Poor"
                        : _animation.value <= 669
                        ? "Fair"
                        : _animation.value <= 739
                        ? "Good"
                        : _animation.value <= 799
                        ? "Very Good"
                        : _animation.value <= 900
                        ? "Exceptional"
                        : "Credit Score",
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
