import 'package:flutter/material.dart';
import 'package:flutter_application/models/helloworld.dart';
import 'package:flutter_application/services/domain/helloworld_service.dart';

class HelloWorldWidget extends StatefulWidget {
  const HelloWorldWidget({super.key});

  @override
  State<HelloWorldWidget> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorldWidget> {
  HelloWorld? helloWorld;

  Future<void> _loadHelloWorld() async {
    final helloWorldService = HelloWorldService();
    helloWorld = await helloWorldService.getHelloWorld();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadHelloWorld(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (helloWorld == null) {
          return const Center(child: Text('No data available'));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              helloWorld!.message ?? 'No message available',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        );
      },
    );
  }
}
