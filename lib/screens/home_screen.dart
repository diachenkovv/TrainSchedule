import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/direction_tab.dart';
import '../screens/schedule_tab.dart';
import '../screens/train_number_tab.dart';
import '../screens/settings_screen.dart';
import '../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final SettingsProvider settingsProvider;

  const HomeScreen({
    super.key,
    required this.themeProvider,
    required this.settingsProvider,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(
                  themeProvider: widget.themeProvider,
                  settingsProvider: widget.settingsProvider,
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.route),
              text: S.of(context).tab_direction,
            ),
            Tab(
              icon: const Icon(Icons.schedule),
              text: S.of(context).tab_board,
            ),
            Tab(
              icon: const Icon(Icons.train),
              text: S.of(context).tab_train_number,
            ),
          ],
        ),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 400),
        child: TabBarView(
          controller: _tabController,
          children: [
            DirectionTab(settingsProvider: widget.settingsProvider),
            ScheduleTab(settingsProvider: widget.settingsProvider),
            TrainNumberTab(settingsProvider: widget.settingsProvider),
          ],
        ),
      ),
    );
  }
}
