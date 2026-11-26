import 'package:flutter/material.dart';

void main() => runApp(const FilteredHealthApp());

const ink = Color(0xFF17241F);
const green = Color(0xFFB9F36A);
const paper = Color(0xFFF5F6F1);
const muted = Color(0xFF718078);

class FilteredHealthApp extends StatelessWidget {
  const FilteredHealthApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FilteredHealth',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: paper,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF52765F), brightness: Brightness.light),
      appBarTheme: const AppBarTheme(backgroundColor: paper, foregroundColor: ink, elevation: 0),
      fontFamily: 'Roboto',
      cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
    ),
    home: const MainShell(),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;
  final pages = const [HomePage(), InsightsPage(), AskPage(), DataPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: IndexedStack(index: tab, children: pages)),
    bottomNavigationBar: NavigationBar(
      backgroundColor: Colors.white,
      indicatorColor: green.withValues(alpha: .45),
      selectedIndex: tab,
      onDestinationSelected: (v) => setState(() => tab = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Insights'),
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Ask AI'),
        NavigationDestination(icon: Icon(Icons.show_chart), selectedIcon: Icon(Icons.insert_chart), label: 'My Data'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ],
    ),
  );
}

class PageFrame extends StatelessWidget {
  const PageFrame({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [const DemoBanner(), const SizedBox(height: 18), child],
  );
}

class DemoBanner extends StatelessWidget {
  const DemoBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: const Color(0xFFE8EEDC), borderRadius: BorderRadius.circular(30)),
    child: const Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.science_outlined, size: 15, color: Color(0xFF526D4A)),
      SizedBox(width: 7),
      Text('DEMO MODE  •  SAMPLE DATA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: .7, color: Color(0xFF526D4A))),
    ]),
  );
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Text(text.toUpperCase(), style: const TextStyle(fontSize: 11, letterSpacing: 1.3, fontWeight: FontWeight.w800, color: muted));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Eyebrow('WEDNESDAY, NOV 26'),
      SizedBox(height: 7),
      Text('Your health,\nin context.', style: TextStyle(fontSize: 34, height: 1.05, fontWeight: FontWeight.w800, color: ink)),
    ])), CircleAvatar(radius: 25, backgroundColor: green, child: Icon(Icons.person, color: ink, size: 28))]),
    const SizedBox(height: 22),
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(28)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Expanded(child: Text('YOUR WEEK AT A GLANCE', style: TextStyle(color: green, fontWeight: FontWeight.w800, letterSpacing: 1, fontSize: 11))), Icon(Icons.north_east, color: Colors.white.withValues(alpha: .7))]),
        const SizedBox(height: 18),
        const Text('A little more\nconsistent.', style: TextStyle(color: Colors.white, fontSize: 27, height: 1.12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('You logged 3 workouts in the sample week. Keep building a routine that works for you.', style: TextStyle(color: Colors.white.withValues(alpha: .72), height: 1.45)),
        const SizedBox(height: 18),
        const Row(children: [
          _MiniMetric(value: '3', label: 'WORKOUTS'),
          SizedBox(width: 28),
          _MiniMetric(value: '2.4k', label: 'AVG. STEPS'),
          SizedBox(width: 28),
          _MiniMetric(value: '7h 20m', label: 'SLEEP'),
        ]),
      ]),
    ),
    const SizedBox(height: 26),
    const SectionHeading(title: 'Your signals', action: 'Sample week'),
    const SizedBox(height: 12),
    const Row(children: [
      Expanded(child: MetricCard(icon: Icons.directions_run, label: 'Movement', value: '3 sessions', change: '+1 vs last week', color: Color(0xFFE8F1DD))),
      SizedBox(width: 12),
      Expanded(child: MetricCard(icon: Icons.bedtime_outlined, label: 'Sleep', value: '7h 20m', change: 'Steadier timing', color: Color(0xFFE8EAF5))),
    ]),
    const SizedBox(height: 12),
    const MetricCard(icon: Icons.favorite_border, label: 'Recovery check-in', value: 'Not logged yet', change: 'Add a check-in in a future version', color: Color(0xFFF7E8DF), wide: true),
    const SizedBox(height: 26),
    const SectionHeading(title: 'A pattern to explore', action: '3 weeks'),
    const SizedBox(height: 12),
    const InsightPreview(),
    const SizedBox(height: 20),
    const Text('Sample values are illustrative and are not personal health measurements.', style: TextStyle(fontSize: 12, color: muted)),
  ]));
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)),
    const SizedBox(height: 4),
    Text(label, style: TextStyle(color: Colors.white.withValues(alpha: .6), fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: .7)),
  ]);
}

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.icon, required this.label, required this.value, required this.change, required this.color, this.wide = false});
  final IconData icon; final String label, value, change; final Color color; final bool wide;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
    child: Row(children: [
      Container(width: 42, height: 42, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: ink)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 12, color: muted, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink)),
        const SizedBox(height: 3),
        Text(change, style: const TextStyle(fontSize: 10, color: muted)),
      ])),
    ]),
  );
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, required this.action});
  final String title, action;
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: ink))),
    Text(action, style: const TextStyle(fontSize: 11, color: muted, fontWeight: FontWeight.w700)),
  ]);
}

