import 'package:flutter/material.dart';
import 'details_screen.dart'; // 👈 Импортируем второй экран

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Studymate',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Добро пожаловать 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Следи за учёбой с умом!',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Карточки разделов
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.schedule,
                    title: 'Расписание',
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.pushNamed(context, '/schedule');
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.assignment_turned_in,
                    title: 'Дедлайны',
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.pushNamed(context, '/deadlines');
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.grade,
                    title: 'Оценки',
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.pushNamed(context, '/grades');
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.notes,
                    title: 'Конспекты',
                    color: Colors.greenAccent,
                    onTap: () {
                      Navigator.pushNamed(context, '/notes');
                    },
                  ),
                ],
              ),
            ),

            // 🔘 Кнопка перехода на экран деталей
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsScreen(),
                    ),
                  );
                },
                child: const Text('Перейти на экран деталей'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 48),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
