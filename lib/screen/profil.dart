import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dashbord.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPasswordVisible = false;
  String profileImagePath = 'assets/default_profile.png'; // Default profile image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), // Same background as in TeamProfilePage
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
                        'Profil Saya',
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
                // Profile Image
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      // Allow user to change the profile photo
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          profileImagePath = pickedFile.path;
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(profileImagePath),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // White Container for Profile Fields
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileField('Username', 'User'),
                        buildProfileField('Email', 'user@example.com', isPasswordField: false),
                        buildProfileField('Password', '********', isPasswordField: true),
                        Spacer(), // Push the content to the top, leaving space at the bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom navigation bar with updated design
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Make BottomNavigationBar transparent to show rounded corners
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, color: Colors.white),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          currentIndex: 2, // Set to the profile page index
          onTap: (index) {
            switch (index) {
              case 0:
                // Navigate to Home
                Navigator.pushNamed(context, '/home'); // Assuming you have a named route for Home
                break;
              case 1:
                // Navigate to Dashboard
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
                break;
              case 2:
                // Stay on Profile (already here)
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value, {bool isPasswordField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          isPasswordField
              ? Row(
                  children: [
                    Text(
                      isPasswordVisible ? 'password123' : '********',
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ],
                )
              : Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
        ],
      ),
    );
  }
}
