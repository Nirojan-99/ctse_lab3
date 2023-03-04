import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          width: double.infinity,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                // controller: _controller,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    // label: Text('Task'),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: Colors.lightBlue,
                    filled: true),
              ),
              const SizedBox(
                height: 13,
              ),
              const Text(
                "Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                obscureText: true,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                // controller: _controller,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    // label: Text('Task'),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: Colors.lightBlue,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(),
                  onPressed: () {},
                  child: const Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