class InsightPreview extends StatelessWidget {
  const InsightPreview({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [Icon(Icons.auto_awesome, color: Color(0xFF6B8758)), SizedBox(width: 8), Eyebrow('POTENTIAL PATTERN'), Spacer(), Icon(Icons.arrow_forward, size: 18)]),
      const SizedBox(height: 12),
      const Text('Your workouts became more regular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 6),
      const Text('3 of 4 logged workouts fell in weeks with steadier bedtimes.', style: TextStyle(color: muted, height: 1.4)),
      const SizedBox(height: 14),
      Row(children: [
        const Icon(Icons.fact_check_outlined, size: 16, color: muted),
        const SizedBox(width: 6),
        const Expanded(child: Text('Evidence available · limited sample', style: TextStyle(fontSize: 11, color: muted))),
        TextButton(onPressed: () {}, child: const Text('Show me why')),
      ]),
    ]),
  );
}

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});
  @override
  State<InsightsPage> createState() => _InsightsPageState();
}
class _InsightsPageState extends State<InsightsPage> {
  String scenario = 'Move workout earlier';
  bool showEvidence = false;
  @override
  Widget build(BuildContext context) => PageFrame(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Eyebrow('NOTICE • UNDERSTAND • EXPLORE'),
    const SizedBox(height: 8),
    const Text('Your patterns', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 8),
    const Text('Small signals from your routines, with the evidence kept in view.', style: TextStyle(color: muted, height: 1.45)),
    const SizedBox(height: 22),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(26)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [Icon(Icons.auto_awesome, color: green), SizedBox(width: 8), Text('INSIGHT 01', style: TextStyle(color: green, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)), Spacer(), Icon(Icons.more_horiz, color: Colors.white70)]),
      const SizedBox(height: 14),
      const Text('Your workouts were more consistent', style: TextStyle(color: Colors.white, fontSize: 23, height: 1.15, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Text('3 of 4 logged workouts happened in weeks with steadier bedtimes.', style: TextStyle(color: Colors.white.withValues(alpha: .72), height: 1.5)),
      const SizedBox(height: 16),
      Wrap(spacing: 8, children: [
        _Pill('3 sample weeks', dark: true),
        _Pill('Limited confidence', dark: true),
      ]),
      const SizedBox(height: 14),
      OutlinedButton.icon(onPressed: () => setState(() => showEvidence = !showEvidence), icon: Icon(showEvidence ? Icons.expand_less : Icons.visibility_outlined), label: Text(showEvidence ? 'Hide evidence' : 'Show me why'), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white.withValues(alpha: .3)))),
      if (showEvidence) ...[
        const SizedBox(height: 12),
        const Divider(color: Colors.white24),
        const Text('Evidence used', style: TextStyle(color: green, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('• Sample workout log and sample sleep entries\n• Time window: 3 illustrative weeks\n• A small sample can miss context. This overlap does not prove that sleep caused the change.', style: TextStyle(color: Colors.white.withValues(alpha: .8), height: 1.5)),
      ],
    ])),
    const SizedBox(height: 24),
    const SectionHeading(title: 'Pattern timeline', action: '3 sample weeks'),
    const SizedBox(height: 12),
    const TimelineCard(),
    const SizedBox(height: 24),
    const SectionHeading(title: 'What-if planner', action: 'Hypothetical'),
    const SizedBox(height: 8),
    const Text('Explore a possible routine change. This is not a prediction.', style: TextStyle(color: muted)),
    const SizedBox(height: 12),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DropdownButtonFormField<String>(value: scenario, isExpanded: true, decoration: const InputDecoration(labelText: 'Try a scenario', border: OutlineInputBorder()), items: const [
        DropdownMenuItem(value: 'Move workout earlier', child: Text('Move workout earlier')),
        DropdownMenuItem(value: 'Add a rest day', child: Text('Add a rest day')),
        DropdownMenuItem(value: 'Keep bedtime steadier', child: Text('Keep bedtime steadier')),
      ], onChanged: (v) { if (v != null) setState(() => scenario = v); }),
      const SizedBox(height: 14),
      Text(scenario == 'Add a rest day' ? 'Planning prompt: check whether a rest day fits your schedule and recovery needs. The sample data cannot predict your result.' : scenario == 'Keep bedtime steadier' ? 'Planning prompt: try a steadier bedtime for a week and observe how your routine feels. The sample does not establish cause and effect.' : 'Planning prompt: consider moving a workout earlier and notice whether it fits your day better. This is not a forecast.', style: const TextStyle(color: muted, height: 1.5)),
    ])),
    const SizedBox(height: 18),
    const Text('Illustrative sample data only. Not medical advice, diagnosis, or a guaranteed prediction.', style: TextStyle(fontSize: 12, color: muted)),
  ]));
}

