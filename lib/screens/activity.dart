import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import '/main.dart';
import '/screens/ai_screen.dart';
import '/screens/notification.dart';
import '/screens/profile.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedIndex = 2; // Activity screen index
  int _currentImageIndex = 0;
  final List<String> _images = ['images/relief.png', 'images/excercise.png'];

  final Map<String, String> _activityData = {
    'Steps': '8,547 steps today',
    'Calories': '487 kcal burned',
    'Heart rate': '72 bpm average',
  };

  final Map<String, String> _activityInfo = {
    'Steps': 'Daily goal: 10,000 steps',
    'Calories': 'Target: 500 kcal',
    'Heart rate': 'Normal range: 60-100 bpm',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced Header
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      const Text(
                        'Relief Your Pain',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ShimmerLoading(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.red[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Live Tracking',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    231,
                                    208,
                                    208,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Enhanced Slideshow Section
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            PageView.builder(
                              onPageChanged: (index) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    _images.asMap().entries.map((entry) {
                                      return Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(
                                            _currentImageIndex == entry.key
                                                ? 0.9
                                                : 0.4,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_currentImageIndex + 1}/${_images.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Enhanced Activity Buttons
                ..._buildActivityButtons(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildAnimatedBottomBar(),
    );
  }

  List<Widget> _buildActivityButtons() {
    final activities = [
      ('Steps', Icons.directions_walk, Colors.red[400]!, Colors.red[300]!),
      (
        'Calories',
        Icons.local_fire_department,
        Colors.red[600]!,
        Colors.red[500]!,
      ),
      ('Heart rate', Icons.favorite, Colors.red[800]!, Colors.red[700]!),
    ];

    return activities.asMap().entries.map((entry) {
      final (title, icon, startColor, endColor) = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SlideInLeft(
          duration: Duration(milliseconds: 700 + (entry.key * 100)),
          child: _buildEnhancedActivityButton(
            title,
            icon,
            startColor,
            endColor,
            _activityData[title]!,
            _activityInfo[title]!,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildEnhancedActivityButton(
    String title,
    IconData icon,
    Color startColor,
    Color endColor,
    String data,
    String info,
  ) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title statistics'),
            backgroundColor: startColor,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: startColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              data,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              info,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    if (index != _selectedIndex) {
                      _selectedIndex = index;
                      switch (index) {
                        case 0:
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HealthToolsScreen(),
                            ),
                            (route) => false,
                          );
                          break;
                        case 1:
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AIScreen(),
                            ),
                            (route) => false,
                          );
                          break;
                        case 3:
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                            (route) => false,
                          );
                          break;
                        case 4:
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                            (route) => false,
                          );
                          break;
                      }
                    }
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                items: [
                  _buildNavBarItem('images/home.png', 'Home', 0),
                  _buildNavBarItem('images/ai.png', 'AI', 1),
                  _buildNavBarItem('images/activity.png', 'Activity', 2),
                  _buildNavBarItem(
                    'images/notification.png',
                    'Notifications',
                    3,
                  ),
                  _buildNavBarItem('images/logo.png', 'Profile', 4),
                ],
              ),
            ),
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

  // Add this helper method for cleaner navigation bar items
  BottomNavigationBarItem _buildNavBarItem(
    String imagePath,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset(
          imagePath,
          height: 28,
          width: 28,
          color: _selectedIndex == index ? Colors.green : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  final Widget child;

  const ShimmerLoading({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red[300]!,
      highlightColor: Colors.red[100]!,
      period: const Duration(seconds: 2),
      child: child,
    );
  }
}
