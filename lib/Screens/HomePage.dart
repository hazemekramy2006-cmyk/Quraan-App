import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quraanapp/Screens/QuraanPage.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Text(
              "Quran App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.purple),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Learn Quran",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.grey),
          ),
          SizedBox(height: 50),
          Center(
            child: Container(
              width: 330,
              height: 430,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF8E2DE2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 10))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset("assets/images/مصحف.png", fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Quraanpage()));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFFFA07A),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text("Get Started", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Powered By Eng. Hazem Ekramy",
            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
