import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/screens/category/category_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/widget/category_widget.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryComponent extends StatefulWidget {
  final List<Category>? categoryList;
  final Function? onCall;
  final bool? isViewAll;

  CategoryComponent({this.categoryList, this.onCall, this.isViewAll});

  @override
  CategoryComponentState createState() => CategoryComponentState();
}

class CategoryComponentState extends State<CategoryComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isViewAll.validate())
            Column(
              children: [
                16.height,
                Row(
                  children: [
                    Text(language!.category, style: boldTextStyle(size: 20)).expand(),
                    TextButton(
                      onPressed: () {
                        CategoryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide).then((value) {
                          setStatusBarColor(Colors.transparent);
                        });
                      },
                      child: Text(language!.lblViewAll, style: secondaryTextStyle(size: 14)),
                    )
                  ],
                ),
              ],
            ),
          8.height,
          AnimationLimiter(
            child: Wrap(
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                widget.categoryList!.take(6).length,
                (index) {
                  Category data = widget.categoryList![index];
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
                          child: CategoryWidget(categoryData: data),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
