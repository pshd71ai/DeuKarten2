import 'dart:math';
import 'package:flutter/material.dart';
import 'package:deu_karten/core/core.dart';

class AnimatedFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool isFlipped;
  final Duration duration;
  final VoidCallback? onFlip;
  final double height;
  final double width;

  const AnimatedFlipCard({
    super.key,
    required this.front,
    required this.back,
    this.isFlipped = false,
    this.duration = const Duration(milliseconds: 600),
    this.onFlip,
    this.height = 420,
    this.width = 320,
  });

  @override
  State<AnimatedFlipCard> createState() => _AnimatedFlipCardState();
}

class _AnimatedFlipCardState extends State<AnimatedFlipCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _isFrontVisible = !_isFrontVisible;
      }
    });

    if (widget.isFlipped) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFlipped != widget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    widget.onFlip?.call();
    if (_controller.isCompleted || _controller.velocity > 0) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(angle);

          // Show correct side based on rotation
          final isFront = angle < pi / 2;

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFront
                ? SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: widget.front,
                  )
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: widget.back,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

/// 3D Card flip with elevation and shadow
class FlipCard3D extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool isFlipped;
  final VoidCallback? onTap;

  const FlipCard3D({
    super.key,
    required this.front,
    required this.back,
    this.isFlipped = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: isFlipped ? 1 : 0,
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      builder: (context, value, child) {
        final angle = value * pi;
        final isFrontVisible = angle < pi / 2;

        return GestureDetector(
          onTap: onTap,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 0),
              child: isFrontVisible
                  ? _buildCard(front, isFront: true, elevation: 1 - value)
                  : Transform(
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: _buildCard(back,
                          isFront: false, elevation: value - 0.5),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(Widget child,
      {required bool isFront, required double elevation}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2 * elevation),
            blurRadius: 20 * elevation,
            offset: Offset(0, 10 * elevation),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: child,
      ),
    );
  }
}
