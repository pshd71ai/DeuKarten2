import 'dart:io';

import 'package:drift/drift.dart' as drift;

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'drift_database.dart';


class DatabaseDebugScreen extends StatefulWidget {
  const DatabaseDebugScreen({super.key});

  @override
  State<DatabaseDebugScreen> createState() => _DatabaseDebugScreenState();
}

class _DatabaseDebugScreenState extends State<DatabaseDebugScreen> {
  bool _loading = true;
  String _dbPath = '';
  bool _dbExists = false;
  int _dbSize = 0;
  String _error = '';

  Map<String, int> _counts = {};
  List<String> _tables = [];
  Map<String, List<Map<String, Object?>>> _tableColumns = {};
  Map<String, String> _tableSchemas = {};

  List<Map<String, Object?>> _sqlResults = [];
  String _lastSql = '';
  String _sqlError = '';

  final List<String> _sqlShortcuts = const [
    'select * from decks',
    'select * from word_cards limit 10',
    'select * from article_cards limit 10',
    'select * from sentence_cards limit 10',
    'select * from learning_sessions',
    'select * from user_profiles',
    'select * from statistics',
    'select count(*) as total from decks',
    'select count(*) as total from word_cards',
    "select name from sqlite_master where type='table'",
  ];

  @override
  void initState() {
    super.initState();
    _loadDebugInfo();
  }

