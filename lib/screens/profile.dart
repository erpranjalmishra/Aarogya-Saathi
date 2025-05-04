import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import '/main.dart';
import '/screens/ai_screen.dart';
import '/screens/activity.dart';
import '/screens/notification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4; // Profile screen index
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _postController = TextEditingController();

  // Add these variables
  String _currentName = 'John Smith';
  String _currentPost = 'Professional';
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _nameController.text = _currentName;
    _postController.text = _currentPost;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _postController.dispose();
    super.dispose();
  }

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
                // Profile Header
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[100],
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 32,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _currentPost,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Profile Settings Section
                SlideInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: _buildSection('Profile Settings', [
                    _buildSettingField('Update Name', _nameController),
                    _buildSettingField('Update Post', _postController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('Save', Colors.green),
                        _buildButton('Cancel', Colors.red),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(height: 24),

                // Account Section
                SlideInRight(
                  duration: const Duration(milliseconds: 700),
                  child: _buildSection('Account', [
                    _buildSettingTile(
                      title: 'Receive notification',
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                          // Show notification status
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value
                                    ? 'Notifications enabled'
                                    : 'Notifications disabled',
                              ),
                              backgroundColor:
                                  value ? Colors.green : Colors.grey,
                            ),
                          );
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    _buildSettingTile(
                      title: 'Switch account',
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildAnimatedBottomBar(),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
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
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSettingTile({required String title, Widget? trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(title: Text(title), trailing: trailing, onTap: () {}),
    );
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Save') {
          _handleSave();
        } else if (text == 'Cancel') {
          _handleCancel();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
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
                      case 3:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
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

  // Add this method to handle updates
  void _handleSave() {
    setState(() {
      _currentName = _nameController.text;
      _currentPost = _postController.text;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Add this method to handle cancel
  void _handleCancel() {
    setState(() {
      _nameController.text = _currentName;
      _postController.text = _currentPost;
    });
  }
}
