import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class VoiceInputButton extends StatefulWidget {
  final bool isListening;
  final VoidCallback onPressed;

  const VoiceInputButton({
    required this.isListening,
    required this.onPressed,
    super.key,
  });

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isListening) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(VoiceInputButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening && !oldWidget.isListening) {
      _animationController.repeat(reverse: true);
    } else if (!widget.isListening && oldWidget.isListening) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: widget.isListening
                  ? AppColors.accent
                  : AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                widget.isListening ? Icons.stop : Icons.mic,
                color: widget.isListening
                    ? Colors.white
                    : AppColors.primary,
              ),
              onPressed: widget.onPressed,
              tooltip: widget.isListening
                  ? 'Stop recording'
                  : 'Start voice input',
            ),
          ),
        );
      },
    );
  }
}
