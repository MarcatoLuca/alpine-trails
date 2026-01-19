import 'package:flutter/material.dart';
import 'package:flutter_application/enums.dart';
import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/services/domain/operator.service.dart';
import 'package:flutter_application/widgets/contact/detailsoperatorcard.dart';
import 'package:flutter_application/widgets/contact/operatorgallery.dart';
import 'package:logger/logger.dart';
import 'dart:math' as math;

class OperatorDetails extends StatefulWidget {
  const OperatorDetails({
    super.key,
    required this.id,
    required this.isFavorite,
    required this.onStatusChanged,
  });
  final int id;
  final bool isFavorite;
  final Function(Operator) onStatusChanged;

  @override
  State<OperatorDetails> createState() => _OperatorDetailsState();
}

class _OperatorDetailsState extends State<OperatorDetails> {
  final _operatorService = OperatorService();
  final Logger logger = Logger();
  late final ScrollController _scrollController;
  bool _isFavorite = false;

  // Immagini di esempio (da sostituire con i dati reali dell'operatore)
  final List<String> _galleryImages = List.generate(
    6,
    (index) => 'https://picsum.photos/seed/${index + 123}/600/400',
  );

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openGallery(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => GalleryDialog(images: _galleryImages),
    );
  }

  void _toogleFavorite() async {
    try {
      Operator? updatedOp;
      if (_isFavorite) {
        updatedOp = await _operatorService.removeOperatorAsFavorite(widget.id);
      } else {
        updatedOp = await _operatorService.addOperatorAsFavorite(widget.id);
      }

      setState(() {
        _isFavorite = !_isFavorite;
      });

      if (updatedOp != null) widget.onStatusChanged(updatedOp);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.brown,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "DETTAGLI OPERATORE",
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toogleFavorite,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.brown,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder(
        future: _operatorService.getOperatorById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Errore nel caricamento"));
          }

          final op = snapshot.data!;
          return SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                DetailsOperatorCardWidget(
                  title: op.name,
                  subtitle: op.description,
                  phone: op.phone,
                  email: op.email,
                  website: op.website,
                  image: 'https://picsum.photos/seed/${op.id}/200',
                  rate: 4.8,
                  ratings: 156,
                  availability: OperatorAvailability.available,
                ),

                const SizedBox(height: 32),
                _buildSectionTitle("Attività"),
                _buildChips(
                  op.activities?.map((a) => a.name).toList() ?? [],
                  isActivity: true,
                ),

                const SizedBox(height: 32),
                _buildSectionTitle("Zone Operative"),
                _buildChips(
                  op.zones?.map((z) => z.name).toList() ?? [],
                  isActivity: false,
                ),

                const SizedBox(height: 32),
                _buildSectionTitle("Galleria"),
                _buildGalleryGrid(context),

                const SizedBox(height: 40),
                _buildBookingAction(context),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget _buildChips(List<String> items, {required bool isActivity}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          items.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                    isActivity
                        ? Colors.brown.withOpacity(0.05)
                        : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      isActivity
                          ? Colors.brown.withOpacity(0.1)
                          : Colors.transparent,
                ),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: isActivity ? Colors.brown : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildGalleryGrid(BuildContext context) {
    int displayCount = math.min(_galleryImages.length, 4);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: displayCount,
      itemBuilder: (context, index) {
        bool isLast = index == 3 && _galleryImages.length > 4;
        return GestureDetector(
          onTap: () => _openGallery(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(_galleryImages[index], fit: BoxFit.cover),
                if (isLast)
                  Container(
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: Text(
                      "+${_galleryImages.length - 4}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingAction(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today_rounded, size: 20),
            label: const Text(
              "PRENOTA ESCURSIONE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user_outlined, size: 14, color: Colors.green),
            SizedBox(width: 6),
            Text(
              "Cancellazione gratuita fino a 24h prima",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
