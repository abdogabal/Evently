import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/resources/AppStyle.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Providers/ThemeProvider.dart';
import 'package:evently/UI/Home/Taps/HomeTab/widgets/AllTab.dart';
import 'package:evently/UI/Home/Taps/HomeTab/widgets/BirthdayTab.dart';
import 'package:evently/UI/Home/Taps/HomeTab/widgets/BookClubTab.dart';
import 'package:evently/UI/Home/Taps/HomeTab/widgets/SportTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../../Core/PrefsManager.dart';
import '../../../../Providers/MapsProvider.dart';
import '../../../../Providers/UserProvider.dart';
import '../../Widgets/EventItems.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  bool selectTheme = true;
  bool selectLanguage = true;
  int selectedTap = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  getUserLocation() async {
    MapsProvider mapsProvider = Provider.of<MapsProvider>(
      context,
      listen: false,
    );
    LocationData locationData = await mapsProvider.location.getLocation();
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      locationData.latitude ?? 0,
      locationData.longitude ?? 0,
    );
    mapsProvider.savePlaceMark(placeMarks[0]);
  }

  @override
  Widget build(BuildContext context) {
    PrefsManager.getTheme() ? selectTheme = false : selectTheme = true;
    context.locale.toString() == 'ar'
        ? selectLanguage = false
        : selectLanguage = true;
    UserProvider provider = Provider.of<UserProvider>(context);
    ThemeProviders themeProvider = Provider.of<ThemeProviders>(context);
    MapsProvider mapsProvider = Provider.of<MapsProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringsManger.welcome.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            provider.myUser == null
                                ? Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManger.white,
                                    constraints: BoxConstraints(
                                      maxHeight: 25,
                                      maxWidth: 25,
                                      minHeight: 25,
                                      minWidth: 25,
                                    ),
                                  ),
                                )
                                : Text(
                                  provider.myUser?.name ?? "",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (selectTheme) {
                                PrefsManager.setTheme(selectTheme);
                                themeProvider.changeTheme(ThemeMode.dark);
                              } else {
                                PrefsManager.setTheme(selectTheme);
                                themeProvider.changeTheme(ThemeMode.light);
                              }
                              selectTheme = !selectTheme;
                            },
                            icon: SvgPicture.asset(
                              selectTheme
                                  ? AssetsManger.sun
                                  : AssetsManger.moon,
                              colorFilter: ColorFilter.mode(
                                ColorManger.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (selectLanguage) {
                                context.setLocale(Locale('ar'));
                              } else {
                                context.setLocale(Locale('en'));
                              }
                              selectLanguage = !selectLanguage;
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ColorManger.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                StringsManger.languageType.tr(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManger.map),
                      mapsProvider.placeMark?.name == null
                          ? Center(
                            child: CircularProgressIndicator(
                              color: ColorManger.white,
                              constraints: BoxConstraints(
                                maxHeight: 15,
                                maxWidth: 15,
                                minHeight: 15,
                                minWidth: 15,
                              ),
                            ),
                          )
                          : Text(
                            '${mapsProvider.placeMark?.name} , ${mapsProvider.placeMark?.country}',
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(
                              color: ColorManger.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TabBar(
                    onTap: (value) {
                      setState(() {
                        selectedTap = value;
                      });
                    },
                    unselectedLabelColor: ColorManger.white,
                    labelColor: Theme.of(context).colorScheme.secondaryFixed,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
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
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
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
                                AssetsManger.compass,
                                colorFilter: ColorFilter.mode(
                                  selectedTap == 0
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.secondaryFixed
                                      : ColorManger.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(StringsManger.all.tr()),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
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
                                  selectedTap == 1
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.secondaryFixed
                                      : ColorManger.white,
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
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
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
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.secondaryFixed
                                      : ColorManger.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(StringsManger.birthday.tr()),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
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
                                  selectedTap == 3
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.secondaryFixed
                                      : ColorManger.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(StringsManger.bookClub.tr()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [AllTab(), SportTab(), BirthdayTab(), BookClubTab()],
            ),
          ),
        ],
      ),
    );
  }
}
