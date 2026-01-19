import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({
    super.key,
    required this.filterValues, // Questa deve essere la lista TOTALE
    required this.filters,      // Questi sono quelli selezionati
    required this.onConfirm,
    this.onCancel,
  });

  final List<String> filterValues;
  final List<String> filters;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.7;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 40, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER CON TASTO RESET ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filtra attività", 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)
              ),
              Row(
                children: [
                  // TASTO RESET: Utile se l'utente si incastra
                  TextButton(
                    onPressed: () {
                      setState(() {
                        widget.filters.clear();
                      });
                    },
                    child: const Text("Pulisci", style: TextStyle(color: Colors.brown)),
                  ),
                  if (widget.onCancel != null)
                    IconButton(icon: const Icon(Icons.close), onPressed: widget.onCancel),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- BODY ---
          Flexible(
            child: widget.filterValues.isEmpty 
              ? const Center(child: Text("Nessuna attività disponibile"))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.filterValues.map((activity) {
                      final isSelected = widget.filters.contains(activity);
                      return FilterChip(
                        label: Text(activity),
                        selected: isSelected,
                        selectedColor: Colors.brown.shade100,
                        checkmarkColor: Colors.brown,
                        onSelected: (bool selected) {
                          setState(() {
                            selected 
                              ? widget.filters.add(activity) 
                              : widget.filters.remove(activity);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
          ),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: FilledButton(
              onPressed: widget.onConfirm,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("CONFERMA", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}