import 'package:education_app/views/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/university_info.dart';
import '../../../util/app_routes.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';
import '../widget/specialty_priority_widget.dart';

class SpecialtiesScreen extends StatefulWidget {
  final UniversityInfo universityInfo;

  SpecialtiesScreen({Key? key, required this.universityInfo}) : super(key: key);

  @override
  _SpecialtiesScreenState createState() => _SpecialtiesScreenState();
}

class _SpecialtiesScreenState extends State<SpecialtiesScreen> {
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  int _priority = 0;

  @override
  void dispose() {
    _specialtyController.dispose();
    _costController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _saveUniversityInfo() async {
    List<UniversityInfo> universityList =
        await UniversityPreferences().loadUniversityList();
    universityList.add(widget.universityInfo);
    await UniversityPreferences().saveUniversityList(universityList);
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => HomeScreen()));
  }

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'New university',
              style: ConstructorTextStyle.title,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'Name of the specialization',
              style: ConstructorTextStyle.subtitle,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            InputWidget(controller: _specialtyController),
            SizedBox(height: size.height * 0.02),
            Text(
              'Priority',
              style: ConstructorTextStyle.subtitle,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            SpecialtyPriority(
              onPriorityChanged: (priority) {
                setState(() {
                  _priority = priority;
                });
              },
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Tuition fees',
              style: ConstructorTextStyle.subtitle,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            InputWidget(
                controller: _costController,
                keyboardType: TextInputType.number),
            SizedBox(height: size.height * 0.02),
            Text(
              'Years of study',
              style: ConstructorTextStyle.subtitle,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            InputWidget(
                controller: _durationController,
                keyboardType: TextInputType.number),
            const Spacer(),
            ChosenActionButton(
              text: 'Save',
              onTap: () {
                if (_specialtyController.text.isNotEmpty &&
                    _costController.text.isNotEmpty &&
                    _durationController.text.isNotEmpty) {
                  Specialty specialty = Specialty(
                      name: _specialtyController.text, priority: _priority);
                  widget.universityInfo.specialty = specialty;
                  widget.universityInfo.cost = _costController.text;
                  widget.universityInfo.duration = _durationController.text;
                  _saveUniversityInfo();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please fill in all the fields before saving.',
                        style: ConstructorTextStyle.snackBar,
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
