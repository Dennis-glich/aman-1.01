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
      home: const FixedSizeScreen(),
    );
  }
}

class FixedSizeScreen extends StatelessWidget {
  const FixedSizeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 320 / 597, // Rasio aspek tetap 320x597
          child: Container(
            width: 320,
            height: 597,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20), // Membuat rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5), // Efek bayangan halus
                ),
              ],
            ),
            child: const WelcomeScreen(),
          ),
        ),
      ),
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
    // Menunda selama 60 detik, lalu pindah ke HomeScreen
    Future.delayed(const Duration(seconds: 120), () {
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
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/bg1.png'), //background welcome
            fit: BoxFit.cover,
          ),
          borderRadius:
              BorderRadius.circular(20), // Rounded corners applied here
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
    return Center(
      child: AspectRatio(
        aspectRatio: 320 / 597,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          // Drawer hanya akan muncul di area yang ditentukan
          drawer: SizedBox(
            width: 240, // Sesuaikan lebar drawer dengan ukuran tetap
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
                      leading: const Icon(Icons.home, color: Colors.white),
                      title: const Text('Home',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.app_registration,
                          color: Colors.white),
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
          ),
          body: Container(
            width: 320, // Mengunci lebar HomeScreen sesuai dengan WelcomeScreen
            height:
                597, // Mengunci tinggi HomeScreen sesuai dengan WelcomeScreen
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/bg2.png'), //background home
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.circular(20), // Rounded corners applied here
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
                const SizedBox(
                    height: 20), //tambah jarak antara teks dan tombol
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red[800], //background get started
                        ),
                        child: const Text('Get Started',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white, //warna text sign in
                          side: const BorderSide(
                              color: Colors.white), //warna border
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
        ),
      ),
    );
  }
}
