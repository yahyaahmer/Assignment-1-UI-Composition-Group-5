import 'package:flutter/material.dart';

void main() {
  runApp(const YouTubeCloneApp());
}

class YouTubeCloneApp extends StatelessWidget {
  const YouTubeCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const YouTubeHomeScreen(),
    );
  }
}

class YouTubeHomeScreen extends StatelessWidget {
  const YouTubeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;
    final gridChildAspectRatio = screenWidth > 600 ? 4.0 : 3.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'YouTube',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: const [
          Icon(Icons.cast),
          SizedBox(width: 16),
          Icon(Icons.notifications_none),
          SizedBox(width: 16),
          Icon(Icons.search),
          SizedBox(width: 16),
          CircleAvatar(radius: 14, backgroundColor: Colors.grey),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Categories Grid
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                childAspectRatio: gridChildAspectRatio,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildCategoryTile('Trending', Icons.trending_up, Colors.red),
                  _buildCategoryTile('Music', Icons.music_note, Colors.green),
                  _buildCategoryTile(
                    'Gaming',
                    Icons.sports_esports,
                    Colors.orange,
                  ),
                  _buildCategoryTile('News', Icons.article, Colors.blue),
                  _buildCategoryTile(
                    'Sport',
                    Icons.emoji_events,
                    Colors.purple,
                  ),
                  if (screenWidth > 600)
                    _buildCategoryTile('Movies', Icons.movie, Colors.pink),
                ],
              ),
            ),

            // Trending videos heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Trending videos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Video list
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                VideoCard(
                  thumbnail: 'assets/yt1.jpg',
                  title: 'Khuda Aur Mohabbat - Season 03 Ep 01 [Eng Sub]',
                  views: '14M views',
                  date: '6 days ago',
                  channel: 'HAR PAL GEO',
                ),
                VideoCard(
                  thumbnail: 'assets/yt2.jpg',
                  title: 'Top 10 Amazing Music Covers',
                  views: '5M views',
                  date: '1 week ago',
                  channel: 'Music World',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildCategoryTile(String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String views;
  final String date;
  final String channel;

  const VideoCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.views,
    required this.date,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final thumbnailHeight = screenWidth * 9 / 16; // Dynamic 16:9

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: thumbnailHeight,
          child: Image.network(thumbnail, fit: BoxFit.cover),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: const CircleAvatar(backgroundColor: Colors.grey),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('$channel • $views • $date'),
          trailing: const Icon(Icons.more_vert),
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey.shade700,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          label: 'Subscriptions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: 'Library',
        ),
      ],
    );
  }
}
