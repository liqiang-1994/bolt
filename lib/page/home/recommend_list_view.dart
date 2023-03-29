import 'package:bolt/bean/recommend_entity.dart';
import 'package:flutter/material.dart';

class RecommendListView extends StatelessWidget {
  const RecommendListView({Key? key, this.callback, this.recommendEntity, this.animationController, this.animation}) : super(key: key);

  final VoidCallback? callback;
  final RecommendEntity? recommendEntity;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 5, bottom: 16),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(4, 4),
                          blurRadius: 16
                        )
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.asset(recommendEntity!.imageUrl, fit: BoxFit.cover),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recommendEntity!.title,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            recommendEntity!.subTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black.withOpacity(0.8)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
