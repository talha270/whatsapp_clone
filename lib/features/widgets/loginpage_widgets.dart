import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/controllers/login_page_controller.dart';

import '../app/theme/style.dart';

Widget buildDialogItem(Country country) {
  return Container(
    height: 40,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white10, width: 1.5),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        Text(" +${country.phoneCode}"),
        Expanded(
            child: Text(
              " ${country.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        const Spacer(),
        const Icon(Icons.arrow_drop_down)
      ],
    ),
  );
}

void openFilteredCountryPickerDialog() {
  final controller=Get.find<LoginPageController>();
  showDialog(
    context: Get.context!,
    builder: (context) => CountryPickerDialog(
      searchInputDecoration: const InputDecoration(
        hintText: "Search",
      ),
      searchCursorColor: tabColor,
      // isDividerEnabled: true,
      isSearchable: true,
      itemBuilder: (country) => buildDialogItem(country),
      titlePadding: const EdgeInsets.all(8.0),
      title: const Text("Select your phone code"),
      onValuePicked: (country) {
        LoginPageController.selectedfiltereddialogcountry.value = country;
        controller.countrycode.value = country.phoneCode;
        }
      ),
  );
}
