import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:deu_karten/core/theme/app_colors.dart';

class StreakCounter extends StatefulWidget {
  final int streak;
  final bool showLabel;
  final double size;
  final bool animate;

  const StreakCounter({
    super.key,
    required this.streak,
    this.showLabel = true,
    this.size = 32,
    this.animate = true,
  });

  @override
  State<StreakCounter> createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _fireController;
  late Animation<double> _fireScale;
  late Animation<double> _glowOpacity;

  @override
  void initState() {
    super.initState();

    _fireController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _fireScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _fireController,
        curve: Curves.easeInOut,
      ),
    );

    _glowOpacity = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(
        parent: _fireController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _fireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Fire icon with animation
        AnimatedBuilder(
          animation: _fireController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Glow effect
                Opacity(
                  opacity: widget.animate ? _glowOpacity.value : 0.5,
                  child: Container(
                    width: widget.size * 1.2,
                    height: widget.size * 1.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.streak.withOpacity(0.3),
                    ),
                  ),
                ),
                // Fire icon
                Transform.scale(
                  scale: widget.animate ? _fireScale.value : 1.0,
                  child: widget.animate && widget.streak > 0
                      ? Lottie.asset(
                          'assets/animations/streak_fire.json',
                          width: widget.size,
                          height: widget.size,
                          repeat: true,
                        )
                      : Icon(
                          widget.streak > 0
                              ? Icons.local_fire_department
                              : Icons.local_fire_department_outlined,
                          color: widget.streak > 0
                              ? AppColors.streak
                              : AppColors.textTertiary,
                          size: widget.size,
                        ),
                ),
              ],
            );
          },
        ),
        const SizedBox(width: 6),
        // Streak number
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCount(
              count: widget.streak,
              duration: const Duration(milliseconds: 1000),
              style: TextStyle(
                fontSize: widget.size * 0.625,
                fontWeight: FontWeight.bold,
                color: widget.streak > 0
                    ? AppColors.streak
                    : AppColors.textTertiary,
              ),
            ),
            if (widget.showLabel)
              Text(
                widget.streak == 1 ? 'Tag' : 'Tage',
                style: TextStyle(
                  fontSize: widget.size * 0.3125,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Animated number counter
class AnimatedCount extends StatefulWidget {
  final int count;
  final Duration duration;
  final TextStyle style;

  const AnimatedCount({
    super.key,
    required this.count,
    required this.duration,
    required this.style,
  });

  @override
  State<AnimatedCount> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends State<AnimatedCount>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: widget.count).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _animation = IntTween(begin: oldWidget.count, end: widget.count).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}',
          style: widget.style,
        );
      },
    );
  }
}
