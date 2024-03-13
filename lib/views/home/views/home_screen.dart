import 'package:education_app/views/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/university_info.dart';
import '../../../util/app_routes.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../constructor/view/basic_info.dart';
import '../widgets/short_info_widget.dart';
import 'full_info_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UniversityInfo> universities = [];

  @override
  void initState() {
    super.initState();
    _loadUniversities();
  }

  void _onAddComplete() {
    _loadUniversities();
  }

  Future<void> _loadUniversities() async {
    List<UniversityInfo> loadedUniversities =
        await UniversityPreferences().loadUniversityList();
    setState(() {
      universities = loadedUniversities;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: size.width * 0.3,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) => const SettingsScreen()));
          },
          child: const Text(
            'Settings',
            style: HomeScreenTextStyle.appbar,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            if (universities.isEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/hat.svg'),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'No university yet',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: HomeScreenTextStyle.subtitlePurple,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        const Text("Add the first university",
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: HomeScreenTextStyle.subtitle),
                      ],
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.005,
                    left: size.width * 0.015,
                    right: size.width * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.005,
                          left: size.width * 0.015,
                          right: size.width * 0.015,
                        ),
                        child: const Text(
                          'Your education',
                          style: HomeScreenTextStyle.banner,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: universities.length,
                          itemBuilder: (context, index) {
                            UniversityInfo uni = universities[index];
                            return ShortUniInfoWidget(
                              name: uni.name,
                              address: uni.address,
                              rating: uni.rating,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullInfoScreen(universityInfo: uni),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ChosenActionButton(
              text: 'Add new university',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfoScreen()),
                ).then((_) => _onAddComplete());
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
