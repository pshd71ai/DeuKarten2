import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/theme.dart';
import 'package:deu_karten/core/widgets/widgets.dart';

class DesignSystemPreview extends StatelessWidget {
  const DesignSystemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Preview'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography
            _buildSection('Typography'),
            Text('Title (28pt)', style: AppTypography.title),
            const SizedBox(height: 8),
            Text('Section (22pt)', style: AppTypography.section),
            const SizedBox(height: 8),
            Text('Card Title (18pt)', style: AppTypography.cardTitle),
            const SizedBox(height: 8),
            Text('Body Large (16pt)', style: AppTypography.bodyLarge),
            const SizedBox(height: 8),
            Text('Body (14pt)', style: AppTypography.body),
            const SizedBox(height: 8),
            Text('Caption (12pt)', style: AppTypography.caption),
            const SizedBox(height: 8),
            Text('German Word (32pt)', style: AppTypography.germanWord),
            const SizedBox(height: 8),
            Text('Translation (18pt)', style: AppTypography.translation),
            const SizedBox(height: 24),

            // Buttons
            _buildSection('Buttons'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                AppButton(
                  text: 'Primary',
                  onPressed: () {},
                  icon: Icons.check,
                ),
                AppButton(
                  text: 'Secondary',
                  onPressed: () {},
                  type: ButtonType.secondary,
                ),
                AppButton(
                  text: 'Outline',
                  onPressed: () {},
                  type: ButtonType.outline,
                ),
                AppButton(
                  text: 'Text',
                  onPressed: () {},
                  type: ButtonType.text,
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
            const SizedBox(height: 24),

            // Cards
            _buildSection('Cards'),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Title', style: AppTypography.cardTitle),
                  const SizedBox(height: 8),
                  Text('This is a sample card content with body text.',
                      style: AppTypography.body),
                ],
              ),
            ),
            const SizedBox(height: 12),
            AppCard(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.touch_app, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Clickable Card', style: AppTypography.cardTitle),
                        Text('Tap to interact', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Gamification
            _buildSection('Gamification'),
            Row(
              children: [
                const StreakIndicator(streak: 7),
                const SizedBox(width: 16),
                const StreakIndicator(streak: 15, showLabel: false),
                const SizedBox(width: 16),
                const XpIndicator(xp: 1250),
              ],
            ),
            const SizedBox(height: 16),
            const XpIndicator(
              xp: 750,
              showProgress: true,
              nextLevelXp: 1000,
            ),
            const SizedBox(height: 24),

            // Progress Bar
            _buildSection('Progress Bar'),
            const AppProgressBar(progress: 0.3),
            const SizedBox(height: 8),
            const AppProgressBar(progress: 0.6),
            const SizedBox(height: 8),
            const AppProgressBar(progress: 0.9, progressColor: AppColors.success),
            const SizedBox(height: 8),
            AppProgressBar(
              progress: 0.5,
              progressColor: AppColors.streak,
              backgroundColor: AppColors.streak.withOpacity(0.2),
            ),
            const SizedBox(height: 24),

            // Learning Mode Cards
            _buildSection('Learning Mode Cards'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                LearningModeCard(
                  title: 'Karten lernen',
                  subtitle: '250 Karten',
                  icon: Icons.style,
                  color: AppColors.primary,
                  onTap: () {},
                ),
                LearningModeCard(
                  title: 'Sätze bauen',
                  subtitle: '50 Übungen',
                  icon: Icons.format_quote,
                  color: AppColors.secondary,
                  onTap: () {},
                ),
                LearningModeCard(
                  title: 'Hören',
                  subtitle: '30 Audio',
                  icon: Icons.headphones,
                  color: AppColors.accent,
                  onTap: () {},
                ),
                LearningModeCard(
                  title: 'Sprechen',
                  subtitle: '20 Übungen',
                  icon: Icons.mic,
                  color: AppColors.success,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Colors
            _buildSection('Color Palette'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildColorBox('Primary', AppColors.primary),
                _buildColorBox('Primary Light', AppColors.primaryLight),
                _buildColorBox('Primary Dark', AppColors.primaryDark),
                _buildColorBox('Secondary', AppColors.secondary),
                _buildColorBox('Secondary Light', AppColors.secondaryLight),
                _buildColorBox('Accent', AppColors.accent),
                _buildColorBox('Accent Light', AppColors.accentLight),
                _buildColorBox('Success', AppColors.success),
                _buildColorBox('Warning', AppColors.warning),
                _buildColorBox('Error', AppColors.error),
                _buildColorBox('Streak', AppColors.streak),
                _buildColorBox('XP', AppColors.xp),
              ],
            ),
            const SizedBox(height: 24),

            // Text Colors
            _buildSection('Text Colors'),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: AppColors.background,
                    child: Column(
                      children: [
                        Text('Primary', style: AppTypography.body),
                        Text('Secondary', style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
                        Text('Tertiary', style: AppTypography.body.copyWith(color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Text(
        title,
        style: AppTypography.section,
      ),
    );
  }

  Widget _buildColorBox(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.textTertiary),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 60,
          child: Text(
            name,
            style: AppTypography.caption,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
