import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);
    final statsAsync = ref.watch(userStatisticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userProfileProvider);
          ref.invalidate(userStatisticsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildProfileHeader(profileAsync),
              const SizedBox(height: 16),
              _buildStatisticsOverview(statsAsync),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildSettingsSections(context),
              const SizedBox(height: 32),
              _buildAppVersion(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AsyncValue<UserProfile?> profileAsync) {
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return _buildCreateProfilePrompt();
        }
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: profile.avatarUrl != null
                    ? NetworkImage(profile.avatarUrl!)
                    : null,
                child: profile.avatarUrl == null
                    ? Text(
                        profile.name.isNotEmpty ? profile.name.substring(0, 1).toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 36,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Hallo, ${profile.name}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Mitglied seit ${_formatDate(profile.joinedDate)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.xp,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      'Level ${profile.learningPrefs.currentLevel}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Container(
        height: 250,
        padding: const EdgeInsets.all(24),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Container(
        height: 200,
        padding: const EdgeInsets.all(24),
        child: Center(child: Text('Fehler: $e')),
      ),
    );
  }

  Widget _buildCreateProfilePrompt() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text(
            'Willkommen bei DeuKarten!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Erstelle dein Profil, um zu beginnen',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
            ),
            onPressed: () => _showCreateProfileDialog(context),
            child: const Text('Profil erstellen'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsOverview(AsyncValue<UserStatistics> statsAsync) {
    return statsAsync.when(
      data: (stats) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deine Statistik', style: AppTypography.section),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatItem(
                    icon: Icons.style,
                    value: '${stats.totalCardsLearned}',
                    label: 'Karten',
                  ),
                  _buildStatItem(
                    icon: Icons.local_fire_department,
                    value: '${stats.currentStreak}',
                    label: 'Tage Streak',
                  ),
                  _buildStatItem(
                    icon: Icons.access_time,
                    value: stats.totalStudyTimeMinutes >= 60 
                        ? '${stats.totalStudyTimeMinutes ~/ 60}h' 
                        : '${stats.totalStudyTimeMinutes}m',
                    label: 'Gelernt',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: stats.averageAccuracy.clamp(0.0, 1.0),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durchschnittliche Genauigkeit', style: AppTypography.caption),
                  Text(
                    '${(stats.averageAccuracy * 100).toInt()}%',
                    style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.download,
              label: 'Export',
              onTap: () => _showExportDialog(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.upload,
              label: 'Import',
              onTap: () => _showImportDialog(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.share,
              label: 'Teilen',
              onTap: () => _shareProgress(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSections(BuildContext context) {
    final profile = ref.watch(userProfileProvider).valueOrNull;
    
    return Column(
      children: [
        _buildSettingsSection(
          title: 'Lernen',
          items: [
            SettingsItem(
              icon: Icons.school,
              title: 'Tägliches Ziel',
              subtitle: profile != null ? '${profile.learningPrefs.dailyGoal} Karten pro Tag' : '20 Karten pro Tag',
              onTap: () => _showDailyGoalDialog(context),
            ),
            SettingsItem(
              icon: Icons.trending_up,
              title: 'Aktuelles Niveau',
              subtitle: profile != null ? _getLevelDescription(profile.learningPrefs.currentLevel) : 'A1 - Anfänger',
              onTap: () => _showLevelDialog(context),
            ),
            SettingsItem(
              icon: Icons.notifications,
              title: 'Erinnerungen',
              subtitle: profile != null && profile.settings.dailyReminder 
                  ? 'Täglich um ${profile.settings.reminderTime}' 
                  : 'Deaktiviert',
              onTap: () => _showReminderDialog(context),
            ),
          ],
        ),
        _buildSettingsSection(
          title: 'KI-Lehrer',
          items: [
            SettingsItem(
              icon: Icons.smart_toy,
              title: 'KI-Einstellungen',
              subtitle: 'Persönlichkeit & Stimme',
              onTap: () => _showAISettings(context),
            ),
            SettingsItem(
              icon: Icons.record_voice_over,
              title: 'Sprachausgabe',
              subtitle: 'Automatisch abspielen',
              trailing: Switch(
                value: profile?.learningPrefs.autoPlayAudio ?? true,
                onChanged: (v) => ref.read(userProfileProvider.notifier).setAutoPlayAudio(v),
                activeColor: AppColors.primary,
              ),
            ),
          ],
        ),
        _buildSettingsSection(
          title: 'App',
          items: [
            SettingsItem(
              icon: Icons.palette,
              title: 'Erscheinungsbild',
              subtitle: profile?.settings.darkMode == true ? 'Dunkel' : 'Hell',
              onTap: () => _showThemeDialog(context),
            ),
            SettingsItem(
              icon: Icons.volume_up,
              title: 'Sound & Haptik',
              subtitle: 'Effekte aktivieren',
              onTap: () => _showSoundSettings(context),
            ),
            SettingsItem(
              icon: Icons.language,
              title: 'Sprache',
              subtitle: _getLanguageDescription(profile?.settings.language ?? 'de'),
              onTap: () => _showLanguageDialog(context),
            ),
          ],
        ),
        _buildSettingsSection(
          title: 'Daten',
          items: [
            SettingsItem(
              icon: Icons.delete_outline,
              title: 'Alle Daten löschen',
              subtitle: 'Nicht rückgängig zu machen',
              isDestructive: true,
              onTap: () => _showClearDataDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<SettingsItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: AppTypography.section.copyWith(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(item.icon, color: item.isDestructive ? AppColors.error : AppColors.primary),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: item.isDestructive ? AppColors.error : null,
                      ),
                    ),
                    subtitle: item.subtitle != null
                        ? Text(item.subtitle!, style: AppTypography.caption)
                        : null,
                    trailing: item.trailing ??
                        Icon(Icons.chevron_right, color: AppColors.textTertiary),
                    onTap: item.onTap,
                  ),
                  if (index < items.length - 1)
                    const Divider(height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAppVersion() {
    return Column(
      children: [
        Text(
          'DeuKarten v1.0.0',
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _getLevelDescription(String level) {
    switch (level) {
      case 'A1':
        return 'A1 - Anfänger';
      case 'A2':
        return 'A2 - Grundlagen';
      case 'B1':
        return 'B1 - Mittelstufe';
      case 'B2':
        return 'B2 - Obere Mittelstufe';
      case 'C1':
        return 'C1 - Fortgeschritten';
      case 'C2':
        return 'C2 - Meister';
      default:
        return '$level - Unbekannt';
    }
  }

  String _getLanguageDescription(String code) {
    switch (code) {
      case 'de':
        return 'Deutsch';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      default:
        return code;
    }
  }

  void _showSettings(BuildContext context) {
    // Could navigate to detailed settings
  }

  void _showCreateProfileDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profil erstellen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Dein Name',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-Mail (optional)',
                hintText: 'deine@email.de',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                ref.read(userProfileProvider.notifier).createProfile(
                  name: nameController.text.trim(),
                  email: emailController.text.trim().isNotEmpty 
                      ? emailController.text.trim() 
                      : null,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Erstellen'),
          ),
        ],
      ),
    );
  }

  Future<void> _showExportDialog(BuildContext context) async {
    try {
      final data = await ref.read(userProfileProvider.notifier).exportData();
      
      if (!context.mounted) return;
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Daten exportieren'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deine Lernfortschritte werden als JSON-Datei exportiert. '
                    'Du kannst diese Datei später importieren oder auf einem anderen Gerät verwenden.',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SelectableText(
                      data.length > 500 ? '${data.substring(0, 500)}...' : data,
                      style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                Share.share(data, subject: 'DeuKarten Backup');
                Navigator.pop(context);
              },
              child: const Text('Teilen'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export fehlgeschlagen: $e')),
      );
    }
  }

  Future<void> _showImportDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daten importieren'),
        content: const Text(
          'Achtung: Beim Import werden alle aktuellen Daten überschrieben. '
          'Stelle sicher, dass du ein Backup hast.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await _pickAndImportFile(context);
            },
            child: const Text('Datei wählen'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndImportFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonData = await file.readAsString();
        
        await ref.read(userProfileProvider.notifier).importData(jsonData);
        
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Daten erfolgreich importiert!')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Import fehlgeschlagen: $e')),
      );
    }
  }

  void _shareProgress(BuildContext context) {
    final stats = ref.read(userStatisticsProvider).valueOrNull;
    
    String shareText = 'Ich lerne Deutsch mit DeuKarten! 🔥\n';
    
    if (stats != null) {
      shareText += '🔥 Aktueller Streak: ${stats.currentStreak} Tage\n';
      shareText += '📚 Gelernte Karten: ${stats.totalCardsLearned}\n';
      shareText += '⭐ Level: ${stats.currentLevel}\n';
    }
    
    shareText += '\n#DeuKarten #GermanLearning';
    
    Share.share(shareText);
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alle Daten löschen?'),
        content: const Text(
          'Diese Aktion kann nicht rückgängig gemacht werden. '
          'Alle deine Lernfortschritte, Statistiken und Einstellungen werden gelöscht.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () async {
              await ref.read(userProfileProvider.notifier).clearAllData();
              ref.invalidate(userStatisticsProvider);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Alle Daten wurden gelöscht')),
                );
              }
            },
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
  }

  void _showDailyGoalDialog(BuildContext context) {
    final profile = ref.read(userProfileProvider).valueOrNull;
    int selectedGoal = profile?.learningPrefs.dailyGoal ?? 20;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tägliches Lernziel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$selectedGoal Karten',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: selectedGoal.toDouble(),
                min: 5,
                max: 50,
                divisions: 9,
                label: '$selectedGoal',
                onChanged: (v) => setState(() => selectedGoal = v.round()),
              ),
              const Text(
                'Wie viele Karten möchtest du täglich lernen?',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProfileProvider.notifier).setDailyGoal(selectedGoal);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLevelDialog(BuildContext context) {
    final profile = ref.read(userProfileProvider).valueOrNull;
    String selectedLevel = profile?.learningPrefs.currentLevel ?? 'A1';
    final levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deutschniveau wählen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: levels.map((level) {
            return RadioListTile<String>(
              title: Text(_getLevelDescription(level)),
              value: level,
              groupValue: selectedLevel,
              onChanged: (v) {
                if (v != null) {
                  selectedLevel = v;
                  (context as Element).markNeedsBuild();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userProfileProvider.notifier).setCurrentLevel(selectedLevel);
              Navigator.pop(context);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }

  void _showReminderDialog(BuildContext context) {
    final profile = ref.read(userProfileProvider).valueOrNull;
    bool isEnabled = profile?.settings.dailyReminder ?? true;
    TimeOfDay selectedTime = TimeOfDay.now();

    // Parse existing reminder time
    if (profile?.settings.reminderTime != null) {
      final parts = profile!.settings.reminderTime.split(':');
      if (parts.length == 2) {
        selectedTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 9,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Lernerinnerung'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Tägliche Erinnerung'),
                value: isEnabled,
                onChanged: (v) => setState(() => isEnabled = v),
              ),
              const SizedBox(height: 16),
              if (isEnabled)
                ListTile(
                  title: const Text('Erinnerungszeit'),
                  trailing: TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (time != null) {
                        setState(() => selectedTime = time);
                      }
                    },
                    child: Text(
                      selectedTime.format(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProfileProvider.notifier).setDailyReminder(isEnabled);
                if (isEnabled) {
                  final timeStr = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                  ref.read(userProfileProvider.notifier).setReminderTime(timeStr);
                }
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAISettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AITeacherSettingsScreen()),
    );
  }

  void _showThemeDialog(BuildContext context) {
    final profile = ref.read(userProfileProvider).valueOrNull;
    bool isDarkMode = profile?.settings.darkMode ?? false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Erscheinungsbild'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: const Text('Hell'),
                value: false,
                groupValue: isDarkMode,
                onChanged: (v) => setState(() => isDarkMode = false),
              ),
              RadioListTile<bool>(
                title: const Text('Dunkel'),
                value: true,
                groupValue: isDarkMode,
                onChanged: (v) => setState(() => isDarkMode = true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProfileProvider.notifier).setDarkMode(isDarkMode);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSoundSettings(BuildContext context) {
    final profile = ref.read(userProfileProvider).valueOrNull;
    bool soundEffects = profile?.settings.soundEffects ?? true;
    bool hapticFeedback = profile?.settings.hapticFeedback ?? true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Sound & Haptik'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Soundeffekte'),
                value: soundEffects,
                onChanged: (v) => setState(() => soundEffects = v),
              ),
              SwitchListTile(
                title: const Text('Haptisches Feedback'),
                value: hapticFeedback,
                onChanged: (v) => setState(() => hapticFeedback = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProfileProvider.notifier).setSoundEffects(soundEffects);
                ref.read(userProfileProvider.notifier).setHapticFeedback(hapticFeedback);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final profile = ref.read(userProfileProvider).valueOrNull;
    String selectedLanguage = profile?.settings.language ?? 'de';
    final languages = {'de': 'Deutsch', 'en': 'English', 'es': 'Español', 'fr': 'Français'};

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sprache'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.entries.map((e) {
            return RadioListTile<String>(
              title: Text(e.value),
              value: e.key,
              groupValue: selectedLanguage,
              onChanged: (v) {
                if (v != null) {
                  selectedLanguage = v;
                  (context as Element).markNeedsBuild();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userProfileProvider.notifier).setLanguage(selectedLanguage);
              Navigator.pop(context);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;

  SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
  });
}

class AITeacherSettingsScreen extends ConsumerWidget {
  const AITeacherSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KI-Lehrer Einstellungen'),
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Bitte erstelle zuerst ein Profil'));
          }
          
          return ListView(
            children: [
              // Enable/Disable
              SwitchListTile(
                title: const Text('KI-Lehrer aktiviert'),
                subtitle: const Text('Aktiviere den KI-Lehrer Empfehlungen'),
                value: true,
                onChanged: (v) {},
              ),
              const Divider(),
              
              // Personality
              ListTile(
                title: const Text('Persönlichkeit'),
                subtitle: Text(_getPersonalityDescription('friendly')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showPersonalityDialog(context, ref),
              ),
              
              // TTS Speed
              ListTile(
                title: const Text('Sprechgeschwindigkeit'),
                subtitle: Text('${(0.7 * 100).toInt()}%'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showTtsSpeedDialog(context, ref),
              ),
              
              // TTS Voice
              ListTile(
                title: const Text('Stimmenoption'),
                subtitle: Text(_getVoiceDescription('female')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showVoiceDialog(context, ref),
              ),
              const Divider(),
              
              // Auto settings
              SwitchListTile(
                title: const Text('Grammatik automatisch erklären'),
                value: true,
                onChanged: (v) {},
              ),
              SwitchListTile(
                title: const Text('Sätze automatisch korrigieren'),
                value: true,
                onChanged: (v) {},
              ),
              SwitchListTile(
                title: const Text('Antworten automatisch vorlesen'),
                value: false,
                onChanged: (v) {},
              ),
              SwitchListTile(
                title: const Text('Vorschläge anzeigen'),
                value: true,
                onChanged: (v) {},
              ),
              SwitchListTile(
                title: const Text('Fehler verfolgen'),
                subtitle: const Text('Fehler für personalisierte Übungen speichern'),
                value: true,
                onChanged: (v) {},
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
      ),
    );
  }

  String _getPersonalityDescription(String personality) {
    switch (personality) {
      case 'friendly':
        return 'Freundlich und ermutigend';
      case 'strict':
        return 'Streng und direkt';
      case 'encouraging':
        return 'Motivierend und unterstützend';
      default:
        return personality;
    }
  }

  String _getVoiceDescription(String voice) {
    switch (voice) {
      case 'female':
        return 'Weibliche Stimme';
      case 'male':
        return 'Männliche Stimme';
      default:
        return voice;
    }
  }

  void _showPersonalityDialog(BuildContext context, WidgetRef ref) {
    final personalities = ['friendly', 'strict', 'encouraging'];
    final descriptions = {
      'friendly': 'Freundlich und ermutigend',
      'strict': 'Streng und direkt',
      'encouraging': 'Motivierend und unterstützend',
    };
    String selected = 'friendly';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Persönlichkeit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: personalities.map((p) {
              return RadioListTile<String>(
                title: Text(descriptions[p]!),
                value: p,
                groupValue: selected,
                onChanged: (v) => setState(() => selected = v!),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(aiTeacherSettingsProvider.notifier).setPersonality(selected);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTtsSpeedDialog(BuildContext context, WidgetRef ref) {
    double speed = 0.7;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Sprechgeschwindigkeit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(speed * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: speed,
                min: 0.5,
                max: 1.5,
                divisions: 10,
                label: '${(speed * 100).toInt()}%',
                onChanged: (v) => setState(() => speed = v),
              ),
              const Text(
                'Langsam ← → Schnell',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(aiTeacherSettingsProvider.notifier).setTtsSpeed(speed);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showVoiceDialog(BuildContext context, WidgetRef ref) {
    final voices = ['female', 'male'];
    String selected = 'female';
    final descriptions = {
      'female': 'Weibliche Stimme',
      'male': 'Männliche Stimme',
    };

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Stimme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: voices.map((v) {
              return RadioListTile<String>(
                title: Text(descriptions[v]!),
                value: v,
                groupValue: selected,
                onChanged: (val) => setState(() => selected = val!),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(aiTeacherSettingsProvider.notifier).setTtsVoice(selected);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
