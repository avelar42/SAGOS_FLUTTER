import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(90, 25, 0, 255),
              Color.fromARGB(90, 0, 162, 255),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            color: Colors.black,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColorDark),
                  child: Text(
                    'SAGOS',
                    style: TextStyle(
                        fontSize: 45, fontFamily: 'Anton', color: Colors.white),
                  ),
                ),
                AuthForm()
              ],
            ),
          )
        ],
      ),
    );
  }
}
