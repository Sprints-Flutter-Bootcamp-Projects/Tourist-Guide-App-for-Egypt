class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/onboarding1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content overlay
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 96, 56, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Egypt\'s Wonders',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your Egyptian Adventure Starts Here',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Discover hidden gems and must-see attractions across Egypt.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            bottom: 20, // Distance from the bottom
            right: 20,  // Distance from the right
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next screen
              },
              child: Row(
                mainAxisSize: MainAxisSize.min, // Ensure the row takes minimal space
                children: [
                  Text('Next', style: TextStyle(color: Color(0xFF3E2723)),), // Text on the button
                  SizedBox(width: 10), // Space between text and icon
                  Icon(Icons.chevron_right, color: Color(0xFF3E2723)), // Right arrow icon
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
