import 'package:flutter/material.dart';
import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/services/domain/operator.service.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:logger/logger.dart';

class OperatorDetails extends StatefulWidget {
  const OperatorDetails({super.key, required this.id});

  final int id;

  @override
  State<OperatorDetails> createState() => _OperatorDetailsState();
}

class _OperatorDetailsState extends State<OperatorDetails> {
  final _operatorService = OperatorService();
  final Logger logger = Logger();
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        spacing: 8,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          FutureBuilder(
            future: _operatorService.getOperatorById(widget.id),
            builder: (BuildContext context, AsyncSnapshot<Operator?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                logger.e('Error loading map markers: ${snapshot.error}');
                return const Center(child: Text('Error loading data'));
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: StickyContainer(
                    stickyChildren: [
                      StickyWidget(
                        initialPosition: StickyPosition(
                          left: 0,
                          bottom: 20,
                        ),
                        finalPosition: StickyPosition(
                          left: 0,
                          bottom: 20,
                        ),
                        controller: _controller,
                        child: FilledButton.icon(
                          onPressed: () {},
                          label: const Text('Book an activity'),
                          icon: const Icon(Icons.calendar_today),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              spacing: 24,
                              children: [
                                Icon(
                                  Icons.account_circle_sharp,
                                  size: 64,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: Text('No data available.'));
            },
          ),
        ],
      ),
    );
  }
}
