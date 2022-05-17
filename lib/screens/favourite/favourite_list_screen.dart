import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/background_component.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/wish_list_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/favourite/widgets/favourite_item_widget.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class FavouriteListScreen extends StatefulWidget {
  const FavouriteListScreen({Key? key}) : super(key: key);

  @override
  _FavouriteListScreenState createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {
  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  Future<void> init() async {
    LiveStream().on("RefreshList", (p0) {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language!.lblFavorite,
        color: context.primaryColor,
        textColor: white,
        backWidget: BackWidget(),
      ),
      body: Stack(
        children: [
          FutureBuilder<WishListResponse>(
            future: getWishlist(),
            builder: (context, snap) {
              if (snap.hasData) {
                if (snap.data!.data!.length == 0) return BackgroundComponent();
                return SingleChildScrollView(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(
                      snap.data!.data!.length,
                      (index) {
                        WishListData data = snap.data!.data![index];

                        return FavouriteItemWidget(
                          wishListData: data,
                          width: context.width() / 2 - 24,
                          onUpdate: () {
                            setState(() {});
                          },
                        ).onTap(() async {
                          await ServiceDetailScreen(serviceId: data.service_id.validate().toInt()).launch(context);
                          setState(() {});
                        });
                      },
                    ),
                  ).paddingSymmetric(vertical: 16, horizontal: 16),
                );
              }
              return snapWidgetHelper(snap, loadingWidget: LoaderWidget());
            },
          ),
          Observer(builder: (_) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
