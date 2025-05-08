import 'package:flutter/material.dart';

class UserAvatarMenuWidget extends StatefulWidget {
  const UserAvatarMenuWidget({super.key});

  @override
  State<UserAvatarMenuWidget> createState() => _UserAvatarMenuWidgetState();
}

class _UserAvatarMenuWidgetState extends State<UserAvatarMenuWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: 0.2, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double menuButtonWidth = width * 0.3;

    void toogleMenu() {
      setState(() {
        isMenuOpen = !isMenuOpen;
      });

      if (isMenuOpen) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }

    if (isMenuOpen) {
      return Positioned(
        top: 0,
        child: SizedBox(
          height: height,
          width: width,
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 24,
                  children: [
                    SizedBox(
                      width: menuButtonWidth,
                      height: 48,
                      child: TextButton(
                        child: Text(
                          'Profilo',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: menuButtonWidth,
                      height: 48,
                      child: TextButton(
                        child: Text(
                          'Impostazioni',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: menuButtonWidth,
                      height: 48,
                      child: TextButton(
                        child: Text(
                          'Esci',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 150,
                  child: Transform.scale(
                    scale: animation.value,
                    child: IconButton(
                      onPressed: () => toogleMenu(),
                      icon: Icon(Icons.cancel, size: 48),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        alignment: Alignment.centerRight,
        height: 48,
        margin: EdgeInsets.only(top: 24),
        child: SizedBox(
          height: 56,
          width: 56,
          child: CircleAvatar(
            child: IconButton(
              onPressed: () => toogleMenu(),
              icon: Icon(Icons.person),
            ),
          ),
        ),
      ),
    );
  }
}
