import 'package:flutter/material.dart';

class Error404 extends StatefulWidget {
  const Error404({super.key});

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height*0.35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/error404.png", scale: 5),
              SizedBox(height: size.height*0.02),
              const Text("Ooops!!\nThe page you're looking for cannot be found.")
            ],
          ),
        ),
      ),
    );
  }
}