import 'package:flutter/material.dart';
import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/services/domain/operator.service.dart';
import 'package:flutter_application/widgets/contact/detailsoperatorcard.dart';
import 'package:logger/logger.dart';

class OperatorDetails extends StatefulWidget {
  const OperatorDetails({super.key, required this.id});

  final int id;

  @override
  State<OperatorDetails> createState() => _OperatorDetailsState();
}

class _OperatorDetailsState extends State<OperatorDetails> {
  bool _isFavorite = false;
  final _operatorService = OperatorService();
  final Logger logger = Logger();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 8,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Operator Details",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _toggleFavorite(),
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    isSelected: _isFavorite,
                    selectedIcon: Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _operatorService.getOperatorById(widget.id),
              builder: (
                BuildContext context,
                AsyncSnapshot<Operator?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  logger.e('Error loading map markers: ${snapshot.error}');
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          DetailsOperatorCardWidget(
                            title: snapshot.data!.name,
                            subtitle: snapshot.data!.description,
                            phone: snapshot.data!.phone,
                            email: snapshot.data!.email,
                            website: snapshot.data!.website,
                            image: 'https://picsum.photos/id/237/300/300',
                            rate: 4.5,
                            ratings: 128,
                            // availability: snapshot.data!.availability,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: Text('No data available.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
