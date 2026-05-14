import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Widget Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _savedName = 'No name entered yet';
  int _tapCount = 0;
  int _selectedIndex = 0;

  void _saveName() {
    setState(() {
      _savedName = _nameController.text.isEmpty
          ? 'No name entered yet'
          : _nameController.text;
    });
  }

  void _incrementTapCount() {
    setState(() {
      _tapCount++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToSecondScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(name: _savedName, taps: _tapCount),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _buildHomePage(),
      _buildInfoPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Home' : 'Info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _onItemTapped(1),
            tooltip: 'View info',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Material Demo',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sentiment_satisfied),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(children: pages, index: _selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTapCount,
        tooltip: 'Increment counter',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Use Material widgets to build a simple app.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              hintText: 'Type your name here',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveName,
                  child: const Text('Save Name'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _goToSecondScreen,
                  child: const Text('Second Screen'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Saved name'),
                    subtitle: Text(_savedName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.touch_app),
                    title: const Text('Tap count'),
                    subtitle: Text('$_tapCount times'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text('Material widget'),
                  subtitle: Text('Scaffold, AppBar, Drawer, Buttons, Card, TextField'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.lightbulb_outline),
                  title: Text('Build tip'),
                  subtitle: Text('Use padding and columns to organize content.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'App information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text('Platform friendly'),
                  subtitle: Text('Material works on mobile, web, and desktop.'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.design_services),
                  title: Text('Material design'),
                  subtitle: Text('Use Material components for consistent UI.'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Try these actions:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _incrementTapCount,
            icon: const Icon(Icons.add),
            label: const Text('Increment counter'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _goToSecondScreen,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Open second screen'),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key, required this.name, required this.taps});

  final String name;
  final int taps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Saved name: $name',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Text(
                'Button tapped: $taps times',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
