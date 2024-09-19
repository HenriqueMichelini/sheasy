import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 243, 239, 235),
      width: 150,
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align items at the top
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align items to the start
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align icons to the start of the row
            children: [
              const Icon(Icons.account_circle),
              const SizedBox(width: 5),
              const Icon(Icons.folder),
              const SizedBox(width: 5),
              const Icon(Icons.settings),
              const Spacer(), // Add space after icons
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Row(
                  children: [
                    Text(
                      '123643',
                      style: TextStyle(fontSize: 28),
                    ),
                    Icon(Icons.lock),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.loop),
              const Spacer(),
            ],
          ),
          const Row(
            children: [
              CircleAvatar(
                radius: 30, // Adjust size as needed
                backgroundColor: Colors.redAccent, // Background color
                child: Icon(
                  Icons.settings,
                  size: 30, // Icon size
                  color: Colors.white, // Icon color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
