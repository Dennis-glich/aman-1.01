import 'package:MyApp/screen/profil.dart';
import 'package:flutter/material.dart';
import 'widget/gauge.dart';
import 'widget/bar.dart'; // Make sure this path is correct
import 'preofilteam.dart';
import 'getaran.dart';

class DashboardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";

    // Get the sample vibration data
    final List<ChartData> chartData = getSampleVibrationData();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, size: 32),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/Aman .PNG',
              width: 45,
              height: 45,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/Aman .PNG',
                    width: 45,
                    height: 45,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'AMAN',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Team Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg gas.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Hi, User',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Welcome to AMAN',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Today, $formattedDate',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: buildControlCard('Exhaust Fan', 'Mati', false),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: buildControlCard('Pintu', 'Tutup', true),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        buildControlCard('Buzzer', 'Mati', false),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: buildSensorCardWithGauge('Gas & Asap', 300),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GetaranMonitoring()),
                                  );
                                },
                                child: buildVibrationChart(chartData), // Pass the vibration data
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status', style: TextStyle(fontSize: 18, color: Colors.white)),
                              Icon(Icons.settings, color: Colors.white),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 100,
                            child: Placeholder(),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Aman',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
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
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                // Navigate to Home
                break;
              case 1:
                // Stay on Dashboard
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildControlCard(String title, String status, bool isActive) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(status, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              Switch(
                value: isActive,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
