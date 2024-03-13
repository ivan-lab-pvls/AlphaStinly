import 'package:education_app/views/home/widgets/star_rating_rep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';

class ShortUniInfoWidget extends StatelessWidget {
  final String name;
  final String address;
  final int rating;
  final VoidCallback onTap;

  ShortUniInfoWidget({
    required this.name,
    required this.address,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.lightGreyColor,
        child: Padding(
          padding: EdgeInsets.all(
            size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SvgPicture.asset('assets/icons/hat.svg'),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              Text(name, style: HomeScreenTextStyle.name),
              SizedBox(
                height: size.height * 0.008,
              ),
              Text(
                address,
                style: HomeScreenTextStyle.address,
              ),
              SizedBox(
                height: size.height * 0.008,
              ),
              Row(
                children: [
                  StarRatingRep(
                    rating: rating,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      'assets/icons/arrow.svg',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
