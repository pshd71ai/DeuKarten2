import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/core/database/seed_data.dart';
import 'package:deu_karten/features/profile/repositories/profile_repository.dart';

class MigrationService {
  final AppDatabase _db;
  final ProfileRepository _profileRepo;
  final DatabaseSeeder _seeder;

  MigrationService(this._db, this._profileRepo) : _seeder = DatabaseSeeder(_db);

  /// Migrate data from SharedPreferences to Drift database
  Future<void> migrateFromSharedPreferences() async {
    // 1. Seed mock data if database is empty
    await _seeder.seedAll();

    // 2. Migrate user profile if it exists in SharedPreferences
    await _migrateUserProfile();

    // 3. Migrate session history if it exists
    await _migrateSessionHistory();

    // 4. Migrate statistics if they exist
    await _migrateStatistics();
  }

  Future<void> _migrateUserProfile() async {
    try {
      final profile = await _profileRepo.getUserProfile();
      if (profile != null) {
        // Check if profile already exists in database
        final existing = await (_db.select(userProfiles)
              ..where((tbl) => tbl.id.equals(profile.id)))
            .getSingleOrNull();

        if (existing == null) {
          // Insert profile into database
          await _db.into(userProfiles).insert(
                userProfileToData(profile),
              );
        }
      }
    } catch (e) {
      // Log error but don't fail migration
      print('Error migrating user profile: $e');
    }
  }

  Future<void> _migrateSessionHistory() async {
    try {
      // Get session history from profile repo (which reads from SharedPreferences)
      // This would need to be implemented in ProfileRepository
      // For now, we'll just seed the database with empty session history
      // The actual migration would look like:
      // final history = await _profileRepo.getSessionHistory();
      // for (final session in history) {
      //   await _db.into(learningSessions).insert(learningSessionToData(session));
      // }
    } catch (e) {
      print('Error migrating session history: $e');
    }
  }

  Future<void> _migrateStatistics() async {
    try {
      // Get statistics from profile repo (which reads from SharedPreferences)
      // This would need to be implemented in ProfileRepository
      // For now, we'll just seed the database with empty statistics
      // The actual migration would look like:
      // final stats = await _profileRepo.getDailyStatistics();
      // for (final stat in stats) {
      //   await _db.into(statistics).insert(statisticsToData(stat));
      // }
    } catch (e) {
      print('Error migrating statistics: $e');
    }
  }

  /// Check if migration is needed
  Future<bool> needsMigration() async {
    final decks = await _db.getAllDecks();
    return decks.isEmpty;
  }

  /// Perform initial setup including seeding
  Future<void> performInitialSetup() async {
    if (await needsMigration()) {
      await _seeder.seedAll();
    }
  }
}
