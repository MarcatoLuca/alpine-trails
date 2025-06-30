import 'package:flutter/material.dart';
import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/services/domain/operator.service.dart';
import 'package:flutter_application/widgets/bigcard.dart';
import 'package:logger/logger.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:flutter_application/widgets/useravatarmenu.dart';

import '../widgets/navbar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final Logger logger = Logger();
  final _operatorService = OperatorService();
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
    return Scaffold(
      body: StickyContainer(
        stickyChildren: [
          StickyWidget(
            initialPosition: StickyPosition(top: 20, right: 20),
            finalPosition: StickyPosition(top: 20, right: 20),
            controller: _controller,
            child: UserAvatarMenuWidget(),
          ),
        ],
        child: SingleChildScrollView(
          controller: _controller,
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Stack(
            children: [
              Column(
                spacing: 32,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 96),
                    child: FutureBuilder(
                      future: _operatorService.getOperatorAll(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<Operator>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          logger.e(
                            'Error loading map markers: ${snapshot.error}',
                          );
                          return const Center(
                            child: Text('Error loading data'),
                          );
                        } else if (snapshot.hasData) {
                          return Column(
                            spacing: 16,
                            children:
                                snapshot.data!
                                    .map(
                                      (op) => BigCardWidget(
                                        title: op.name,
                                        subtitle: op.description,
                                        phone: op.phone,
                                        email: op.email,
                                        website: op.website,
                                        activities: op.activities,
                                        zones: op.zones,
                                      ),
                                    )
                                    .toList(),
                          );
                        }
                        return const Center(child: Text('No data available.'));
                      },
                    ),
                  ),
                ],
              ),

              // Alwasy last Stack widget
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(index: 1),
    );
  }
}
