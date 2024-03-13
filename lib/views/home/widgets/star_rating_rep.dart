import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef RatingChangeCallback = void Function(int rating);

class StarRatingRep extends StatelessWidget {
  final int rating;

  const StarRatingRep({
    super.key,
    required this.rating,
  });

  Widget buildStar(int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SvgPicture.asset(
        index < rating ? 'assets/icons/full_star.svg' : 'assets/icons/star.svg',
        height: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => buildStar(index + 1)),
    );
  }
}
