import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'dart:html' as html;
import '../../models/countries.dart' as fetch_countries;
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/constants.dart';
import '../../controllers/responsive.dart';
import '../../widgets/buttons.dart';
import '../../widgets/input_fields.dart';
import '../../widgets/profile_pictures.dart';

class PerformerProfileEdit extends StatefulWidget {
  const PerformerProfileEdit({super.key});

  @override
  State<PerformerProfileEdit> createState() => _PerformerProfileEditState();
}

class _PerformerProfileEditState extends State<PerformerProfileEdit> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  final _formKey = GlobalKey<FormState>();
  late bool isBand = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController stageNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController xController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  late Uint8List? bytesData;
  late List<int>? selectedFile;
  late String fileName = "";

  late String selectedGender = "";
  final List<String> genders = ["", "Female", "Male"];

  late String selectedNationality = "";
  late String phoneCode = "";
  late int maxDigits = 1;
  late List<String> nationalities = [
    "",
  ];
  late List<String> subGenre = [];
  late List<String> instrumentsPlayed = [];
  late List<String> preferredEvents = [];
  late String canPlayInstrument = "";

  getCountries() async {
    for (var data in fetch_countries.countries_and_phone_codes) {
      nationalities.add(data['label'] as String);
    }
  }

  late String selectedProvince = "";
  late String selectedPreferredCity = "";
  late List<String> states = [
    "",
  ];
  getProvinces(country) {
    List liveData = [];
    liveData.clear();
    states.clear();
    states = [
      "",
    ];
    selectedProvince = "";
    for (var data in fetch_countries.provinces) {
      if (country == data['countryName']) {
        liveData.add(data['regions']);
        for (var regions in liveData[0]) {
          states.add(regions['name']);
        }
      }
    }
    return liveData;
  }

  DateTime? selectedDoB;
  selectDate(BuildContext context) async => showDatePicker(
        context: context,
        // initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2011),
        helpText: 'Select your date of birth',
        cancelText: 'Close',
        fieldHintText: 'Year/Month/Day',
        fieldLabelText: 'BirthDate',
        errorInvalidText: 'Please enter a valid date!',
        errorFormatText: 'This is not the correct format!',
      ).then((DateTime? selected) {
        if (selected != null && selected != selectedDoB) {
          setState(() => selectedDoB = selected);
        }
      });

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    stageNameController.dispose();
    bioController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    facebookController.dispose();
    xController.dispose();
    instagramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var mainFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.02,
            color: constantValues.whiteColor,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal));
    var subFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            color: constantValues.whiteColor,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.normal));
    return Scaffold(
        backgroundColor: constantValues.darkColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Responsive(
                isExtraLargeScreen:
                    isExtraLargeScreen(context, size, mainFont, subFont),
                isTablet: isTablet(context, size, mainFont, subFont),
                isMobile: isMobile(context, size, mainFont, subFont)),
          ),
        ));
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
      child: SizedBox(
        width: size.width * 0.6,
        child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        Text(constantValues.performerProfileText, style: font1),
                        SizedBox(
                          width: size.width * 0.6,
                          child: Text(constantValues.performerProfileSubText,
                              style: font2,
                              textAlign: TextAlign.center,
                              maxLines: 3),
                        ),
                        SizedBox(height: size.height * 0.04),
                        performerType(context, size),
                        SizedBox(height: size.height * 0.02),
                        //Full name
                        isBand
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Full name *"),
                                  SizedBox(height: size.height * 0.01),
                                  InputFieldA(
                                    controller: fullNameController,
                                    width: size.width * 0.8,
                                    title: "Surname Firstname Other names",
                                    enabled: true,
                                    autoFillHint: const [AutofillHints.name],
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                ],
                              ),

                        //Stage name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Stage name *"),
                            SizedBox(height: size.height * 0.01),
                            InputFieldA(
                              controller: stageNameController,
                              width: size.width * 0.8,
                              title: "E.g: Davido",
                              enabled: true,
                              autoFillHint: const [AutofillHints.name],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.04),
                        //Gender and DoB
                        isBand
                            ? const SizedBox()
                            : SizedBox(
                                width: size.width * 0.8,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.3,
                                          child: ListTile(
                                            title: const Text("Gender *"),
                                            subtitle: Card(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.01),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownSearch<String>(
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .always,
                                                      validator: (value) =>
                                                          value == ""
                                                              ? "required!"
                                                              : null,
                                                      items: (filter,
                                                              infiniteScrollProps) =>
                                                          genders,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        showSearchBox: false,
                                                      ),
                                                      decoratorProps:
                                                          const DropDownDecoratorProps(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                      onChanged: (value) async {
                                                        setState(() {
                                                          selectedGender =
                                                              value!;
                                                        });
                                                      }),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Date of birth *"),
                                            SizedBox(
                                                height: size.height * 0.01),
                                            SizedBox(
                                              width: size.width * 0.3,
                                              child: Card(
                                                child: ListTile(
                                                  title: Text(
                                                    selectedDoB != null
                                                        ? selectedDoB
                                                            .toString()
                                                            .split(" ")[0]
                                                        : 'No date selected',
                                                    style: GoogleFonts.archivo(
                                                        textStyle:
                                                            const TextStyle()),
                                                  ),
                                                  trailing: IconButton(
                                                      tooltip: "Pick",
                                                      onPressed: () =>
                                                          selectDate(context),
                                                      icon: const Icon(
                                                          Icons.edit)),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        color: selectedDoB
                                                                    .toString() ==
                                                                ""
                                                            ? constantValues
                                                                .errorColor
                                                            : constantValues
                                                                .transparentColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                  ],
                                ),
                              ),
                        //Bio
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Bio *"),
                            SizedBox(height: size.height * 0.01),
                            InputFieldC(
                              controller: bioController,
                              width: size.width * 0.8,
                              maxLines: 4,
                              title: isBand
                                  ? "Tell us a bit about your team"
                                  : "Tell us a bit about yourself",
                              isBio: true,
                              autoFillHint: const [
                                AutofillHints.fullStreetAddress
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                          ],
                        ),
                        //Change dp
                        changeDP(context, size),
                        SizedBox(height: size.height * 0.04),
                        //Subgenre
                        SizedBox(
                          width: size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("What's your Gospel subgenre ? *"),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                width: size.width * 0.45,
                                child: MultiSelectContainer(
                                    maxSelectableCount: 3,
                                    items: [
                                      MultiSelectCard(
                                          value: 'Traditional',
                                          label: 'Traditional'),
                                      MultiSelectCard(
                                          value: 'Inspirational',
                                          label: 'Inspirational'),
                                      MultiSelectCard(
                                          value: 'Contemporary',
                                          label: 'Contemporary'),
                                      MultiSelectCard(
                                          value: 'Fusion', label: 'Fusion'),
                                      MultiSelectCard(
                                          value: 'Afro', label: 'Afro'),
                                      MultiSelectCard(
                                          value: 'Cultural', label: 'Cultural'),
                                      MultiSelectCard(
                                          value: 'Choir', label: 'Choir'),
                                      MultiSelectCard(
                                          value: 'Live band',
                                          label: 'Live band'),
                                      MultiSelectCard(
                                          value: 'Hip hop', label: 'Hip hop'),
                                      MultiSelectCard(
                                          value: 'Raggae', label: 'Raggae'),
                                      MultiSelectCard(
                                          value: 'Instrumental',
                                          label: 'Instrumental'),
                                    ],
                                    onMaximumSelected: (items, item) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(customSnackBar(
                                              "You're only allowed to select a maximum of three subgenre!"));
                                    },
                                    onChange: (allSelectedItems, selectedItem) {
                                      setState(() {
                                        subGenre = allSelectedItems;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),

                        //Country and Province
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                                child: ListTile(
                                  title: const Text("Country of residence *"),
                                  subtitle: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.01),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownSearch<String>(
                                            autoValidateMode:
                                                AutovalidateMode.always,
                                            validator: (value) => value == ""
                                                ? "required!"
                                                : null,
                                            items:
                                                (filter, infiniteScrollProps) =>
                                                    nationalities,
                                            popupProps: const PopupProps.menu(
                                              showSearchBox: true,
                                            ),
                                            decoratorProps:
                                                const DropDownDecoratorProps(
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            onChanged: (value) async {
                                              setState(() {
                                                selectedNationality = value!;
                                                getProvinces(
                                                    selectedNationality);
                                              });
                                              for (var x in fetch_countries
                                                  .countries_and_phone_codes) {
                                                if (selectedNationality ==
                                                    x["label"]) {
                                                  setState(() {
                                                    phoneCode =
                                                        x["phone"] as String;
                                                    maxDigits =
                                                        x["phoneLength"] as int;
                                                  });
                                                }
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: size.width * 0.3,
                                  child: ListTile(
                                    title:
                                        const Text("Province of residence *"),
                                    subtitle: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.01),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownSearch<String>(
                                              autoValidateMode:
                                                  AutovalidateMode.always,
                                              validator: (value) => value == ""
                                                  ? "required!"
                                                  : null,
                                              items: (filter,
                                                      infiniteScrollProps) =>
                                                  states,
                                              popupProps: const PopupProps.menu(
                                                showSearchBox: true,
                                              ),
                                              decoratorProps:
                                                  const DropDownDecoratorProps(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              onChanged: (value) async {
                                                setState(() {
                                                  selectedProvince = value!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        //Street address
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Street address *"),
                            SizedBox(height: size.height * 0.01),
                            InputFieldC(
                              controller: addressController,
                              width: size.width * 0.8,
                              maxLines: 3,
                              title: "Enter your address",
                              isBio: false,
                              autoFillHint: const [
                                AutofillHints.fullStreetAddress
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                          ],
                        ),

                        SizedBox(height: size.height * 0.02),
                        //Phone number and Preferred performance location
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Phone number *"),
                                  SizedBox(height: size.height * 0.01),
                                  Card(
                                    child: PhoneNumberField(
                                      controller: phoneNumberController,
                                      width: size.width * 0.25,
                                      title: selectedNationality != ""
                                          ? "$phoneCode*****"
                                          : "Enter your contact no",
                                      maxDigits: maxDigits,
                                      enabled: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: size.width * 0.3,
                                  child: ListTile(
                                    title: const Text(
                                        "Preferred performance location *"),
                                    subtitle: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.01),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownSearch<String>(
                                              autoValidateMode:
                                                  AutovalidateMode.always,
                                              validator: (value) => value == ""
                                                  ? "required!"
                                                  : null,
                                              items: (filter,
                                                      infiniteScrollProps) =>
                                                  states,
                                              popupProps: const PopupProps.menu(
                                                showSearchBox: true,
                                              ),
                                              decoratorProps:
                                                  const DropDownDecoratorProps(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              onChanged: (value) async {
                                                setState(() {
                                                  selectedPreferredCity =
                                                      value!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        //Instruments
                        SizedBox(
                          width: size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(!isBand
                                  ? "Do you play any instrument ? *"
                                  : "Does anyone of your team play any instrument ? *"),
                              SizedBox(height: size.height * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ButtonB2(
                                        width: 80,
                                        bgColor: canPlayInstrument == "yes"
                                            ? constantValues.secondaryColor2
                                            : constantValues.transparentColor,
                                        borderColor:
                                            constantValues.transparentColor,
                                        textColor: constantValues.whiteColor,
                                        text: "Yes",
                                        authenticate: () {
                                          setState(() {
                                            canPlayInstrument = "yes";
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      ButtonB2(
                                        width: 80,
                                        bgColor: canPlayInstrument == "no"
                                            ? constantValues.secondaryColor2
                                            : constantValues.transparentColor,
                                        borderColor:
                                            constantValues.transparentColor,
                                        textColor: constantValues.whiteColor,
                                        text: "No",
                                        authenticate: () {
                                          setState(() {
                                            canPlayInstrument = "no";
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(customSnackBar(
                                                  "Note: Your profile will be updated solely as a Gospel singer."));
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                ],
                              ),
                              canPlayInstrument == ""
                                  ? const SizedBox()
                                  : canPlayInstrument == "no"
                                      ? const SizedBox()
                                      : SizedBox(
                                          width: size.width * 0.55,
                                          child: MultiSelectContainer(
                                              maxSelectableCount: 10,
                                              items: [
                                                MultiSelectCard(
                                                    value: 'Piano',
                                                    label: 'Piano'),
                                                MultiSelectCard(
                                                    value: 'Organ',
                                                    label: 'Organ'),
                                                MultiSelectCard(
                                                    value: 'Flute',
                                                    label: 'Flute'),
                                                MultiSelectCard(
                                                    value: 'Saxophone',
                                                    label: 'Saxophone'),
                                                MultiSelectCard(
                                                    value: 'Violin',
                                                    label: 'Violin'),
                                                MultiSelectCard(
                                                    value: 'Banjo',
                                                    label: 'Banjo'),
                                                MultiSelectCard(
                                                    value: 'Guitar',
                                                    label: 'Guitar'),
                                                MultiSelectCard(
                                                    value: 'Bass guitar',
                                                    label: 'Bass guitar'),
                                                MultiSelectCard(
                                                    value: 'Drum',
                                                    label: 'Drum'),
                                                MultiSelectCard(
                                                    value: 'Trumpet',
                                                    label: 'Trumpet'),
                                                MultiSelectCard(
                                                    value: 'Synthesizer',
                                                    label: 'Synthesizer'),
                                                MultiSelectCard(
                                                    value: 'Harp',
                                                    label: 'Harp'),
                                                MultiSelectCard(
                                                    value: 'Recorder',
                                                    label: 'Recorder'),
                                                MultiSelectCard(
                                                    value: 'Mandolin',
                                                    label: 'Mandolin'),
                                                MultiSelectCard(
                                                    value: 'Harmonica',
                                                    label: 'Harmonica'),
                                              ],
                                              onMaximumSelected: (items, item) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(customSnackBar(
                                                        "You're only allowed to select a maximum of ten instruments!"));
                                              },
                                              onChange: (allSelectedItems,
                                                  selectedItem) {
                                                setState(() {
                                                  instrumentsPlayed =
                                                      allSelectedItems;
                                                });
                                              }),
                                        ),
                              SizedBox(height: size.height * 0.04),
                            ],
                          ),
                        ),
                        //Preferred events
                        SizedBox(
                          width: size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Preferred kind of events ? *"),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                width: size.width * 0.45,
                                child: MultiSelectContainer(
                                    maxSelectableCount: 10,
                                    items: [
                                      MultiSelectCard(
                                          value: 'Church service',
                                          label: 'Church service'),
                                      MultiSelectCard(
                                          value: 'Crusade', label: 'Crusade'),
                                      MultiSelectCard(
                                          value: 'Birthday', label: 'Birthday'),
                                      MultiSelectCard(
                                          value: 'Wedding', label: 'Wedding'),
                                      MultiSelectCard(
                                          value: 'Child dedication',
                                          label: 'Child dedication'),
                                      MultiSelectCard(
                                          value: 'Anniversary',
                                          label: 'Anniversary'),
                                      MultiSelectCard(
                                          value: 'House warming',
                                          label: 'House warming'),
                                      MultiSelectCard(
                                          value: 'Burial', label: 'Burial'),
                                    ],
                                    onMaximumSelected: (items, item) {},
                                    onChange: (allSelectedItems, selectedItem) {
                                      setState(() {
                                        preferredEvents = allSelectedItems;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                      ],
                    ),
                  ), //Social media
                  SizedBox(
                    width: size.width * 0.8,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Link to your social media accounts"),
                          SizedBox(height: size.height * 0.01),
                          InputFieldD(
                            controller: facebookController,
                            width: size.width * 0.8,
                            title: "Facebook",
                            enabled: true,
                          ),
                          SizedBox(height: size.height * 0.01),
                          InputFieldD(
                            controller: xController,
                            width: size.width * 0.8,
                            title: "X (formerly Twitter)",
                            enabled: true,
                          ),
                          SizedBox(height: size.height * 0.01),
                          InputFieldD(
                            controller: instagramController,
                            width: size.width * 0.8,
                            title: "Instagram",
                            enabled: true,
                          ),
                        ]),
                  ),
                  SizedBox(height: size.height * 0.02),
                  //Update
                  SizedBox(
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonA(
                          width: size.width * 0.15,
                          bgColor: constantValues.primaryColor,
                          textColor: constantValues.whiteColor,
                          text: "Update Profile",
                          authenticate: () async {
                            context.goNamed("performer_profile");
                            // isBand
                            //     ? await updateProfileBand()
                            //     : await updateProfileSolo();
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
      ),
    );
  }

  Widget isTablet(BuildContext context, Size size, var font1, var font2) {
    return const Column();
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return const Column();
  }

  Widget performerType(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.2,
            child: ListTile(
              leading: const Text("Band/Choir Registration"),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isBand = !isBand;
                      isBand ? canPlayInstrument = "yes" : null;
                    });
                  },
                  icon: isBand
                      ? Icon(Icons.toggle_on_rounded,
                          color: constantValues.secondaryColor)
                      : const Icon(Icons.toggle_off_rounded)),
            ),
          ),
          IconButton(
              tooltip: "Info",
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                      "Toggle on if you wish to register as a band/choir crew, else you'll be registered as a solo act. (Note: This is a one-time request)")),
              icon: const Icon(Icons.question_mark_rounded, size: 14))
        ],
      ),
    );
  }

  Widget changeDP(BuildContext context, Size size) {
    return SizedBox(
      width: size.width * 0.8,
      child: ListTile(
        minLeadingWidth: size.width * 0.04,
        leading: ProfilePicture(
          imagePath: "assets/icons/admin_white.png",
          radius: 25,
          onClicked: () {},
          pressChangePicture: () {},
        ),
        title: const Text("Upload a Proffessional photo"),
        subtitle: Text("type: Jpg/Png | max-size: 5Mb | file: $fileName"),
        trailing: ButtonB2(
          width: size.width * 0.1,
          bgColor: constantValues.transparentColor,
          borderColor: constantValues.whiteColor,
          textColor: constantValues.whiteColor,
          text: "Upload",
          authenticate: () {
            chooseFile();
          },
        ),
      ),
    );
  }

  chooseFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.first;
      if ((file.size / 1000) > 5000) {
        // file size must not be greater than 5mb
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar("Photo must not be greater than 5Mb!"));
        return;
      }
      final reader = html.FileReader();

      setState(() {
        bytesData = null;
        selectedFile = null;
      });

      reader.onLoad.listen((event) async {
        setState(() {
          bytesData = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          selectedFile = bytesData;
          fileName = file.name;
        });
        // await uploadFile(_selectedFile!, _fileName);
      });
      reader.readAsDataUrl(file);
    });
  }

  customSnackBar(String message) => SnackBar(
        content: Row(
          children: [
            Icon(Icons.info, color: constantValues.whiteColor),
            const SizedBox(width: 10),
            Text(message,
                maxLines: 5,
                style: GoogleFonts.archivo(
                    textStyle: TextStyle(
                        color: constantValues.whiteColor,
                        fontWeight: FontWeight.w500))),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        showCloseIcon: true,
        closeIconColor: constantValues.whiteColor,
        duration: const Duration(seconds: 3),
        backgroundColor: constantValues.darkColor2,
      );

  updateProfileSolo() async {
    final checkForm = _formKey.currentState!;
    // final fullname = fullNameController.text.trim();
    // final stagename = stageNameController.text.trim();
    final gender = selectedGender;
    // final dob = selectedDoB.toString().split(" ")[0];
    final dob = selectedDoB;
    // final bio = bioController.text.trim();
    final gsubGenre = subGenre;
    final country = selectedNationality;
    final province = selectedProvince;
    // final streetAdresss = addressController.text.trim();
    // final phone = phoneNumberController.text.trim();
    final preferredLoc = selectedPreferredCity;
    final playInsruments = instrumentsPlayed;
    final pickedEvents = preferredEvents;
    // final facebook = facebookController.text.trim();
    // final twitter = xController.text.trim();
    // final instagram = instagramController.text.trim();

    if (checkForm.validate()) {
      if (gender != "") {
        if (dob != null) {
          if (gsubGenre.isNotEmpty) {
            if (country != "") {
              if (province != "") {
                if (preferredLoc.isNotEmpty) {
                  if (playInsruments.isNotEmpty &&
                      canPlayInstrument != "" &&
                      canPlayInstrument != "no") {
                    if (pickedEvents.isNotEmpty) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar("Select at least one event type!"));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        customSnackBar("Select at least one instrument!"));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      "Preferred performance location is required!"));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar("Province of residence is required!"));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar("Country of residence is required!"));
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar("Select at least one subgenre!"));
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar("Date of birth is required!"));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar("Gender is required!"));
      }
    }
  }

  updateProfileBand() async {
    final checkForm = _formKey.currentState!;
    // final fullname = fullNameController.text.trim();
    // final stagename = stageNameController.text.trim();
    // final gender = selectedGender;
    // final dob = selectedDoB.toString().split(" ")[0];
    // final dob = selectedDoB;
    // final bio = bioController.text.trim();
    final gsubGenre = subGenre;
    final country = selectedNationality;
    final province = selectedProvince;
    // final streetAdresss = addressController.text.trim();
    // final phone = phoneNumberController.text.trim();
    final preferredLoc = selectedPreferredCity;
    final playInsruments = canPlayInstrument;
    final pickedEvents = preferredEvents;
    // final facebook = facebookController.text.trim();
    // final twitter = xController.text.trim();
    // final instagram = instagramController.text.trim();

    if (checkForm.validate()) {
      if (gsubGenre.isNotEmpty) {
        if (country != "") {
          if (province != "") {
            if (preferredLoc.isNotEmpty) {
              if (playInsruments != "" && playInsruments != "no") {
                if (pickedEvents.isNotEmpty) {
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar("Select at least one event type!"));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar("Select at least one instrument!"));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  "Preferred performance location is required!"));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar("Province of residence is required!"));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar("Country of residence is required!"));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar("Select at least one subgenre!"));
      }
    }
  }
}
