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
      title: 'FilteredHealth',
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
    PatternExplorerScreen(),
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
      appBar: AppBar(title: const Text('FilteredHealth')),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
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
            label: 'Patterns',
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
        Text('Your day, at a glance',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text('A personal overview of your health, habits, and well-being.',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's overview",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                const MetricRow(label: 'Sleep', value: '—', detail: 'Connect a data source'),
                const Divider(),
                const MetricRow(label: 'Activity', value: '—', detail: 'Connect a data source'),
                const Divider(),
                const MetricRow(label: 'Mood', value: '—', detail: 'Add a check-in'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(Icons.lightbulb_outline, color: Theme.of(context).colorScheme.primary),
            title: const Text('Your next insight'),
            subtitle: const Text('Explore sample patterns in the Patterns tab.'),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(Icons.add_chart, color: Theme.of(context).colorScheme.primary),
            title: const Text('Build your personal baseline'),
            subtitle: const Text('Connect a data source or log a daily check-in to get started.'),
          ),
        ),
      ],
    );
  }
}

class PatternExplorerScreen extends StatefulWidget {
  const PatternExplorerScreen({super.key});

  @override
  State<PatternExplorerScreen> createState() => _PatternExplorerScreenState();
}

class _PatternExplorerScreenState extends State<PatternExplorerScreen> {
  String _whatIf = 'Move workout earlier';

  String get _whatIfText {
    switch (_whatIf) {
      case 'Add a rest day':
        return 'Your past sample weeks suggest that a rest day could create more recovery time. This is a scenario to consider, not a prediction.';
      case 'Keep bedtime steadier':
        return 'In this sample, steadier bedtimes overlap with more consistent workouts. The timeline shows a relationship, not proof of cause.';
      default:
        return 'In this sample, earlier workouts leave more evening time for rest. Your real result may differ; use this as a planning prompt.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Pattern Explorer',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 6),
        const Text('Sample data • Explore patterns, supporting evidence, and possible routine changes.'),
        const SizedBox(height: 16),
        Card(
          child: ExpansionTile(
            leading: Icon(Icons.lightbulb_outline, color: primary),
            title: const Text('Your workouts were more consistent'),
            subtitle: const Text('Illustrative pattern · 3 sample weeks'),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Show me why\n'
                  '• 3 of 4 logged workouts happened in weeks with a steadier bedtime.\n'
                  '• Source: sample workout log and sample sleep entries.\n'
                  '• Confidence: limited — only a few sample weeks are available.\n'
                  'This overlap does not show that sleep caused the change.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text('Personal pattern timeline',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: const [
              ListTile(
                leading: CircleAvatar(child: Text('W1')),
                title: Text('Week 1 · Routine begins'),
                subtitle: Text('2 workouts logged · bedtime varied'),
              ),
              Divider(height: 1),
              ListTile(
                leading: CircleAvatar(child: Text('W2')),
                title: Text('Week 2 · More regular schedule'),
                subtitle: Text('3 workouts logged · bedtime steadier'),
              ),
              Divider(height: 1),
              ListTile(
                leading: CircleAvatar(child: Text('W3')),
                title: Text('Week 3 · Pattern continues'),
                subtitle: Text('3 workouts logged · sample sleep entries remain steady'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('What-if planner',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Explore a possible routine change'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _whatIf,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Try a scenario',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Move workout earlier', child: Text('Move workout earlier')),
                    DropdownMenuItem(value: 'Add a rest day', child: Text('Add a rest day')),
                    DropdownMenuItem(value: 'Keep bedtime steadier', child: Text('Keep bedtime steadier')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _whatIf = value);
                  },
                ),
                const SizedBox(height: 12),
                Text(_whatIfText),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Demo notice: these are illustrative sample entries, not your personal health data. Insights are not medical advice or guaranteed predictions.',
          style: TextStyle(fontSize: 12),
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
          Expanded(flex: 2, child: Text(label, style: Theme.of(context).textTheme.titleMedium)),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.titleMedium)),
          Expanded(flex: 3, child: Text(detail, style: Theme.of(context).textTheme.bodySmall)),
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
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(description, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
