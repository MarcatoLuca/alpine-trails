import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({
    super.key,
    required this.filterValues,
    required this.filters,
    required this.onConfirm,
    this.onCancel,
  });

  final List<String> filterValues;
  final List<String> filters;
  final Function() onConfirm;
  final Function()? onCancel;

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
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

    return Card(
      child: StickyContainer(
        stickyChildren: [
          StickyWidget(
            initialPosition: StickyPosition(left: width / 2 - 80, bottom: 20),
            finalPosition: StickyPosition(left: width / 2 - 80, bottom: 20),
            controller: _controller,
            child: FilledButton(
              onPressed: widget.onConfirm,
              child: const Text('Confirm'),
            ),
          ),
        ],
        child: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 24,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter by activity',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (widget.onCancel != null)
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: widget.onCancel,
                        iconSize: 24,
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                        widget.filterValues
                            .map(
                              (activity) => FilterChip(
                                label: Text(activity),
                                selected: widget.filters.contains(activity),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      widget.filters.add(activity);
                                    } else {
                                      widget.filters.remove(activity);
                                    }
                                  });
                                },
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
