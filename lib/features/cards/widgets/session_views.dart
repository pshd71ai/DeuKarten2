import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SessionLoadingView extends StatelessWidget {
  const SessionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Session wird geladen...',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const SessionErrorView({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Fehler beim Laden',
                style: AppTypography.section,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (onRetry != null)
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Erneut versuchen'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionEmptyView extends StatelessWidget {
  final VoidCallback? onBack;

  const SessionEmptyView({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: AppColors.textTertiary,
              )
                  .animate()
                  .scale(duration: 300.ms, curve: Curves.easeOut)
                  .then()
                  .shake(duration: 400.ms),
              const SizedBox(height: 24),
              Text(
                'Keine Karten verfügbar',
                style: AppTypography.section,
              ),
              const SizedBox(height: 8),
              Text(
                'Dieses Deck enthält keine Karten zum Lernen.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (onBack != null)
                ElevatedButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Zurück zu den Decks'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionCompletedView extends StatelessWidget {
  final VoidCallback? onFinish;

  const SessionCompletedView({
    super.key,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: AppColors.success,
              )
                  .animate()
                  .scale(duration: 300.ms, curve: Curves.elasticOut)
                  .then()
                  .shake(duration: 400.ms),
              const SizedBox(height: 24),
              Text(
                'Session abgeschlossen!',
                style: AppTypography.title,
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
              Text(
                'Du hast alle Karten bearbeitet.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (onFinish != null)
                ElevatedButton.icon(
                  onPressed: onFinish,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Ergebnisse ansehen'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 300.ms)
                    .slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
