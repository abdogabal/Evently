import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Reusable_Component/CustomTextField.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Core/resources/ColorManger.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formKey,
                  child: Container(
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
                              AssetsManger.bike,
                              colorFilter: ColorFilter.mode(
                                selectedTap == 0
                                    ? Theme.of(context).colorScheme.onTertiary
                                    : ColorManger.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(StringsManger.sport),
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
                                selectedTap == 1
                                    ? Theme.of(context).colorScheme.onTertiary
                                    : ColorManger.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(StringsManger.birthday),
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
                              AssetsManger.book,
                              colorFilter: ColorFilter.mode(
                                selectedTap == 2
                                    ? Theme.of(context).colorScheme.onTertiary
                                    : ColorManger.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(StringsManger.bookClub),
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
                      onPressed: () {},
                      child: Text(
                        StringsManger.chooseDate.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                      onPressed: () {},
                      child: Text(
                        StringsManger.chooseTime.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
