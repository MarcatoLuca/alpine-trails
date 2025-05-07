import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/smallcard.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<String> entries = <String>[
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
  ];
  List<String> filterEntries = [
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
    'Entry C',
    'Entry A',
    'Entry B',
  ];
  final int fixedItems = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 16, top: 24),
        itemCount: filterEntries.length + fixedItems,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    top: 16,
                  ),
                  child: SearchBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: const Icon(Icons.search),
                    ),
                    onTap: () {},
                    onChanged: (value) {
                      setState(() {
                        filterEntries =
                            entries
                                .where((entry) => entry.startsWith(value))
                                .toList();
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        filterEntries =
                            entries.where((entry) => entry == value).toList();
                      });
                    },
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: SmallCardWidget(
                id: filterEntries[index - fixedItems],
                text: filterEntries[index - fixedItems],
                backgroundImage: 'images/home-carousel-1.png',
              ),
            ),
          );
        },
      ),
    );
  }
}
