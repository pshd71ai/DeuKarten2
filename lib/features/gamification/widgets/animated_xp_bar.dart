import 'dart:math';

import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';

class AnimatedXpBar extends StatefulWidget {
  final int currentXp;
  final int maxXp;
  final int level;
  final double height;

  const AnimatedXpBar({
    super.key,
    required this.currentXp,
    required this.maxXp,
    required this.level,
    this.height = 12,
  });

  @override
  State<AnimatedXpBar> createState() => _AnimatedXpBarState();
}

class _AnimatedXpBarState extends State<AnimatedXpBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  int _displayedXp = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final progress = widget.currentXp / widget.maxXp;
    _progressAnimation = Tween<double>(begin: 0, end: progress).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
    _animateXpNumber();
  }

  void _animateXpNumber() async {
    final steps = 20;
    final stepSize = widget.currentXp ~/ steps;

    for (int i = 0; i <= steps; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        setState(() {
          _displayedXp = min(i * stepSize, widget.currentXp);
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.xp,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Level ${widget.level}',
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              '$_displayedXp / ${widget.maxXp} XP',
              style: AppTypography.caption,
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.height / 2),
          child: Stack(
            children: [
              // Background
              Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: AppColors.xp.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(widget.height / 2),
                ),
              ),
              // Animated progress
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return FractionallySizedBox(
                    widthFactor: _progressAnimation.value,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.xp,
                            AppColors.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(widget.height / 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.xp.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Shimmer effect
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment(
                            -1 + (_controller.value * 2),
                            0,
                          ),
                          end: Alignment(
                            -0.5 + (_controller.value * 2),
                            0,
                          ),
                          colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0),
                          ],
                        ).createShader(bounds);
                      },
                      child: Container(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
