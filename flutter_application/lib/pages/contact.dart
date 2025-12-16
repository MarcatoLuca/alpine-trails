import 'package:flutter/material.dart';
import 'package:flutter_application/interfaces/payloads/contract_payload.dart';
import 'package:flutter_application/models/activity.dart';
import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/pages/sub/operator.dart';
import 'package:flutter_application/providers/pagenotifier.dart';
import 'package:flutter_application/services/domain/operator.service.dart';
import 'package:flutter_application/widgets/contact/generaloperatorcard.dart';
import 'package:flutter_application/widgets/contact/filtercard.dart';
import 'package:logger/logger.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:flutter_application/widgets/useravatarmenu.dart';
import 'package:provider/provider.dart';

import '../widgets/navbar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final Logger logger = Logger();
  final _operatorService = OperatorService();
  late final ScrollController _singleChildScrollViewController;
  late final ScrollController _listViewController;
  final _overlayController = OverlayPortalController();
  late List<String> selectedFilters = <String>[];

  void _onConfirmFilters() {
    setState(() {});

    _overlayController.hide();
  }

  Route _createRoute(int operatorId) {
    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) =>
              OperatorDetails(id: operatorId),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final Animation<double> curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastEaseInToSlowEaseOut,
        );

        return ScaleTransition(scale: curvedAnimation, child: child);
      },
    );
  }

  @override
  void initState() {
    final pageNotifier = Provider.of<PageNotifier>(context, listen: false);
    final payload = pageNotifier.payload;

    if (payload is ContractPayload) {
      selectedFilters = payload.filters;
    } else {
      selectedFilters = [];
    }

    _singleChildScrollViewController = ScrollController();
    _listViewController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _singleChildScrollViewController.dispose();
    _listViewController.dispose();

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
            controller: _singleChildScrollViewController,
            child: UserAvatarMenuWidget(),
          ),
        ],
        child: SingleChildScrollView(
          controller: _singleChildScrollViewController,
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 96),
                child: FutureBuilder(
                  future: _operatorService.getOperatorFiltered(
                    activities: selectedFilters,
                  ),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Operator>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      logger.e('Error loading map markers: ${snapshot.error}');
                      return const Center(child: Text('Error loading data'));
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 80.0,
                            child: StickyContainer(
                              stickyChildren: [
                                StickyWidget(
                                  initialPosition: StickyPosition(
                                    top: 23,
                                    right: 0,
                                  ),
                                  finalPosition: StickyPosition(
                                    top: 23,
                                    right: 0,
                                  ),
                                  controller: _listViewController,
                                  child: SizedBox(
                                    width: 40,
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(0.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onPressed: _overlayController.toggle,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.filter_alt),
                                          OverlayPortal(
                                            controller: _overlayController,
                                            overlayChildBuilder: (
                                              BuildContext context,
                                            ) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 128,
                                                    ),

                                                child: FilterCard(
                                                  filterValues:
                                                      snapshot.data!
                                                          .expand(
                                                            (op) =>
                                                                op.activities ??
                                                                const <
                                                                  Activity
                                                                >[],
                                                          )
                                                          .map(
                                                            (activity) =>
                                                                activity.name,
                                                          )
                                                          .toSet()
                                                          .toList(),
                                                  filters: selectedFilters,
                                                  onConfirm: _onConfirmFilters,
                                                  onCancel:
                                                      () =>
                                                          _overlayController
                                                              .hide(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              child: Padding(
                                padding: const EdgeInsets.only(right: 48.0),
                                child: ListView(
                                  controller: _listViewController,
                                  scrollDirection: Axis.horizontal,
                                  children:
                                      snapshot.data!
                                          .expand(
                                            (op) =>
                                                op.activities ??
                                                const <Activity>[],
                                          )
                                          .map((activity) => activity.name)
                                          .toSet()
                                          .map((activity) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 3.0,
                                                  ),
                                              child: FilterChip(
                                                label: Text(activity),
                                                selected: selectedFilters
                                                    .contains(activity),
                                                onSelected: (bool selected) {
                                                  setState(() {
                                                    if (selected) {
                                                      selectedFilters.add(
                                                        activity,
                                                      );
                                                    } else {
                                                      selectedFilters.remove(
                                                        activity,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                            );
                                          })
                                          .toList(),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            spacing: 16,
                            children:
                                snapshot.data!
                                    .map(
                                      (op) => GeneralOperatorCardWidget(
                                        title: op.name,
                                        onClick:
                                            () => Navigator.of(
                                              context,
                                            ).push(_createRoute(op.id)),
                                        subtitle: op.description,
                                        phone: op.phone,
                                        email: op.email,
                                        website: op.website,
                                        activities: op.activities,
                                        zones: op.zones,
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      );
                    }
                    return const Center(child: Text('No data available.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(index: 1),
    );
  }
}
