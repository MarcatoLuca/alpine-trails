import 'package:flutter/material.dart';

class GalleryDialog extends StatelessWidget {
  final List<String> images;

  const GalleryDialog({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.6;

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(20), 
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gallery",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return _ZoomableImageItem(imageUrl: images[index]);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZoomableImageItem extends StatefulWidget {
  final String imageUrl;

  const _ZoomableImageItem({required this.imageUrl});

  @override
  State<_ZoomableImageItem> createState() => _ZoomableImageItemState();
}

class _ZoomableImageItemState extends State<_ZoomableImageItem> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              Container(color: Colors.black54),
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl.isNotEmpty
                          ? widget.imageUrl
                          : 'https://picsum.photos/200',
                      width:
                          MediaQuery.of(context).size.width *
                          0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    // Inserisce l'overlay sopra tutto
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _showOverlay(context),
      onLongPressEnd: (_) => _removeOverlay(),
      // Se vuoi che cliccando normalmente non succeda nulla o apra un dettaglio diverso:
      onTap: () {
        // Opzionale: gestire il click singolo se vuoi
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.imageUrl.isNotEmpty
              ? widget.imageUrl
              : 'https://picsum.photos/200',
          fit: BoxFit.cover,
          errorBuilder:
              (_, __, ___) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.error),
              ),
        ),
      ),
    );
  }
}
