import 'package:flutter/material.dart';
import 'package:adaptive_core/adaptive_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Core Example',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _initialized = false;
  bool _loggedIn = false;
  String _status = 'SDK not initialized';

  Future<void> _initialize() async {
    try {
      await AdaptiveCore.initialize(clientId: 'YOUR_CLIENT_ID', debug: true);
      setState(() {
        _initialized = true;
        _status = '✅ SDK initialized';
      });
    } on AdaptiveException catch (e) {
      setState(() => _status = '❌ ${e.message}');
    } catch (e) {
      setState(() => _status = '❌ $e');
    }
  }

  Future<void> _login() async {
    try {
      await AdaptiveCore.login(
        const AdaptiveUser(
          userId: '1001',
          userName: 'Jane Doe',
          userEmail: 'jane.doe@example.com',
        ),
      );
      setState(() {
        _loggedIn = true;
        _status = '✅ Logged in as Jane Doe';
      });
    } on AdaptiveException catch (e) {
      setState(() => _status = '❌ ${e.message}');
    } catch (e) {
      setState(() => _status = '❌ $e');
    }
  }

  Future<void> _logout() async {
    try {
      await AdaptiveCore.logout();
      setState(() {
        _loggedIn = false;
        _status = '✅ Logged out';
      });
    } on AdaptiveException catch (e) {
      setState(() => _status = '❌ ${e.message}');
    } catch (e) {
      setState(() => _status = '❌ $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adaptive Core Example')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _status,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _initialized ? null : _initialize,
              icon: const Icon(Icons.rocket_launch),
              label: const Text('Initialize SDK'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: (_initialized && !_loggedIn) ? _login : null,
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loggedIn ? _logout : null,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
