import 'package:education_app/views/app/widgets/input_widget.dart';
import 'package:education_app/views/constructor/view/specielties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/university_info.dart';
import '../../app/widgets/chosen_action_button_widget.dart';

class ProsAndConsScreen extends StatefulWidget {
  final UniversityInfo universityInfo;

  ProsAndConsScreen({required this.universityInfo});

  @override
  _ProsAndConsScreenState createState() => _ProsAndConsScreenState();
}

class _ProsAndConsScreenState extends State<ProsAndConsScreen> {
  List<TextEditingController> _prosControllers = [TextEditingController()];
  List<TextEditingController> _consControllers = [TextEditingController()];

  void _addNewProConField(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int numberOfTextFields = _prosControllers.length + _consControllers.length;
    double spacerHeight =
        size.height * 0.55 - (numberOfTextFields * size.height * 0.11);
    if (spacerHeight < 0) {
      spacerHeight = 0;
    }
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: Padding(
        padding: EdgeInsets.only(
          bottom: size.height * 0.015,
        ),
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.015,
                    left: size.width * 0.025,
                    right: size.width * 0.025,
                    bottom: size.height * 0.015,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'New university',
                              style: ConstructorTextStyle.title,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            const Text(
                              'Pros',
                              style: ConstructorTextStyle.lable,
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () =>
                                  _addNewProConField(_prosControllers),
                              child: const Text(
                                'Add more',
                                style: ConstructorTextStyle.add,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                          ],
                        ),
                        for (var controller in _prosControllers)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.015,
                            ),
                            child: InputWidget(controller: controller),
                          ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            const Text(
                              'Cons',
                              style: ConstructorTextStyle.lable,
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () =>
                                  _addNewProConField(_consControllers),
                              child: const Text(
                                'Add more',
                                style: ConstructorTextStyle.add,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                          ],
                        ),
                        for (var controller in _consControllers)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.015,
                            ),
                            child: InputWidget(controller: controller),
                          ),
                        Container(
                          height: spacerHeight,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.025,
                          ),
                          child: ChosenActionButton(
                            text: 'Continue',
                            onTap: () {
                              bool prosFilled = _prosControllers.any(
                                  (controller) => controller.text.isNotEmpty);
                              bool consFilled = _consControllers.any(
                                  (controller) => controller.text.isNotEmpty);

                              if (prosFilled && consFilled) {
                                widget.universityInfo.pros = _prosControllers
                                    .map((c) => c.text)
                                    .toList();
                                widget.universityInfo.cons = _consControllers
                                    .map((c) => c.text)
                                    .toList();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SpecialtiesScreen(
                                      universityInfo: widget.universityInfo,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please add at least one pro and one con before continuing.',
                                      style: ConstructorTextStyle.snackBar,
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
