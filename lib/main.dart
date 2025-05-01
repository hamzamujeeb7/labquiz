import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation with Logos',
      home: LogoListScreen(),
    );
  }
}

class LogoListScreen extends StatelessWidget {
  LogoListScreen({super.key});
  final List<Map<String, String>> logos = [
    {'name': 'Facebook', 'path': 'images/facebook.png'},
    {'name': 'Instagram', 'path': 'images/instagram.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    timeDilation = 15.0;
    return Scaffold(
      appBar: AppBar(title: Text('Social Logos')),
      body: ListView.builder(
        itemCount: logos.length,
        itemBuilder: (context, index) {
          final logo = logos[index];
          return ListTile(
            leading: Hero(
              tag: logo['name']!,

              child: Image.asset(logo['path']!),
            ),
            title: Text(logo['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => LogoDetailScreen(
                        name: logo['name']!,
                        path: logo['path']!,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LogoDetailScreen extends StatelessWidget {
  final String name;
  final String path;

  const LogoDetailScreen({super.key, required this.name, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Hero(tag: name, child: Image.asset(path))),
    );
  }
}
