import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class VoiceWaveAnimation extends StatelessWidget {
  final bool isListening;
  final Color color;
  final double height;

  const VoiceWaveAnimation({
    super.key,
    required this.isListening,
    this.color = AppColors.primary,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    if (!isListening) return const SizedBox.shrink();

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return _buildWaveBar(index);
        }),
      ),
    );
  }

  Widget _buildWaveBar(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + index * 50),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 6,
      height: isListening ? 40 + (index % 3) * 10 : 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
