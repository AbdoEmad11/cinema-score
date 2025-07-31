import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;

  // Constructor for ProfilePage, requiring name and email
  ProfilePage({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'), // Title of the AppBar
        // No action icons in AppBar to avoid duplication with body buttons
      ),
      body: Center(
        child: SingleChildScrollView( // Allows content to scroll if it overflows
          padding: const EdgeInsets.all(20.0), // Padding around the entire content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User's profile image
              const CircleAvatar(
                radius: 60, // Larger radius for a more prominent avatar
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
                backgroundColor: Colors.blueGrey, // Background color if image fails to load
              ),
              const SizedBox(height: 25), // Spacing below the avatar

              // User's name
              const Text(
                'Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15), // Spacing between name and email

              // User's email
              const Text(
                'Email:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40), // Spacing before the action buttons

              // Action buttons column
              Column(
                children: [
                  // Settings Button
                  SizedBox(
                    width: double.infinity, // Make button take full width
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement navigation to settings page
                        print('Navigate to Settings Page');
                      },
                      icon: const Icon(Icons.settings,color: Colors.white,),
                      label: const Text('Settings', style: TextStyle(fontSize: 18,color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners for button
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // Spacing between buttons

                  // Watchlist Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement navigation to watchlist page
                        print('Navigate to Watchlist Page');
                      },
                      icon: const Icon(Icons.list,color: Colors.white),
                      label: const Text('Watchlist', style: TextStyle(fontSize: 18,color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // Spacing between buttons

                  // Edit Profile Button (renamed from 'Profile' for clarity)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement navigation to edit profile page
                        print('Navigate to Edit Profile Page');
                      },
                      icon: const Icon(Icons.person,color: Colors.white),
                      label: const Text('Edit Profile', style: TextStyle(fontSize: 18,color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // Spacing between buttons

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement logout functionality
                        print('User Logout');
                        // Example: Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue.shade400, // Distinct color for logout button
                        foregroundColor: Colors.white, // Text color for logout button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