  Future<File> _getDbFile() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    return File(p.join(dbFolder.path, 'deu_karten.db'));
  }

  Future<void> _loadDebugInfo() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final db = AppDatabase.instance;
      final file = await _getDbFile();

      final exists = await file.exists();
      int size = 0;

      if (exists) {
        final stat = await file.stat();
        size = stat.size;
      }

      final wordCardsCount =
      await db.select(db.wordCards).get().then((v) => v.length);
      final articleCardsCount =
      await db.select(db.articleCards).get().then((v) => v.length);
      final sentenceCardsCount =
      await db.select(db.sentenceCards).get().then((v) => v.length);
      final decksCount =
      await db.select(db.decks).get().then((v) => v.length);
      final sessionsCount =
      await db.select(db.learningSessions).get().then((v) => v.length);
      final profilesCount =
      await db.select(db.userProfiles).get().then((v) => v.length);
      final xpHistoryCount =
      await db.select(db.xpHistory).get().then((v) => v.length);
      final streakCount =
      await db.select(db.streakData).get().then((v) => v.length);
      final testsCount =
      await db.select(db.tests).get().then((v) => v.length);
      final testSessionsCount =
      await db.select(db.testSessions).get().then((v) => v.length);
      final statisticsCount =
      await db.select(db.statistics).get().then((v) => v.length);

      final tableRows = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;",
      ).get();

      final tables = tableRows.map((row) => row.read<String>('name')).toList();

      final Map<String, List<Map<String, Object?>>> tableColumns = {};
      final Map<String, String> tableSchemas = {};

      for (final table in tables) {
        final pragmaRows =
        await db.customSelect('PRAGMA table_info($table);').get();
        tableColumns[table] = pragmaRows.map((row) => row.data).toList();

        final schemaRows = await db.customSelect(
          "SELECT sql FROM sqlite_master WHERE type='table' AND name = ?",
          variables: [drift.Variable.withString(table)],
        ).get();

        tableSchemas[table] = schemaRows.isNotEmpty
            ? (schemaRows.first.data['sql']?.toString() ?? '')
            : '';
      }

      setState(() {
        _dbPath = file.path;
        _dbExists = exists;
        _dbSize = size;
        _counts = {
          'word_cards': wordCardsCount,
          'article_cards': articleCardsCount,
          'sentence_cards': sentenceCardsCount,
          'decks': decksCount,
          'learning_sessions': sessionsCount,
          'user_profiles': profilesCount,
          'xp_history': xpHistoryCount,
          'streak_data': streakCount,
          'tests': testsCount,
          'test_sessions': testSessionsCount,
          'statistics': statisticsCount,
        };
        _tables = tables;
        _tableColumns = tableColumns;
        _tableSchemas = tableSchemas;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _showSqlDialog() async {
    final controller = TextEditingController(
      text: _lastSql.isNotEmpty ? _lastSql : 'select * from decks',
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Run SQL Query'),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Only SELECT queries allowed...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final sql = controller.text.trim();
              Navigator.pop(context);
              await _runSql(sql);
            },
            child: const Text('Run'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSqlShortcutsDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SQL Shortcuts'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _sqlShortcuts.length,
            itemBuilder: (context, index) {
              final sql = _sqlShortcuts[index];
              return ListTile(
                title: SelectableText(sql),
                onTap: () async {
                  Navigator.pop(context);
                  await _runSql(sql);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _runSql(String sql) async {
    final normalized = sql.trim().toLowerCase();

    if (!normalized.startsWith('select')) {
      setState(() {
        _lastSql = sql;
        _sqlError = 'Only SELECT queries are allowed.';
        _sqlResults = [];
      });
      return;
    }

    try {
      final db = AppDatabase.instance;
      final rows = await db.customSelect(sql).get();

      setState(() {
        _lastSql = sql;
        _sqlError = '';
        _sqlResults = rows.map((row) => row.data).toList();
      });
    } catch (e) {
      setState(() {
        _lastSql = sql;
        _sqlError = e.toString();
        _sqlResults = [];
      });
    }
  }

  Future<void> _exportDbFile() async {
    try {
      final file = await _getDbFile();

      if (!await file.exists()) {
        _showSnackBar('Database file does not exist');
        return;
      }

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'DeuKarten database export',
          subject: 'deu_karten.db',
        ),
      );
    } catch (e) {
      _showSnackBar('Export failed: $e');
    }
  }

  Future<void> _clearDb() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Database?'),
        content: const Text(
          'This will delete all rows from all tables. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    ) ??
        false;

    if (!confirmed) return;

    try {
      final db = AppDatabase.instance;

      await db.transaction(() async {
        await db.delete(db.learningSessions).go();
        await db.delete(db.decks).go();
        await db.delete(db.sentenceCards).go();
        await db.delete(db.articleCards).go();
        await db.delete(db.wordCards).go();
        await db.delete(db.testSessions).go();
        await db.delete(db.tests).go();
        await db.delete(db.statistics).go();
        await db.delete(db.streakData).go();
        await db.delete(db.xpHistory).go();
        await db.delete(db.userProfiles).go();
      });

      _showSnackBar('Database cleared');
      await _loadDebugInfo();
    } catch (e) {
      _showSnackBar('Clear failed: $e');
    }
  }

  Future<void> _showSchemaDialog(String table) async {
    final schema = _tableSchemas[table] ?? '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Schema: $table'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SelectableText(
              schema.isEmpty ? 'No schema found' : schema,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Widget _buildCard(String title, Widget child) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSqlResults() {
    if (_lastSql.isEmpty && _sqlError.isEmpty) {
      return const Text('No query executed yet.');
    }

    if (_sqlError.isNotEmpty) {
      return SelectableText(
        'Error:\n$_sqlError',
        style: const TextStyle(color: Colors.red),
      );
    }

    if (_sqlResults.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText('Query:\n$_lastSql'),
          const SizedBox(height: 8),
          const Text('No rows returned.'),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText('Query:\n$_lastSql'),
        const SizedBox(height: 12),
        Text('Rows: ${_sqlResults.length}'),
        const SizedBox(height: 12),
        ..._sqlResults.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Row ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...row.entries.map(
                      (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: SelectableText('${e.key}: ${e.value}'),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElevatedButton.icon(
          onPressed: _showSqlDialog,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Run SQL'),
        ),
        ElevatedButton.icon(
          onPressed: _showSqlShortcutsDialog,
          icon: const Icon(Icons.bolt),
          label: const Text('Shortcuts'),
        ),
        ElevatedButton.icon(
          onPressed: _exportDbFile,
          icon: const Icon(Icons.upload_file),
          label: const Text('Export DB'),
        ),
        ElevatedButton.icon(
          onPressed: _clearDb,
          icon: const Icon(Icons.delete_forever),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          label: const Text('Clear DB'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Debug'),
        actions: [
          IconButton(
            onPressed: _showSqlShortcutsDialog,
            icon: const Icon(Icons.bolt),
            tooltip: 'SQL Shortcuts',
          ),
          IconButton(
            onPressed: _showSqlDialog,
            icon: const Icon(Icons.code),
            tooltip: 'Run SQL',
          ),
          IconButton(
            onPressed: _loadDebugInfo,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SelectableText(
            _error,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      )
          : ListView(
        children: [
          _buildCard(
            'Actions',
            _buildActionButtons(),
          ),
          _buildCard(
            'Database File',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Path: $_dbPath'),
                const SizedBox(height: 8),
                Text('Exists: $_dbExists'),
                Text('Size: $_dbSize bytes'),
              ],
            ),
          ),
          _buildCard(
            'Table Counts',
            Column(
              children: _counts.entries
                  .map((e) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(e.key),
                trailing: Text('${e.value}'),
              ))
                  .toList(),
            ),
          ),
          _buildCard(
            'SQLite Tables, Columns & Schema',
            Column(
              children: _tables.map((table) {
                final columns = _tableColumns[table] ?? [];

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              table,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _showSchemaDialog(table),
                            child: const Text('Schema'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (columns.isEmpty)
                        const Text('No column info')
                      else
                        ...columns.map((col) {
                          final name = col['name'];
                          final type = col['type'];
                          final notNull = col['notnull'] == 1;
                          final pk = col['pk'] == 1;

                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2),
                            child: SelectableText(
                              '$name [$type]'
                                  '${notNull ? ' NOT NULL' : ''}'
                                  '${pk ? ' PK' : ''}',
                            ),
                          );
                        }),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          _buildCard(
            'SQL Query Result',
            _buildSqlResults(),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showSqlDialog,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Run SQL'),
      ),
    );
  }
}