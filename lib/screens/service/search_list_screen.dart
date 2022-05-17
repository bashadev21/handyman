import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/background_component.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/filter/filter_screen.dart';
import 'package:booking_system_flutter/screens/service/widgets/service_component.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchListScreen extends StatefulWidget {
  final int? categoryId;
  final String? categoryName;
  final String isFeatured;
  final bool isSearchFocus;
  final bool isFromProvider;
  final bool isFromCategory;

  SearchListScreen({this.categoryId, this.categoryName = '', this.isFeatured = '', this.isSearchFocus = false, this.isFromProvider = true, this.isFromCategory = false});

  @override
  SearchListScreenState createState() => SearchListScreenState();
}

class SearchListScreenState extends State<SearchListScreen> {
  ScrollController scrollController = ScrollController();

  TextEditingController searchCont = TextEditingController();

  int page = 1;
  List<Service> mainList = [];

  bool isEnabled = false;
  bool isLastPage = false;
  bool fabIsVisible = true;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  void init() async {
    fetchAllServiceData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          fetchAllServiceData();
        }
      }
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          fabIsVisible = true;
        } else {
          fabIsVisible = false;
        }
      });
      setState(() {});
    });
  }

  String get setSearchString {
    if (!widget.categoryName.isEmptyOrNull) {
      return widget.categoryName!;
    } else if (widget.isFeatured == "1") {
      return "Featured Product";
    } else {
      return language!.allServices;
    }
  }

  Future fetchAllServiceData() async {
    appStore.setLoading(true);
    if (appStore.isCurrentLocation) {
      filterStore.setLatitude(getDoubleAsync(LATITUDE).toString());
      filterStore.setLongitude(getDoubleAsync(LONGITUDE).toString());
    } else {
      filterStore.setLatitude("");
      filterStore.setLongitude("");
    }

    String categoryId() {
      if (filterStore.categoryId.isNotEmpty) {
        return filterStore.categoryId.join(",");
      } else {
        if (widget.categoryId != null) {
          return widget.categoryId.toString();
        } else {
          return "";
        }
      }
    }

    await getSearchListServices(
      categoryId: categoryId(),
      providerId: filterStore.providerId.join(","),
      handymanId: filterStore.handymanId.join(","),
      isPriceMin: filterStore.isPriceMin,
      isPriceMax: filterStore.isPriceMax,
      search: filterStore.search,
      latitude: filterStore.latitude,
      longitude: filterStore.longitude,
      isFeatured: widget.isFeatured,
      page: page,
    ).then((value) {
      if (page == 1) {
        mainList.clear();
      }
      isLastPage = value.data!.length != perPageItem;
      mainList.addAll(value.data.validate());
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    });

    appStore.setLoading(false);
  }

  @override
  void dispose() {
    scrollController.dispose();
    filterStore.clearFilters();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        setSearchString,
        textColor: Colors.white,
        color: context.primaryColor,
        backWidget: BackWidget(),
        actions: [
          commonLocationWidget(
            onTap: () {
              page = 1;
              fetchAllServiceData();
            },
            context: context,
            color: appStore.isCurrentLocation ? Colors.lightGreen : Colors.white,
          ).paddingRight(16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          return await fetchAllServiceData();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Wrap(
                spacing: 16,
                runSpacing: 8,
                children: List.generate(
                  mainList.length,
                  (index) {
                    Service data = mainList[index];
                    return ServiceComponent(serviceData: data);
                  },
                ),
              ).paddingSymmetric(vertical: 16, horizontal: 16),
            ).paddingTop(70),
            Observer(
              builder: (BuildContext context) {
                if (mainList.isEmpty && !appStore.isLoading) return BackgroundComponent(size: 200).center();
                return LoaderWidget().visible(appStore.isLoading.validate());
              },
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  AppTextField(
                    textFieldType: TextFieldType.OTHER,
                    controller: searchCont,
                    autoFocus: widget.isSearchFocus,
                    suffix: CloseButton(
                      onPressed: () {
                        page = 1;
                        searchCont.clear();
                        filterStore.setSearch('');
                        fetchAllServiceData();
                      },
                    ).visible(searchCont.text.isNotEmpty),
                    onFieldSubmitted: (s) {
                      page = 1;

                      filterStore.setSearch(s);
                      fetchAllServiceData();
                    },
                    decoration: inputDecoration(context).copyWith(
                      hintText: "${language!.lblSearchFor} $setSearchString",
                      prefixIcon: ic_search.iconImage(size: 10).paddingAll(14),
                      hintStyle: primaryTextStyle(),
                    ),
                  ).expand(),
                  16.width,
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: boxDecorationDefault(color: context.primaryColor),
                    child: cachedImage(ic_filter, height: 26, width: 26, color: Colors.white),
                  ).onTap(() {
                    FilterScreen(isFromProvider: widget.isFromProvider).launch(context).then((value) {
                      if (value != null) {
                        page = 1;
                        fetchAllServiceData();
                      }
                    });
                  }, borderRadius: radius())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
