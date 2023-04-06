import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {

  final String titleTxt;
  final String subTxt;
  final VoidCallback onTab;

  const TitleView({Key? key, required this.titleTxt, required this.subTxt, required this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
              titleTxt,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5
              ),
              textAlign: TextAlign.left,
            )
        ),
        InkWell(
          highlightColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          onTap: onTab,
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Row(
              children: [
                Text(subTxt,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 38,
                  width: 14,
                  child: Icon(Icons.arrow_forward_ios_sharp, size: 12),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
