import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../features/cards/providers/session_provider.dart';
import '../../features/cards/providers/cards_providers.dart';
import '../../features/cards/widgets/session_views.dart';

class SessionResultScreen extends ConsumerWidget {
  const SessionResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistoryAsync = ref.watch(sessionHistoryProvider);

    final session = sessionHistoryAsync.when(
      data: (history) => history.isNotEmpty ? history.last : null,
      loading: () => null,
      error: (_, __) => null,
    );

    if (session == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 64,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Keine Session-Daten gefunden',
                  style: AppTypography.section,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/karten'),
                  child: const Text('Zurück zu den Decks'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final correctAnswers = session.correctAnswers ?? 0;
    final cardsStudied = session.cardsStudied ?? 0;
    final xpEarned = session.xpEarned ?? 0;
    final toLearn = cardsStudied - correctAnswers;
    final accuracy =
    cardsStudied > 0 ? ((correctAnswers / cardsStudied) * 100).round() : 0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  size: 72,
                  color: AppColors.success,
                )
                    .animate()
                    .scale(duration: 500.ms, curve: Curves.elasticOut)
                    .then()
                    .shake(duration: 400.ms),
              ),

              const SizedBox(height: 20),

              Text(
                'Session beendet!',
                style: AppTypography.title,
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 8),

              Text(
                'Gut gemacht! Hier ist deine Zusammenfassung:',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

              const SizedBox(height: 24),

              _buildStatCard(
                icon: Icons.check_circle,
                label: 'Richtig',
                value: '$correctAnswers',
                color: AppColors.success,
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 300.ms)
                  .slideX(begin: -0.2, end: 0),

              const SizedBox(height: 12),

              _buildStatCard(
                icon: Icons.cancel,
                label: 'Zu lernen',
                value: '$toLearn',
                color: AppColors.error,
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 300.ms)
                  .slideX(begin: -0.2, end: 0),

              const SizedBox(height: 12),

              _buildStatCard(
                icon: Icons.star,
                label: 'XP verdient',
                value: '+$xpEarned',
                color: AppColors.xp,
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 300.ms)
                  .slideX(begin: -0.2, end: 0),

              const SizedBox(height: 12),

              _buildStatCard(
                icon: Icons.percent,
                label: 'Genauigkeit',
                value: '$accuracy%',
                color: AppColors.primary,
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 300.ms)
                  .slideX(begin: -0.2, end: 0),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () {
                  ref.read(currentCardIndexProvider.notifier).state = 0;
                  context.go('/home');
                },
                icon: const Icon(Icons.home),
                label: const Text('Zurück zur Startseite'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms, duration: 300.ms),

              const SizedBox(height: 12),

              TextButton.icon(
                onPressed: () {
                  ref.read(currentCardIndexProvider.notifier).state = 0;
                  context.go('/karten');
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Weiter lernen'),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ).animate().fadeIn(delay: 700.ms, duration: 300.ms),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.section.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}