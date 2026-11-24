import 'package:flutter/material.dart';

void main() {
  runApp(const PersonalIntelligenceApp());
}

class PersonalIntelligenceApp extends StatelessWidget {
  const PersonalIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Intelligence',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    PlaceholderScreen(
      title: 'Insights',
      icon: Icons.insights_outlined,
      description: 'Your personal insights will appear here.',
    ),
    PlaceholderScreen(
      title: 'Ask AI',
      icon: Icons.chat_bubble_outline,
      description: 'Your AI assistant will be available here.',
    ),
    PlaceholderScreen(
      title: 'My Data',
      icon: Icons.show_chart,
      description: 'Connect and manage your personal data sources here.',
    ),
    PlaceholderScreen(
      title: 'Profile',
      icon: Icons.person_outline,
      description: 'Your profile and preferences will appear here.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Intelligence'),
      ),
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat),
            label: 'Ask AI',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            selectedIcon: Icon(Icons.insert_chart),
            label: 'My Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Your day, at a glance',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'A personal overview of your health, habits, and well-being.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's overview",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const MetricRow(
                  label: 'Sleep',
                  value: '—',
                  detail: 'Connect a data source',
                ),
                const Divider(),
                const MetricRow(
                  label: 'Activity',
                  value: '—',
                  detail: 'Connect a data source',
                ),
                const Divider(),
                const MetricRow(
                  label: 'Mood',
                  value: '—',
                  detail: 'Add a check-in',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Card(
          child: ListTile(
            leading: Icon(
              Icons.lightbulb_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Your next insight'),
            subtitle: const Text(
              'Insights will appear here when your data is connected.',
            ),
          ),
        ),
        const SizedBox(height: 16),

        Card(
          child: ListTile(
            leading: Icon(
              Icons.add_chart,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Build your personal baseline'),
            subtitle: const Text(
              'Connect a data source or log a daily check-in to get started.',
            ),
          ),
        ),
      ],
    );
  }
}

class MetricRow extends StatelessWidget {
  const MetricRow({
    super.key,
    required this.label,
    required this.value,
    required this.detail,
  });

  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              detail,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  final String title;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}