class TimelineCard extends StatelessWidget {
  const TimelineCard({super.key});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(children: const [
    _TimelineRow(week: 'W1', title: 'Routine begins', detail: '2 workouts · bedtime varied', bars: [34, 20, 30]),
    Divider(height: 26),
    _TimelineRow(week: 'W2', title: 'Schedule steadies', detail: '3 workouts · bedtime steadier', bars: [48, 35, 44]),
    Divider(height: 26),
    _TimelineRow(week: 'W3', title: 'Pattern continues', detail: '3 workouts · sample sleep steady', bars: [55, 42, 58]),
  ]));
}
class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.week, required this.title, required this.detail, required this.bars});
  final String week, title, detail; final List<int> bars;
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFE8EEDC), borderRadius: BorderRadius.circular(14)), alignment: Alignment.center, child: Text(week, style: const TextStyle(fontWeight: FontWeight.w800, color: ink))),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 4),
      Text(detail, style: const TextStyle(fontSize: 11, color: muted)),
    ])),
    const SizedBox(width: 8),
    SizedBox(width: 58, height: 36, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: bars.map((h) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 2), child: Container(height: h.toDouble() * .55, decoration: BoxDecoration(color: const Color(0xFFB9D58F), borderRadius: BorderRadius.circular(5))))).toList())),
  ]);
}

class AskPage extends StatefulWidget {
  const AskPage({super.key});
  @override
  State<AskPage> createState() => _AskPageState();
}
class _AskPageState extends State<AskPage> {
  final controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  void send() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({'q': text, 'a': 'This demo assistant uses sample information only. In the full product, it would answer using your permitted data and show the records behind its response.'});
      controller.clear();
    });
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Column(children: [
    Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(20, 18, 20, 18), children: [
      const DemoBanner(),
      const SizedBox(height: 22),
      const Eyebrow('YOUR DATA, IN PLAIN LANGUAGE'),
      const SizedBox(height: 8),
      const Text('Ask with context.', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 8),
      const Text('A future assistant for exploring your patterns. This preview is not connected to an AI service.', style: TextStyle(color: muted, height: 1.45)),
      const SizedBox(height: 22),
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(24)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.chat_rounded, color: green, size: 28),
        SizedBox(height: 12),
        Text('Start with a question', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
        SizedBox(height: 6),
        Text('“What changed in my routine this month?”', style: TextStyle(color: Colors.white70, height: 1.4)),
      ])),
      const SizedBox(height: 18),
      const Eyebrow('TRY ASKING'),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _PromptChip(text: 'Explain my workout pattern', onTap: () => setPrompt('Explain my workout pattern')),
        _PromptChip(text: 'What data is missing?', onTap: () => setPrompt('What data is missing?')),
        _PromptChip(text: 'Summarize my sample week', onTap: () => setPrompt('Summarize my sample week')),
      ]),
      const SizedBox(height: 18),
      ...messages.map((m) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Align(alignment: Alignment.centerRight, child: Container(padding: const EdgeInsets.all(14), margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(18)), child: Text(m['q']!, style: const TextStyle(color: ink)))),
        Container(padding: const EdgeInsets.all(14), margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Text(m['a']!, style: const TextStyle(color: muted, height: 1.4))),
      ])),
    ])),
    Container(color: Colors.white, padding: const EdgeInsets.fromLTRB(14, 10, 14, 12), child: Row(children: [
      Expanded(child: TextField(controller: controller, onSubmitted: (_) => send(), decoration: InputDecoration(hintText: 'Ask a question…', filled: true, fillColor: paper, border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)))),
      const SizedBox(width: 8),
      IconButton(onPressed: send, style: IconButton.styleFrom(backgroundColor: ink, foregroundColor: green), icon: const Icon(Icons.arrow_upward_rounded)),
    ])),
  ]);
  void setPrompt(String text) { controller.text = text; controller.selection = TextSelection.collapsed(offset: text.length); }
}
class _PromptChip extends StatelessWidget {
  const _PromptChip({required this.text, required this.onTap});
  final String text; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ActionChip(label: Text(text), onPressed: onTap, backgroundColor: Colors.white, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)));
}

