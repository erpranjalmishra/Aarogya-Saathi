import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import 'screens/ai_screen.dart';
import 'screens/activity.dart';
import 'screens/notification.dart'; // Add this import
import 'screens/profile.dart'; // Add this import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aarogya Saathi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HealthToolsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HealthToolsScreen extends StatefulWidget {
  const HealthToolsScreen({super.key});

  @override
  State<HealthToolsScreen> createState() => _HealthToolsScreenState();
}

class _HealthToolsScreenState extends State<HealthToolsScreen> {
  late VideoPlayerController _videoController;
  final ScrollController _scrollController = ScrollController();
  bool _isVideoVisible = false;
  int _selectedIndex = 0; // Add this variable for bottom nav
  final List<Map<String, String>> _tasks = [
    {'title': 'Visit Dr. Jatin garg', 'time': '10:30 AM'},
    {'title': 'Deliver Medicines', 'time': '2:30 PM'},
  ];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=3Cp2QTBZAFQ', // Replace with your video URL
      )
      ..initialize().then((_) {
        setState(() {});
      });

    // Add scroll listener
    _scrollController.addListener(() {
      final isVideoVisible = _isElementVisible();
      if (isVideoVisible && !_isVideoVisible) {
        setState(() {
          _isVideoVisible = true;
          _videoController.play();
        });
      } else if (!isVideoVisible && _isVideoVisible) {
        setState(() {
          _isVideoVisible = false;
          _videoController.pause();
        });
      }
    });
  }

  bool _isElementVisible() {
    if (!_scrollController.hasClients) return false;

    final viewportHeight = _scrollController.position.viewportDimension;
    final scrollPosition = _scrollController.position.pixels;
    final itemPosition = viewportHeight * 0.8; // Video position threshold

    return scrollPosition > itemPosition;
  }

  @override
  void dispose() {
    _videoController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated Header
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    'Health Tools',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),

                // Animated Tools Container
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink[100]!, Colors.pink[50]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _buildAnimatedTools(),
                  ),
                ),

                // Animated Tasks Section
                SlideInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: _buildTasksSection(),
                ),

                // Animated Emergency Button
                FlipInX(
                  duration: const Duration(milliseconds: 800),
                  child: _buildEmergencyButton(),
                ),

                // Animated Health Tips Section
                FadeInUp(
                  duration: const Duration(milliseconds: 900),
                  child: _buildHealthTipsSection(),
                ),

                // Animated Metrics Section
                SlideInRight(
                  duration: const Duration(milliseconds: 1000),
                  child: _buildHealthMetricsSection(),
                ),

                // Animated Appointments Section
                FadeInUp(
                  duration: const Duration(milliseconds: 1100),
                  child: _buildUpcomingAppointments(),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildAnimatedBottomBar(),
    );
  }

  Widget _buildHealthMetricsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Metrics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem('Steps', '8,432', Icons.directions_walk),
              _buildMetricItem('Heart Rate', '72 bpm', Icons.favorite),
              _buildMetricItem('Sleep', '7.5 hrs', Icons.nightlight_round),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Shimmer.fromColors(
      baseColor: Colors.green[300]!,
      highlightColor: Colors.green[100]!,
      period: const Duration(seconds: 2),
      child: Column(
        children: [
          Icon(icon, color: Colors.green, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Upcoming Appointments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // Add appointment items here
        ],
      ),
    );
  }

  Widget _buildAnimatedTools() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildAnimatedToolIcon(Icons.calendar_today, 'Calendar', 0),
        _buildAnimatedToolIcon(Icons.list_alt, 'Tasks', 1),
        _buildAnimatedToolIcon(Icons.alarm, 'Reminders', 2),
      ],
    );
  }

  Widget _buildAnimatedToolIcon(IconData icon, String label, int index) {
    return ElasticIn(
      delay: Duration(milliseconds: 200 * index),
      child: InkWell(
        onTap: () {
          // Add tap animation
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$label tapped')));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        const Text(
          'Assigned Tasks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '→ ${_tasks[index]['title']} \n   at ${_tasks[index]['time']}',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          // Add button press animation
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[300],
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Text(
          'Emergency',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHealthTipsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Health Tip',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_videoController.value.isInitialized)
            Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
                if (!_videoController.value.isPlaying)
                  IconButton(
                    icon: const Icon(
                      Icons.play_circle_fill,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _videoController.play();
                      });
                    },
                  ),
              ],
            ),
          const SizedBox(height: 8),
          const Text(
            'Watch this short video for daily health tips',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBottomBar() {
    return SlideInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[50]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: _buildBottomNavBar(),
          ),
          FadeIn(
            delay: const Duration(milliseconds: 1000),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Aarogya Saathi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            if (index == 1) {
              // AI tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AIScreen()),
              );
            } else if (index == 2) {
              // Activity tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActivityScreen()),
              );
            } else if (index == 3) {
              // Notification tab
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            } else if (index == 4) {
              // Profile tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            } else {
              _selectedIndex = index;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'images/home.png',
                height: 28,
                width: 28,
                color: _selectedIndex == 0 ? Colors.green : Colors.grey,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'images/ai.png',
                height: 28,
                width: 28,
                color: _selectedIndex == 1 ? Colors.green : Colors.grey,
              ),
            ),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'images/activity.png',
                height: 28,
                width: 28,
                color: _selectedIndex == 2 ? Colors.green : Colors.grey,
              ),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'images/notification.png',
                height: 28,
                width: 28,
                color: _selectedIndex == 3 ? Colors.green : Colors.grey,
              ),
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'images/logo.png',
                height: 28,
                width: 28,
                color: _selectedIndex == 4 ? Colors.green : Colors.grey,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
