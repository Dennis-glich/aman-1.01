import 'package:flutter/material.dart';

class TeamProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Back button functionality
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Text(
                        'Team Profil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 32), // Placeholder for alignment
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Team Image filling the width of the screen
                Center(
                  child: Container(
                    width: double.infinity, // Set to fill the width of the screen
                    child: Image.asset(
                      'assets/Frame 3.png', // Your combined team image
                      fit: BoxFit.cover, // Adjust to cover the entire width
                    ),
                  ),
                ),
                // Spacer for flexible layout
                Spacer(),
              ],
            ),
          ),
        ],
      ),
      // Remove bottomNavigationBar
    );
  }
}
