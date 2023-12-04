import 'package:flutter/material.dart';
import 'user_progress.dart';

class UserProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Colors'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: UserProgress.getUserProgressList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No saved colors.'));
          } else {
            // Add debug statements here to inspect the data
            print('Saved Colors Data: ${snapshot.data}');
            List<Map<String, dynamic>> progressList =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: progressList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> progress = progressList[index];

                // Convert Color to integer value
                int colorValue = (progress['color'] as Color).value;

                return ListTile(
                  title: Text('Color ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Red: ${progress['red']}',
                      ),
                      Text(
                        'Green: ${progress['green']}',
                      ),
                      Text(
                        'Blue: ${progress['blue']}',
                      ),
                    ],
                  ),
                  leading: Container(
                    width: 30,
                    height: 30,
                    color: progress['color'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
