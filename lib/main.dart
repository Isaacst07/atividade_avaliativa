import 'package:material_ui/material_ui.dart';

import 'pages/category_detail_page.dart';
import 'pages/home_page.dart';
import 'pages/nearby_page.dart';
import 'pages/profile_page.dart';
import 'pages/saved_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discovery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const DiscoveryPage(),
    );
  }
}

class DiscoveryCardData {
  const DiscoveryCardData({
    required this.title,
    required this.time,
    required this.icon,
  });

  final String title;
  final String time;
  final IconData icon;
}

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    _DiscoveryHome(),
    SavedPage(),
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Discovery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DiscoveryHome extends StatelessWidget {
  const _DiscoveryHome();

  static const List<DiscoveryCardData> _cards = [
    DiscoveryCardData(
      title: 'Bars & Hotels',
      time: '20 min',
      icon: Icons.hotel,
    ),
    DiscoveryCardData(
      title: 'Fine Dining',
      time: '25 min',
      icon: Icons.restaurant,
    ),
    DiscoveryCardData(
      title: 'Cafes',
      time: '24 min',
      icon: Icons.local_cafe,
    ),
    DiscoveryCardData(
      title: 'Nearby',
      time: '34 min',
      icon: Icons.near_me,
    ),
    DiscoveryCardData(
      title: 'Featured Foods',
      time: '27 min',
      icon: Icons.restaurant_menu,
    ),
    DiscoveryCardData(
      title: 'Fast Foods',
      time: '22 min',
      icon: Icons.fastfood,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                'Discovery',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, size: 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: _cards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final card = _cards[index];
                return _DiscoveryCard(
                  data: card,
                  onTap: () {
                    if (card.title == 'Nearby') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NearbyPage(),
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryDetailPage(
                          title: card.title,
                          time: card.time,
                          icon: card.icon,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscoveryCard extends StatelessWidget {
  const _DiscoveryCard({required this.data, required this.onTap});

  final DiscoveryCardData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isNearby = data.title == 'Nearby';
    final Color backgroundColor =
        isNearby ? Colors.amber : const Color(0xFFF2F2F2);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .spaceBetween,
          children: [
            Icon(data.icon, size: 36, color: Colors.black87),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.time,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
