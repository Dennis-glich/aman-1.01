import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MyApp/screen/dashbord.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Fungsi untuk enkripsi password
  String encryptPassword(String password) {
    final key = encrypt.Key.fromLength(32); // Kunci enkripsi
    final iv = encrypt.IV.fromLength(16);   // Vektor inisialisasi
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64; // Mengembalikan hasil enkripsi dalam format Base64
  }

  // Fungsi registerUser
  Future<void> registerUser(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String encryptedPassword = encryptPassword(passwordController.text); // Enkripsi kata sandi

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'fullName': nameController.text,
        'email': emailController.text,
        'password': encryptedPassword, // Simpan kata sandi terenkripsi
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! Please sign in.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(50),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/smart home oke.jpg', // Change this to your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Text on top of the image
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  'Let\'s get you registered!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Register & Sign In Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {}, // Implement Register
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: Text('Register', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: Text('Sign in', style: TextStyle(color: Colors.brown)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Full name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => registerUser(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                          ),
                          child: Text('Register', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SignInPage extends StatelessWidget {
final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );

      // Arahkan ke halaman dashboard setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()), // Pastikan DashboardPage ada
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed! Please check your credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian gambar yang hanya mengambil 1/3 tinggi layar
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10), // Rounded kiri bawah 10
                  bottomRight: Radius.circular(50), // Rounded kanan bawah 50
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.33, // 1/3 dari tinggi layar
                  width: double.infinity,
                  child: Image.asset(
                    'assets/smart home oke.jpg', // Ganti dengan gambar kamu
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20, // Atur posisi dari bawah
                left: 20,   // Atur posisi dari kiri
                child: Text(
                  'Let\'s get you signed in!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // Bagian konten lainnya
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Kembali ke halaman Register
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: Text('Register', style: TextStyle(color: Colors.brown)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => signInUser(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: Text('Sign in', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Forgot password', style: TextStyle(color: Colors.orange)),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {}, // Implementasi Login
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                          ),
                          child: Text('Login', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.brown), // Instagram Icon
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.google, color: Colors.brown), // Google Icon
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
