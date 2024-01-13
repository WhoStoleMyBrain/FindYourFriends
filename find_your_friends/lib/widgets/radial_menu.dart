import 'package:find_your_friends/views/group_creation_view.dart';
import 'package:find_your_friends/views/group_overview_view.dart';
import 'package:find_your_friends/views/home_view.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class RadialMenu extends StatefulWidget {
  const RadialMenu({super.key});

  @override
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this)
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({super.key, required this.controller})
      : translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),
        scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  _buildButton(0, color: Colors.red, icon: Icons.group_sharp,
                      onPressed: () {
                    controller.isCompleted
                        ? _navigateTo(context, GroupOverviewView())
                        : null;
                  }),
                  _buildButton(60,
                      color: Colors.green,
                      icon: Icons.house_rounded, onPressed: () {
                    print('Home clicked');
                    controller.isCompleted
                        ? _navigateTo(context, const HomeView())
                        : null;
                  }),
                  _buildButton(120,
                      color: Colors.orange,
                      icon: Icons.location_on_outlined, onPressed: () {
                    controller.isCompleted
                        ? null
                        // ? _navigateTo(context, GroupOverviewView())
                        : null;
                  }),
                  _buildButton(180,
                      color: Colors.blue,
                      icon: Icons.shopping_cart, onPressed: () {
                    controller.isCompleted
                        // ? null
                        ? _navigateTo(context, const GroupCreationView())
                        : null;
                  }),
                  _buildButton(240, color: Colors.brown, icon: Icons.settings,
                      onPressed: () {
                    controller.isCompleted
                        ? null
                        // ? _navigateTo(context, GroupOverviewView())
                        : null;
                  }),
                  _buildButton(300, color: Colors.indigo, icon: Icons.person,
                      onPressed: () {
                    controller.isCompleted
                        ? null
                        // ? _navigateTo(context, GroupOverviewView())
                        : null;
                  }),
                  Transform.scale(
                    scale: scale.value - 1,
                    child: FloatingActionButton(
                        key: GlobalKey(),
                        heroTag: 'Smol Button',
                        onPressed: _close,
                        backgroundColor: Colors.red,
                        child: Transform.rotate(
                            angle: radians(45),
                            child:
                                const Icon(Icons.add_circle_outline_rounded))),
                  ),
                  Transform.scale(
                    scale: scale.value,
                    child: FloatingActionButton(
                        key: GlobalKey(),
                        heroTag: 'Beeg Button',
                        onPressed: _open,
                        child: const Icon(Icons.circle_outlined)),
                  )
                ]),
              ));
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _buildButton(double angle,
      {required Color color,
      required IconData icon,
      required VoidCallback onPressed}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            heroTag: angle.toString(),
            backgroundColor: color,
            onPressed: onPressed,
            child: Icon(icon)));
  }
}
