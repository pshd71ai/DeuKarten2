import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deu_karten/core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        'DeuKarten',
                        style: AppTypography.displayLarge,
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: AppCard(
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: AppColors.secondary,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '5 Days',
                            style: AppTypography.headline,
                          ),
                          Text(
                            'Streak',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppCard(
                      child: Column(
                        children: [
                          Icon(
                            Icons.style_outlined,
                            color: AppColors.primary,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '127',
                            style: AppTypography.headline,
                          ),
                          Text(
                            'Cards Learned',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Feature Grid
              Text(
                'Features',
                style: AppTypography.headline,
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildFeatureCard(
                    icon: Icons.style,
                    title: 'Flashcards',
                    color: AppColors.primary,
                    onTap: () => context.push('/cards'),
                  ),
                  _buildFeatureCard(
                    icon: Icons.quiz,
                    title: 'Tests',
                    color: AppColors.secondary,
                    onTap: () => context.push('/tests'),
                  ),
                  _buildFeatureCard(
                    icon: Icons.bar_chart,
                    title: 'Statistics',
                    color: AppColors.info,
                    onTap: () => context.push('/statistics'),
                  ),
                  _buildFeatureCard(
                    icon: Icons.psychology,
                    title: 'AI Teacher',
                    color: AppColors.accent,
                    onTap: () => context.push('/ki-teacher'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.button,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
