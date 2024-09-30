import 'package:bill_maker/local/key_id.dart';
import 'package:bill_maker/models/contact_model.dart';
import 'package:bill_maker/services/contact_services.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:bill_maker/widgets/settings_card.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double clickId = 0;
  bool isVisible = false;

  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController idStartTo = TextEditingController();

  List<ContactModel> _contactInfo = [];

  Future<void> _getAllData() async {
    final data = await ContactServices().getContactInfo();
    setState(() {
      _contactInfo = data;
    });
  }

  Future<void> _addNewData() async {
    await ContactServices().addContactInfo("info@gmail.com", "+94 xxxxxxxxxx");
     
  }

  @override
  void initState() {
    super.initState();
    _getAllDataAndCheck();
  }

  Future<void> _getAllDataAndCheck() async {
    await _getAllData();
    if (_contactInfo.isEmpty) {
      await _addNewData();
      await _getAllData();
    } else {
      email.text = _contactInfo[0].email;
      number.text = _contactInfo[0].number;
    }
  }

  Future<void> _updateEmail() async {
    ContactServices().updateContactInfo(
        _contactInfo[0].id.toString(), email.text, _contactInfo[0].number);
  }

  Future<void> _updatePassword() async {
    ContactServices().updateContactInfo(
        _contactInfo[0].id.toString(), _contactInfo[0].email, number.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Srttings",
              style: AppStyle().title.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
            20.ph,
            SettingsCard(
              hintName: "Email",
              controller: email,
              callback: () {
                if (email.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Try again later !'),
                    ),
                  );
                } else {
                  _updateEmail();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Done !'),
                    ),
                  );
                }
              },
            ),
            SettingsCard(
              hintName: "Number",
              controller: number,
              callback: () {
                if (number.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Try again later !'),
                    ),
                  );
                } else {
                  _updatePassword();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Done !'),
                    ),
                  );
                }
              },
            ),
            SettingsCard(
              hintName: "Invoice reset ",
              controller: idStartTo,
              callback: () {
                if (idStartTo.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Try again later !'),
                    ),
                  );
                } else {
                  InvoiceId().saveId(int.parse(idStartTo.text));
                  idStartTo.text == "";
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Done !'),
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
