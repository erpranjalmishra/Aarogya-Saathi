import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import 'activity.dart';
import 'notification.dart';
import 'profile.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  int _selectedIndex = 1; // AI screen index

  // Update the message handling
  void _handleSendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        // Add user message
        _messages.add({'text': _messageController.text, 'isUser': 'true'});

        // Simulate AI response
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _messages.add({
              'text':
                  'Thank you for your message. I\'m here to help with your health queries.',
              'isUser': 'false',
            });
          });
        });

        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animated Header
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'AI Assistant',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Chat container
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        padding: const EdgeInsets.all(16),
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _messages.isEmpty ? 1 : _messages.length,
                          itemBuilder: (context, index) {
                            if (_messages.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Start a conversation about your health',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                            return _buildMessageBubble(_messages[index]);
                          },
                        ),
                      ),
                    ),

                    // Suggestions Section
                    SlideInRight(
                      duration: const Duration(milliseconds: 700),
                      child: _buildSuggestionsSection(),
                    ),
                  ],
                ),
              ),
            ),

            // Message Input
            _buildMessageInput(),
          ],
        ),
      ),
      bottomNavigationBar: _buildAnimatedBottomBar(),
    );
  }

  // Update message bubble to show different styles for user and AI
  Widget _buildMessageBubble(Map<String, String> message) {
    final bool isUser = message['isUser'] == 'true';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.green[100] : Colors.white,
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
        child: Text(
          message['text'] ?? '',
          style: TextStyle(
            fontSize: 16,
            color: isUser ? Colors.grey[800] : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggested Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSuggestionChip('How to stay healthy?'),
              _buildSuggestionChip('Daily exercise tips'),
              _buildSuggestionChip('Healthy diet advice'),
            ],
          ),
        ],
      ),
    );
  }

  // Update suggestion chip to send message
  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      backgroundColor: Colors.green[50],
      onPressed: () {
        _messageController.text = text;
        _handleSendMessage();
      },
    );
  }

  // Update message input with send functionality
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onSubmitted: (_) => _handleSendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _handleSendMessage,
            backgroundColor: Colors.green,
            mini: true,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  // Update bottom navigation
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
                        Navigator.pushReplacementNamed(context, '/');
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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
