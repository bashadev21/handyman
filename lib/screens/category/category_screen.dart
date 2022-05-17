import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/widget/category_widget.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryScreen extends StatefulWidget {
  final bool? hideAppBar;

  CategoryScreen({this.hideAppBar});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ScrollController scrollController = ScrollController();

  int page = 1;
  List<Category> mainList = [];

  bool isEnabled = false;
  bool isLastPage = false;
  bool fabIsVisible = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    fetchAllCategoryData();
    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          fetchAllCategoryData();
        }
      }
    });
  }

  Future fetchAllCategoryData() async {
    appStore.setLoading(true);

    await getCategoryList(page.toString()).then((value) {
      if (page == 1) {
        mainList.clear();
      }
      mainList.addAll(value.data.validate());

      isLastPage = value.data!.length != perPageItem;

      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    });

    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        page = 1;
        return await fetchAllCategoryData();
      },
      child: Scaffold(
        appBar: appBarWidget(
          language!.lblCategory,
          textColor: Colors.white,
          color: primaryColor,
          showBack: !widget.hideAppBar.validate(value: false),
          backWidget: BackWidget(),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: AnimationLimiter(
                child: Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: List.generate(
                    mainList.length,
                    (index) {
                      Category data = mainList[index];
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 1,
                        child: SlideAnimation(
                          horizontalOffset: 60.0,
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            duration: 700.milliseconds,
                            child: GestureDetector(
                              onTap: () {
                                SearchListScreen(
                                  categoryId: data.id.validate(),
                                  categoryName: data.name,
                                ).launch(context, pageRouteAnimation: PageRouteAnimation.Slide, duration: 400.milliseconds);
                              },
                              child: CategoryWidget(categoryData: data, width: context.width() / 2 - 24),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Observer(builder: (BuildContext context) => LoaderWidget().visible(appStore.isLoading.validate()))
          ],
        ),
      ),
    );
  }
}
