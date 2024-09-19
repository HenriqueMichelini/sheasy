import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 243, 239, 235),
      width: double.infinity, // Full width of the screen
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align items at the top
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align items to the start
        children: [
          Stack(
            children: [
              // First group of icons at the start
              Align(
                alignment:
                    Alignment.centerLeft, // Align to the start of the row
                child: Row(
                  children: const [
                    Icon(Icons.account_circle),
                    SizedBox(width: 5),
                    Icon(Icons.folder),
                    SizedBox(width: 5),
                    Icon(Icons.settings),
                  ],
                ),
              ),

              // Centralized container and loop icon
              Align(
                alignment: Alignment.center, // Center this group
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Take minimal horizontal space
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '123643',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.normal),
                          ),
                          Icon(Icons.lock),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.loop), // Loop icon next to the container
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30, // Adjust size as needed
                      backgroundColor: Colors.blueAccent, // Background color
                      child: Icon(
                        Icons.person,
                        size: 30, // Icon size
                        color: Colors.white, // Icon color
                      ),
                    ),
                    Text('Você'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload_outlined),
                    Text(
                      'Enviar arquivo',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30, // Adjust size as needed
                      backgroundColor: Colors.grey, // Background color
                      child: Icon(
                        Icons.person,
                        size: 30, // Icon size
                        color: Colors.white, // Icon color
                      ),
                    ),
                    Text('Esperando'),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.send),
              Icon(Icons.clear),
            ],
          ),
        ],
      ),
    );
  }
}
