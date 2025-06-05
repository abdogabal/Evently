import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/DialogUtils.dart';
import 'package:evently/Core/FirestoreHandler.dart';
import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomTextField.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/Constants.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Models/Event.dart';
import 'package:evently/Providers/MapPickerProvider.dart';
import 'package:evently/UI/CreateEvent/Widgets/PickLocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Core/Reusable_Component/CustomLocationPicker.dart';
import '../../../Core/resources/ColorManger.dart';
import '../../../Providers/UserProvider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = 'createEvent';

  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  int selectedTap = 0;
  late TextEditingController titleController;
  late TextEditingController discController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    MapPickerProvider mapPickerProvider = Provider.of<MapPickerProvider>(
      context,
      listen: false
    );
    // TODO: implement initState
    super.initState();
    mapPickerProvider.eventLocation=null;
    titleController = TextEditingController();
    discController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    discController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapPickerProvider mapPickerProvider = Provider.of<MapPickerProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManger.createEvent.tr()),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 203,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AssetsManger.bookClub,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AssetsManger.sport,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AssetsManger.birthday,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  TabBar(
                    onTap: (value) {
                      setState(() {
                        selectedTap = value;
                      });
                    },
                    unselectedLabelColor: ColorManger.blue,
                    labelColor: Theme.of(context).colorScheme.onTertiary,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    isScrollable: true,
                    dividerHeight: 0,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.only(right: 10),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.book,
                                colorFilter: ColorFilter.mode(
                                  selectedTap == 0
                                      ? Theme.of(context).colorScheme.onTertiary
                                      : ColorManger.blue,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(StringsManger.bookClub.tr()),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.sport,
                                colorFilter: ColorFilter.mode(
                                  selectedTap == 1
                                      ? Theme.of(context).colorScheme.onTertiary
                                      : ColorManger.blue,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(StringsManger.sport.tr()),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.cake,
                                colorFilter: ColorFilter.mode(
                                  selectedTap == 2
                                      ? Theme.of(context).colorScheme.onTertiary
                                      : ColorManger.blue,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(StringsManger.birthday.tr()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    StringsManger.title.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
                      }
                      return null;
                    },
                    controller: titleController,
                    hint: StringsManger.eventTitle.tr(),
                    prefixIcon: AssetsManger.noteEdit,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  Text(
                    StringsManger.desc.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
                      }
                      return null;
                    },
                    controller: discController,
                    hint: StringsManger.eventDesc.tr(),
                    prefixIcon: '',
                    keyboardType: TextInputType.multiline,
                    lines: 5,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManger.calender,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        StringsManger.eventDate.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Spacer(),

                      TextButton(
                        onPressed: () async {
                          var date = await showDatePicker(
                            initialDate: selectedDate,
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Text(
                          selectedDate == null
                              ? StringsManger.chooseDate.tr()
                              : DateFormat.yMd().format(selectedDate!),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManger.clock,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        StringsManger.eventTime.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          var time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              selectedTime = time;
                            });
                          }
                        },
                        child: Text(
                          selectedTime == null
                              ? StringsManger.chooseTime.tr()
                              : '${selectedTime!.hour % 12}:${selectedTime!.minute} ${selectedTime!.period.name.toUpperCase()}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    StringsManger.location.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: CustomLocationPicker(
                      locations:
                          mapPickerProvider.eventLocation == null
                              ? StringsManger.eventLocation.tr()
                              : '${mapPickerProvider.placeMark?.name} , ${mapPickerProvider.placeMark?.country} ',
                      onClick: () {
                        Navigator.pushNamed(context, PickLocation.routeName);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                      title: StringsManger.addEvent.tr(),
                      onClick: () async {
                        if (formKey.currentState!.validate()) {
                          if (selectedDate == null) {
                            DialogUtils.showSnackBar(
                              StringsManger.chooseEventDate.tr(),
                            );
                            return;
                          }
                          if (selectedTime == null) {
                            DialogUtils.showSnackBar(
                              StringsManger.chooseEventTime.tr(),
                            );
                            return;
                          }
                          if (mapPickerProvider.eventLocation == null) {
                            DialogUtils.showSnackBar(
                              StringsManger.eventLocation.tr(),
                            );
                            return;
                          }
                          DateTime eventDate = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );
                          DialogUtils.showLoading(context);
                          try {
                            await FirestoreHandler.addEvent(
                              Event(
                                title: titleController.text,
                                description: discController.text,
                                latitude: mapPickerProvider.eventLocation?.latitude??0,
                                longitude: mapPickerProvider.eventLocation?.longitude??0,
                                userId: FirebaseAuth.instance.currentUser?.uid,
                                type: eventType[selectedTap],
                                date: Timestamp.fromDate(eventDate),
                              ),
                            );

                            Navigator.pop(context);
                            DialogUtils.showSnackBar(
                              StringsManger.addEventSuccess.tr(),
                            );
                            mapPickerProvider.eventLocation=null;
                            Navigator.pop(context);
                          } catch (error) {
                            Navigator.pop(context);
                            DialogUtils.showSnackBar(error.toString());
                          }

                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