class DataPage extends StatelessWidget {
  const DataPage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Eyebrow('YOUR INFORMATION, YOUR CHOICE'),
    const SizedBox(height: 8),
    const Text('My data', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 8),
    const Text('A clear view of what the app uses—and what it doesn’t.', style: TextStyle(color: muted, height: 1.4)),
    const SizedBox(height: 22),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(24)), child: const Row(children: [
      Icon(Icons.shield_outlined, color: green, size: 30),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Your data stays yours', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
        SizedBox(height: 5),
        Text('This preview contains sample records only. No health account is connected.', style: TextStyle(color: Colors.white70, height: 1.4)),
      ])),
    ])),
    const SizedBox(height: 24),
    const SectionHeading(title: 'Data sources', action: 'Not connected'),
    const SizedBox(height: 12),
    const SourceTile(icon: Icons.phone_iphone, title: 'Apple Health', subtitle: 'Planned integration', tint: Color(0xFFF9E5E4)),
    const SizedBox(height: 10),
    const SourceTile(icon: Icons.monitor_heart_outlined, title: 'Health Connect', subtitle: 'Planned integration', tint: Color(0xFFE5EEF8)),
    const SizedBox(height: 10),
    const SourceTile(icon: Icons.edit_note, title: 'Manual check-ins', subtitle: 'Planned feature', tint: Color(0xFFE8EEDC)),
    const SizedBox(height: 24),
    const SectionHeading(title: 'Sample records', action: 'Demo only'),
    const SizedBox(height: 12),
    const _RecordTile(date: 'NOV 24', name: 'Strength workout', detail: '35 min · Sample log'),
    const Divider(height: 1),
    const _RecordTile(date: 'NOV 25', name: 'Daily movement', detail: '2,400 steps · Sample log'),
    const Divider(height: 1),
    const _RecordTile(date: 'NOV 26', name: 'Sleep duration', detail: '7h 20m · Sample log'),
    const SizedBox(height: 22),
    const Text('Real connections, consent controls, export, and deletion will be added with the backend.', style: TextStyle(color: muted, fontSize: 12, height: 1.45)),
  ]));
}
class SourceTile extends StatelessWidget {
  const SourceTile({super.key, required this.icon, required this.title, required this.subtitle, required this.tint});
  final IconData icon; final String title, subtitle; final Color tint;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Row(children: [
    Container(width: 44, height: 44, decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: ink)),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(fontSize: 12, color: muted)),
    ])),
    const _Pill('PLANNED'),
  ]));
}
class _RecordTile extends StatelessWidget {
  const _RecordTile({required this.date, required this.name, required this.detail});
  final String date, name, detail;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Row(children: [
    SizedBox(width: 54, child: Text(date, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: muted))),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: const TextStyle(fontWeight: FontWeight.w700, color: ink)),
      const SizedBox(height: 3),
      Text(detail, style: const TextStyle(fontSize: 12, color: muted)),
    ])),
    const Icon(Icons.chevron_right, color: muted),
  ]));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Eyebrow('YOUR SPACE'),
    const SizedBox(height: 8),
    const Text('Profile', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 20),
    Container(width: double.infinity, padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(26)), child: const Column(children: [
      CircleAvatar(radius: 36, backgroundColor: green, child: Icon(Icons.person, color: ink, size: 38)),
      SizedBox(height: 12),
      Text('Your fitness journey', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      SizedBox(height: 5),
      Text('Personal profile setup coming soon', style: TextStyle(color: Colors.white70)),
      SizedBox(height: 14),
      _Pill('GUEST PREVIEW', dark: true),
    ])),
    const SizedBox(height: 24),
    const SectionHeading(title: 'Preferences', action: 'Preview'),
    const SizedBox(height: 10),
    const _SettingsRow(icon: Icons.notifications_none, title: 'Reminders', subtitle: 'Habit nudges and check-ins'),
    const _SettingsRow(icon: Icons.lock_outline, title: 'Privacy & permissions', subtitle: 'Manage access to your data'),
    const _SettingsRow(icon: Icons.accessibility_new, title: 'Accessibility', subtitle: 'Text size and display options'),
    const _SettingsRow(icon: Icons.help_outline, title: 'Help & about', subtitle: 'How FilteredHealth works'),
    const SizedBox(height: 18),
    const Text('FilteredHealth · Demo build', style: TextStyle(color: muted, fontSize: 12)),
    const SizedBox(height: 5),
    const Text('Insights are informational and not medical advice.', style: TextStyle(color: muted, fontSize: 12)),
  ]));
}
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.icon, required this.title, required this.subtitle});
  final IconData icon; final String title, subtitle;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 4),
    leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: ink)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: muted)),
    trailing: const Icon(Icons.chevron_right, color: muted),
    onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title will be available in the next build.'))),
  );
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, {this.dark = false});
  final String text; final bool dark;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: dark ? Colors.white.withValues(alpha: .12) : const Color(0xFFE8EEDC), borderRadius: BorderRadius.circular(20)), child: Text(text, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: .5, color: dark ? Colors.white : const Color(0xFF526D4A))));
}
