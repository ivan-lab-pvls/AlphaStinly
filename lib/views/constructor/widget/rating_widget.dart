import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef RatingChangeCallback = void Function(int rating);

class StarRating extends StatelessWidget {
  final int rating;
  final RatingChangeCallback onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  Widget buildStar(int index) {
    return GestureDetector(
      onTap: () => onRatingChanged(index + 1),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SvgPicture.asset(
          index < rating
              ? 'assets/icons/full_star.svg'
              : 'assets/icons/star.svg',
          height: 27,
        ),
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
