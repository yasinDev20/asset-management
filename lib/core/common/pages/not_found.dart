import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 - Not Found')),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Halaman tidak ditemukan'),
            ElevatedButton(onPressed: () {
              context.go('/');
            }, child: Text('Home'))
          ],
        ),
        
      ),
    );
  }
}
