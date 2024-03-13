import 'package:education_app/views/app/widgets/input_widget.dart';
import 'package:education_app/views/constructor/view/pros_and_cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/university_info.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../widget/rating_widget.dart';

class BasicInfoScreen extends StatefulWidget {
  @override
  _BasicInfoScreenState createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Back',
          style: ConstructorTextStyle.appBar,
        ),
        titleSpacing: -5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.015,
            left: size.width * 0.025,
            right: size.width * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'New university',
                style: ConstructorTextStyle.title,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'University name',
                style: ConstructorTextStyle.subtitle,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              InputWidget(controller: _nameController),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'University location',
                style: ConstructorTextStyle.subtitle,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              InputWidget(controller: _addressController),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Description of the University',
                style: ConstructorTextStyle.subtitle,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              InputWidget(controller: _descriptionController),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.lightGreyColor,
                ),
                height: size.height * 0.12,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    left: size.width * 0.025,
                    right: size.width * 0.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Rating of university reviews',
                        style: ConstructorTextStyle.rating,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      StarRating(
                        rating: _rating,
                        onRatingChanged: (rating) =>
                            setState(() => _rating = rating),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              ChosenActionButton(
                text: 'Continue',
                onTap: () {
                  if (_nameController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _rating > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProsAndConsScreen(
                          universityInfo: UniversityInfo(
                            name: _nameController.text,
                            address: _addressController.text,
                            description: _descriptionController.text,
                            rating: _rating,
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please fill in all the fields before continuing.',
                          style: ConstructorTextStyle.snackBar,
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
