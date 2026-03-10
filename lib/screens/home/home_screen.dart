import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';
import 'package:deu_karten/core/widgets/streak_indicator.dart';
import 'widgets/hero_learning_card.dart';
import 'widgets/daily_progress_section.dart';
import 'widgets/learning_modes_grid.dart';
import 'widgets/quick_stats_row.dart';
import 'widgets/recent_decks_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mock data for preview
  static const String userName = 'Peter';
  static const int currentStreak = 12;
  static const int cardsLearnedToday = 15;
  static const int dailyGoal = 20;
  static const int xpToday = 150;
  static const int totalCardsLearned = 450;
  static const double successRate = 78.5;
  static const int cardsReady = 25;
  static const bool hasOngoingSession = false;
  static const String? currentDeckName = null;
  static const int? remainingCards = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Card
            HeroLearningCard(
              hasOngoingSession: hasOngoingSession,
              cardsReady: cardsReady,
              currentDeckName: currentDeckName,
              remainingCards: remainingCards,
              onStart: () => context.push('/karten/session'),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0, duration: 600.ms),
            const SizedBox(height: 24),

            // 2. Daily Progress
            Text('Tagesfortschritt', style: AppTypography.section),
            const SizedBox(height: 12),
            DailyProgressSection(
              cardsLearnedToday: cardsLearnedToday,
              dailyGoal: dailyGoal,
              streak: currentStreak,
              xpToday: xpToday,
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 100.ms)
                .slideY(begin: 0.2, end: 0, duration: 500.ms),
            const SizedBox(height: 24),

            // 3. Quick Stats
            QuickStatsRow(
              totalCardsLearned: totalCardsLearned,
              currentStreak: currentStreak,
              successRate: successRate,
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 200.ms)
                .slideY(begin: 0.2, end: 0, duration: 500.ms),
            const SizedBox(height: 24),

            // 4. Learning Modes
            Text('Lernmodi', style: AppTypography.section),
            const SizedBox(height: 12),
            LearningModesGrid(
              onKartenTap: () => context.push('/karten'),
              onSaetzeTap: () {
                // TODO: Navigate to sentence builder
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon: Sätze bauen')),
                );
              },
              onHoerenTap: () {
                // TODO: Navigate to listening
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon: Hören')),
                );
              },
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 300.ms)
                .slideY(begin: 0.2, end: 0, duration: 500.ms),
            const SizedBox(height: 24),

            // 5. Recent Decks
            Text('Kürzlich gelernt', style: AppTypography.section),
            const SizedBox(height: 12),
            const RecentDecksSection()
                .animate()
                .fadeIn(duration: 500.ms, delay: 400.ms)
                .slideY(begin: 0.2, end: 0, duration: 500.ms),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hallo, $userName 👋',
            style: AppTypography.section.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Heute lernen wir Deutsch',
            style: AppTypography.caption,
          ),
        ],
      ),
      actions: [
        // Streak indicator with fire icon
        const Center(
          child: StreakIndicator(streak: currentStreak, compact: true),
        ),
        const SizedBox(width: 8),
        // Notifications icon
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Open notifications
          },
        ),
        // Profile icon
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () => context.go('/profil'),
        ),
      ],
    );
  }
}
