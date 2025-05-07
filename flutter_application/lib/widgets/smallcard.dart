import 'package:flutter/material.dart';

class SmallCardWidget extends StatelessWidget {
  const SmallCardWidget({
    super.key,
    required this.id,
    required this.text,
    this.backgroundImage,
  });

  final String id;
  final String text;
  final String? backgroundImage;
  // final void onTap;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.black,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          height: height / 10,
          width: width,
          child: Stack(
            children: [
              if (backgroundImage != null)
                Image(
                  width: width,
                  image: AssetImage(backgroundImage!),
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(.95),
                ),

              Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
