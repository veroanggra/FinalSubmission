import 'package:flutter/material.dart';

class ImageHero extends StatelessWidget {
  ImageHero({Key key, this.tag, this.image, this.onTap, this.width})
      : super(key: key);

  final String tag;
  final String image;
  final double width;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: tag,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
