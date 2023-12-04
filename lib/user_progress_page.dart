import 'package:flutter/material.dart';
import 'user_progress.dart';

class UserProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Progress'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: UserProgress.getUserProgressList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No completed levels.'));
          } else {
            List<Map<String, dynamic>> progressList =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: progressList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> progress = progressList[index];

                // Convert Color to integer value
                int colorValue = (progress['color'] as Color).value;

                return ListTile(
                  title: Text('Level ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Red: ${progress['red']}, Green: ${progress['green']}, Blue: ${progress['blue']}',
                      ),
                      Text(
                        'Slider 1: ${progress['slider1']}',
                      ),
                      Text(
                        'Slider 2: ${progress['slider2']}',
                      ),
                      Text(
                        'Slider 3: ${progress['slider3']}',
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
