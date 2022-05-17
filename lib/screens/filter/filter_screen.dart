import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/filter/component/filter_category_component.dart';
import 'package:booking_system_flutter/screens/filter/component/filter_price_component.dart';
import 'package:booking_system_flutter/screens/filter/component/filter_provider_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterScreen extends StatefulWidget {
  final bool isFromProvider;

  FilterScreen({this.isFromProvider = true});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int isSelected = 0;

  List<Category> catList = [];
  List<ProviderData> providerList = [];

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() => init());
  }

  void init() async {
    appStore.setLoading(true);

    // Get all Category List
    await getCategoryList("all").then((value) {
      catList = value.data.validate();
      catList.forEach((element) {
        if (filterStore.categoryId.contains(element.id)) {
          element.isSelected = true;
        }
      });
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    });

    //Get all Provider List
    if (widget.isFromProvider) {
      await getProvider().then((value) {
        providerList = value.provider.validate();
        providerList.forEach((element) {
          if (filterStore.providerId.contains(element.id)) {
            element.isSelected = true;
          }
        });
        setState(() {});
      }).catchError((e) {
        toast(e.toString());
      });
    }

    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget buildItem({required String name, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 20, 20),
      width: context.width(),
      decoration: boxDecorationDefault(
        color: isSelected ? context.cardColor : context.scaffoldBackgroundColor,
        borderRadius: radius(0),
      ),
      child: Text("$name", style: boldTextStyle(size: 14)),
    );
  }

  void clearFilter() {
    catList.forEach((element) {
      if (element.isSelected) {
        element.isSelected = false;
      }
    });

    if (widget.isFromProvider) {
      providerList.forEach((element) {
        if (element.isSelected) {
          element.isSelected = false;
        }
      });
    }
    filterStore.clearFilters();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: appBarWidget(
        language!.lblFilterBy,
        textColor: Colors.white,
        color: context.primaryColor,
        backWidget: BackWidget(),
        actions: [
          TextButton(
            onPressed: () {
              clearFilter();
              toast(language!.lblAllFiltersCleared);
            },
            child: Text(language!.lblClearFilter, style: primaryTextStyle(color: Colors.white)),
          ).paddingRight(16)
        ],
      ),
      body: Observer(
        builder: (_) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: context.width() * 0.3,
                    decoration: boxDecorationDefault(color: context.scaffoldBackgroundColor, borderRadius: radius(0)),
                    child: Column(
                      children: [
                        if (widget.isFromProvider)
                          buildItem(isSelected: isSelected == 0, name: language!.txtProvider).onTap(() {
                            isSelected = 0;
                            setState(() {});
                          }),
                        buildItem(isSelected: isSelected == ((widget.isFromProvider) ? 1 : 0), name: language!.lblCategory).onTap(() {
                          isSelected = (widget.isFromProvider) ? 1 : 0;
                          setState(() {});
                        }),
                        buildItem(isSelected: isSelected == ((widget.isFromProvider) ? 2 : 1), name: language!.lblPrice).onTap(() {
                          isSelected = (widget.isFromProvider) ? 2 : 1;
                          setState(() {});
                        }),
                      ],
                    ),
                  ),
                  [
                    if (widget.isFromProvider) FilterProviderComponent(providerList: providerList),
                    FilterCategoryComponent(catList: catList),
                    FilterPriceComponent(),
                  ][isSelected]
                      .expand()
                ],
              ).visible(!appStore.isLoading, defaultWidget: LoaderWidget()).expand(),
              Container(
                decoration: boxDecorationDefault(color: context.scaffoldBackgroundColor),
                width: context.width(),
                padding: EdgeInsets.all(16),
                child: AppButton(
                  text: language!.lblApply,
                  textColor: Colors.white,
                  color: context.primaryColor,
                  onTap: () {
                    catList.forEach((element) {
                      if (element.isSelected) {
                        filterStore.addToCategoryIdList(prodId: element.id.validate());
                      }
                    });

                    providerList.forEach((element) {
                      if (element.isSelected) {
                        filterStore.addToProviderList(prodId: element.id.validate());
                      }
                    });

                    log("categoryId ${filterStore.categoryId.join(",")}");
                    log("providerId ${filterStore.providerId.join(",")}");
                    log("handymanId ${filterStore.handymanId.join(",")}");
                    log("isPriceMin ${filterStore.isPriceMin}");
                    log("isPriceMax ${filterStore.isPriceMax}");

                    finish(context, true);
                  },
                ),
              ).visible(!appStore.isLoading),
            ],
          );
        },
      ),
    );
  }
}
