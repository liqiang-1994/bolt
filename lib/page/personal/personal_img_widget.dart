import 'package:flutter/cupertino.dart';

class PersonalImgWidget extends StatefulWidget {
  const PersonalImgWidget(this.image, {Key? key}) : super(key: key);

  final Image image;

  @override
  State<StatefulWidget> createState() => _PersonalImgStateState();
}


class _PersonalImgStateState extends State<PersonalImgWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(microseconds: 15000));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeIn)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _PersonalAnimateWidget(widget.image, animation: animation);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class _PersonalAnimateWidget extends AnimatedWidget {

  static final _opacityTween = Tween(begin: 0.5, end: 1.0);
  static final _sizeTween = Tween(begin: 290.0, end: 300.0);
  final Image image;

  const _PersonalAnimateWidget(this.image , {Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: image,
        ),
      ),
    );
  }
}

