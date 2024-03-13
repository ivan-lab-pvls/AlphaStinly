import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../app/views/ReadPageForUsers.dart';
import '../widgets/settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.12,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.015),
                child: const Text(
                  'Settings',
                  style: SettingsTextStyle.title,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                text: 'Terms of use',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const WebPageForUsersDocumentaries(url: 'https://docs.google.com/document/d/1GQB8qmZ0OOz2R_s8Y8jsBese35A46dMXqg2PwUtLwCQ/edit?usp=sharing'),
                    ),
                  );
                },
                assetName: 'assets/icons/terms_of_use.svg',
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const WebPageForUsersDocumentaries(url: 'https://docs.google.com/document/d/1mkYNWElY65IHPmju9fkQtOn2X43GN3kY5OWi20PoCDM/edit?usp=sharing'),
                      ),
                    );
                  },
                  assetName: 'assets/icons/privacy_policy.svg'),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Support page',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const WebPageForUsersDocumentaries(url: 'https://docs.google.com/forms/d/e/1FAIpQLSc88_XWuAoDVWALJA2XIyve9FY-R559noVdCW1NbmjKLMSFFw/viewform?usp=sf_link'),
                      ),
                    );
                  },
                  assetName: 'assets/icons/support_page.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
