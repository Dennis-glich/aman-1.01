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
        fontFamily: 'HammersmithOne', // Font keluarga jika ada
      ),
      home: const WelcomeScreen(), // Layar awal
    );
  }
}

// Welcome Screen
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi otomatis ke HomeScreen setelah 10 detik
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/bg1.png'), // Background image
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 68,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Welcome to AMAN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 24), // Hamburger icon
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Membuka drawer
            },
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(), // Memanggil Drawer
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg2.png'), // Gambar latar belakang
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Control your home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center teks ini juga
                ),
              ),
              SizedBox(height: 0.1),
              Text(
                'Control all your smart home devices \nand enjoy your life',
                textAlign: TextAlign.center, // Center teks ini
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10), // Mengurangi jarak vertikal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const AuthScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer (Menu Samping)
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240, // Lebar drawer
      child: Drawer(
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
                leading: const Icon(Icons.home, color: Colors.white, size: 24),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white, size: 24),
                title: const Text(
                  'Help Desk',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Instance GoogleSignIn

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      // Lakukan navigasi atau tindakan lain setelah login berhasil
    } catch (error) {
      print(error); // Tangani error jika terjadi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Bagian atas dengan background
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/smart home oke.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 140.0, left: 16, right: 16),
              child: Column(
                children: const [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Let’s get you registered!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TabBar untuk pilihan Register dan Sign In
          TabBar(
            controller: _tabController,
            indicatorColor: const Color.fromARGB(255, 104, 4, 4),
            indicatorWeight: 4,
            labelColor: const Color.fromARGB(255, 131, 129, 129),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 141, 4, 4),
                  ),
                  child: const Center(
                    child: Text('Register'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text('Sign In'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Form Register
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Input Fields for Register
                      // ...
                    ],
                  ),
                ),
                // Form Sign In
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Input Fields for Sign In
                      // ...
                      // Social login buttons
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Google
                            IconButton(
                              icon: Image.asset('assets/logo google.png', width: 32, height: 32),
                              onPressed: _signInWithGoogle, // Login with Google
                            ),
                            const SizedBox(width: 20),
                            // Logo Instagram
                            IconButton(
                              icon: Image.asset('assets/logo ig.png', width: 32, height: 32),
                              onPressed: () {
                                const url = 'https://www.instagram.com/your_instagram_account/';
                                launch(url); // Pastikan untuk menambahkan dependency untuk open_url
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void launch(String url) {
  // Implementasi untuk membuka URL
}
