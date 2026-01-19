import 'package:flutter/material.dart';
import 'package:flutter_application/interfaces/payloads/contract_payload.dart';
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

  late Future<List<Operator>> _allOperatorsInitialFuture;

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
    _allOperatorsInitialFuture = _operatorService.getOperatorFiltered(
      activities: [],
    );

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
      backgroundColor: const Color(0xFFFBFBFB),
      body: StickyContainer(
        stickyChildren: [
          StickyWidget(
            initialPosition: StickyPosition(top: 50, right: 20),
            finalPosition: StickyPosition(top: 20, right: 20),
            controller: _singleChildScrollViewController,
            child: const UserAvatarMenuWidget(),
          ),
        ],
        child: SingleChildScrollView(
          controller: _singleChildScrollViewController,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                "Operatori",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.brown,
                ),
              ),
              const Text(
                "Trova i migliori professionisti per le tue escursioni",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Toolbar Filtri
              FutureBuilder<List<Operator>>(
                future: _allOperatorsInitialFuture,
                builder: (context, snapshot) {
                  // Se non ci sono dati, mostriamo una barra vuota o un caricamento leggero
                  if (!snapshot.hasData) return const SizedBox(height: 50);

                  // Estraiamo tutte le attività disponibili dai dati
                  final  allActivities =
                      snapshot.data!
                          .expand((op) => op.activities ?? [])
                          .map((a) => a.name as String)
                          .toSet()
                          .toList();

                  return Row(
                    children: [
                      // PARTE SINISTRA: CHIP SCORREVOLI
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children:
                                allActivities.map((activity) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: FilterChip(
                                      label: Text(activity),
                                      selected: selectedFilters.contains(
                                        activity,
                                      ),
                                      onSelected:
                                          (val) => setState(() {
                                            val
                                                ? selectedFilters.add(activity)
                                                : selectedFilters.remove(
                                                  activity,
                                                );
                                          }),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // PARTE DESTRA: BOTTONE OVERLAY
                      IconButton.filled(
                        onPressed: _overlayController.toggle,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Passiamo lo snapshot.data qui dentro
                        icon: OverlayPortal(
                          controller: _overlayController,
                          overlayChildBuilder:
                              (ctx) => _buildFilterOverlay(allActivities),
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Lista Operatori
              FutureBuilder<List<Operator>>(
                future: _operatorService.getOperatorFiltered(
                  activities: selectedFilters,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Nessun operatore trovato"),
                    );
                  }

                  return Column(
                    children:
                        snapshot.data!
                            .map(
                              (op) => GeneralOperatorCardWidget(
                                title: op.name,
                                subtitle: op.description,
                                phone: op.phone,
                                email: op.email,
                                website: op.website,
                                activities: op.activities,
                                zones: op.zones,
                                onClick:
                                    () => Navigator.of(
                                      context,
                                    ).push(_createRoute(op.id)),
                              ),
                            )
                            .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(index: 1),
    );
  }

  Widget _buildFilterOverlay(List<String> data) {

    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: FilterCard(
        filterValues: data,
        filters: selectedFilters,
        onConfirm: () {
          setState(() {});
          _overlayController.hide();
        },
        onCancel: _overlayController.hide,
      ),
    );
  }
}
