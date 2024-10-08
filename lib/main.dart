import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiAman());
}

class AplikasiAman extends StatelessWidget {
  const AplikasiAman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Menunda selama 15 detik, lalu pindah ke HomeScreen
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'), //background welcome
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Hi\nWelcome to AMAN',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), //warna garis 3
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.red[900],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red[800],
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title:
                    const Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading:
                    const Icon(Icons.app_registration, color: Colors.white),
                title: const Text('Pendaftaran',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white),
                title: const Text('Help Desk',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.png'), //background home
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Control your home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), //tambah jarak antara teks dan tombol
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800], //background get started
                    ),
                    child: const Text('Get Started',
                        style: TextStyle(
                            color: Colors.white)), //warna text get started
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white, //warna text sign in
                      side:
                          const BorderSide(color: Colors.white), //warna border
                    ),
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50), //jarak bagian bawah
          ],
        ),
      ),
    );
  }
}
