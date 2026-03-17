// lib/screens/welcome_login_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeLoginScreen extends StatefulWidget {
  const WelcomeLoginScreen({super.key});

  @override
  State<WelcomeLoginScreen> createState() => _WelcomeLoginScreenState();
}

class _WelcomeLoginScreenState extends State<WelcomeLoginScreen> {
  bool _showLoginForm = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorText;

  // ── Firebase Auth instance ──
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ──────────────────────────────────────────────
  //  Навігація
  // ──────────────────────────────────────────────

  void _continueAsGuest() {
    // Анонімний вхід — Firebase все одно створює uid,
    // це зручно, якщо пізніше захочете «зʼєднати» акаунти.
    _signInAnonymously();
  }

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await _auth.signInAnonymously();
      if (!mounted) return;
      context.go('/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorText = _mapFirebaseError(e.code);
      });
    } catch (_) {
      setState(() {
        _errorText = 'Ein unbekannter Fehler ist aufgetreten.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openLoginForm() {
    setState(() {
      _showLoginForm = true;
      _errorText = null;
    });
  }

  void _backToWelcome() {
    setState(() {
      _showLoginForm = false;
      _errorText = null;
    });
  }

  // ──────────────────────────────────────────────
  //  LOGIN (Email + Password)
  // ──────────────────────────────────────────────

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = 'Bitte E-Mail und Passwort eingeben.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // Успішний вхід → переходимо на головну
      context.go('/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorText = _mapFirebaseError(e.code);
      });
    } catch (_) {
      setState(() {
        _errorText = 'Ein unbekannter Fehler ist aufgetreten.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ──────────────────────────────────────────────
  //  REGISTER (Email + Password)
  // ──────────────────────────────────────────────

  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = 'Bitte E-Mail und Passwort eingeben.';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _errorText = 'Das Passwort muss mindestens 6 Zeichen lang sein.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // Успішна реєстрація → переходимо на головну
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrierung erfolgreich!'),
        ),
      );

      context.go('/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorText = _mapFirebaseError(e.code);
      });
    } catch (_) {
      setState(() {
        _errorText = 'Ein unbekannter Fehler ist aufgetreten.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ──────────────────────────────────────────────
  //  Passwort vergessen
  // ──────────────────────────────────────────────

  Future<void> _handleResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorText = 'Bitte gib zuerst deine E-Mail-Adresse ein.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await _auth.sendPasswordResetEmail(email: email);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Eine E-Mail zum Zurücksetzen wurde an $email gesendet.',
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorText = _mapFirebaseError(e.code);
      });
    } catch (_) {
      setState(() {
        _errorText = 'Ein unbekannter Fehler ist aufgetreten.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ──────────────────────────────────────────────
  //  Маппінг помилок Firebase → німецькі повідомлення
  // ──────────────────────────────────────────────

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Die E-Mail-Adresse ist ungültig.';
      case 'user-disabled':
        return 'Dieses Konto wurde deaktiviert.';
      case 'user-not-found':
        return 'Kein Konto mit dieser E-Mail gefunden.';
      case 'wrong-password':
        return 'Das Passwort ist falsch.';
      case 'invalid-credential':
        return 'E-Mail oder Passwort ist falsch.';
      case 'email-already-in-use':
        return 'Diese E-Mail-Adresse wird bereits verwendet.';
      case 'weak-password':
        return 'Das Passwort ist zu schwach (min. 6 Zeichen).';
      case 'too-many-requests':
        return 'Zu viele Versuche. Bitte versuche es später erneut.';
      case 'network-request-failed':
        return 'Netzwerkfehler. Prüfe deine Internetverbindung.';
      case 'operation-not-allowed':
        return 'Diese Anmeldemethode ist nicht aktiviert.';
      default:
        return 'Fehler: $code';
    }
  }

  // ──────────────────────────────────────────────
  //  BUILD
  // ──────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _showLoginForm ? _buildLoginForm() : _buildWelcome(),
        ),
      ),
    );
  }

  // ── Welcome View ──

  Widget _buildWelcome() {
    return Padding(
      key: const ValueKey('welcome_view'),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/logo.png',
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Willkommen bei DeuKarten',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Lerne Deutsch mit Karten, Übungen und thematischen '
                'Wortschätzen aus Schritte Neu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Melde dich an, um fertige Decks aus der Cloud zu laden, '
                'oder starte sofort als Gast.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black54,
            ),
          ),
          const Spacer(),

          // ── Кнопка «Anmelden» ──
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _openLoginForm,
              child: const Text('Anmelden'),
            ),
          ),
          const SizedBox(height: 12),

          // ── Кнопка «Als Gast» ──
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _isLoading ? null : _continueAsGuest,
              child: _isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Als Gast fortfahren'),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Du kannst dich später jederzeit anmelden.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── Login / Register Form ──

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      key: const ValueKey('login_view'),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: _isLoading ? null : _backToWelcome,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Anmelden oder registrieren',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // ── E-Mail ──
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              enabled: !_isLoading,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'E-Mail',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // ── Passwort ──
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              enabled: !_isLoading,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleLogin(),
              decoration: InputDecoration(
                labelText: 'Passwort',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            // ── Passwort vergessen ──
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _isLoading ? null : _handleResetPassword,
                child: const Text(
                  'Passwort vergessen?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),

            // ── Помилка ──
            if (_errorText != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline,
                        color: Colors.red.shade700, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorText!,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),

            // ── Login Button ──
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Login'),
            ),
            const SizedBox(height: 12),

            // ── Register Button ──
            OutlinedButton(
              onPressed: _isLoading ? null : _handleRegister,
              child: const Text('Registrieren'),
            ),
            const SizedBox(height: 16),

            // ── Ohne Anmeldung ──
            TextButton(
              onPressed: _isLoading ? null : _continueAsGuest,
              child: const Text('Ohne Anmeldung fortfahren'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}