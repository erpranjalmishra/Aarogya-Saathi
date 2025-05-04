import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import '/main.dart';
import '/screens/ai_screen.dart';
import '/screens/activity.dart';
import '/screens/profile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 3; // Notification screen index
  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.medication,
      'title': 'Medicine',
      'subtitle': 'Take your medications',
      'time': 'Today',
    },
    {
      'icon': Icons.calendar_today,
      'title': 'Appointment',
      'subtitle': 'Upcoming doctor visit',
      'time': 'Tomorrow',
    },
    {
      'icon': Icons.science,
      'title': 'Blood Test',
      'subtitle': 'Regular checkup needed',
      'time': 'Next week',
    },
    {
      'icon': Icons.vaccines,
      'title': 'Vaccination',
      'subtitle': 'Due for next dose',
      'time': 'Next month',
    },
  ];

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
                // Header
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                // Quick Actions Grid
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildQuickActionCard(
                        Icons.medication,
                        'Medications',
                        Colors.pink[50]!,
                      ),
                      _buildQuickActionCard(
                        Icons.calendar_today,
                        'Appointments',
                        Colors.pink[50]!,
                      ),
                      _buildQuickActionCard(
                        Icons.alarm,
                        'Reminders',
                        Colors.pink[50]!,
                      ),
                      _buildQuickActionCard(
                        Icons.groups,
                        'More',
                        Colors.pink[50]!,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Featured Actions
                SlideInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: _buildFeatureCard(
                    'Blood Test',
                    'Schedule your next blood test',
                    Icons.science,
                    Colors.pink[50]!,
                  ),
                ),
                const SizedBox(height: 16),

                SlideInRight(
                  duration: const Duration(milliseconds: 800),
                  child: _buildFeatureCard(
                    'Vaccination',
                    'Check vaccination schedule',
                    Icons.vaccines,
                    Colors.pink[50]!,
                  ),
                ),
                const SizedBox(height: 24),

                // Recent Notifications
                FadeInUp(
                  duration: const Duration(milliseconds: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Updates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._notifications.map(
                        (notification) => _buildNotificationItem(
                          notification['icon'],
                          notification['title'],
                          notification['subtitle'],
                          notification['time'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildAnimatedBottomBar(),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title selected'),
                backgroundColor: Colors.green,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.grey[800]),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title selected'),
            backgroundColor: Colors.green,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.grey[800]),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(subtitle, style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[800]),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    IconData icon,
    String title,
    String subtitle,
    String time,
  ) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title notification'),
            backgroundColor: Colors.green,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.grey[800]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
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
                  if (index != _selectedIndex) {
                    switch (index) {
                      case 0:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HealthToolsScreen(),
                          ),
                        );
                        break;
                      case 1:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AIScreen(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityScreen(),
                          ),
                        );
                        break;
                      case 4:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                        break;
                    }
                  }
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
