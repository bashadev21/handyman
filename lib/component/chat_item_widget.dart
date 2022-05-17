import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/chat_message_model.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/widgets/cached_nework_image.dart';

class ChatItemWidget extends StatefulWidget {
  final ChatMessageModel? data;

  ChatItemWidget({this.data});

  @override
  _ChatItemWidgetState createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String? images;

  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  Widget build(BuildContext context) {
    String time;

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000);
    if (date.day == DateTime.now().day) {
      time = formatDate(widget.data!.createdAt.validate().toString(), format: Hour12Format, isFromMicrosecondsSinceEpoch: true);
    } else {
      time = formatDate(widget.data!.createdAt.validate().toString(), format: DATE_FORMAT_1, isFromMicrosecondsSinceEpoch: true);
    }

    Widget chatItem(String? messageTypes) {
      switch (messageTypes) {
        case TEXT:
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.data!.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                widget.data!.message!,
                style: primaryTextStyle(color: widget.data!.isMe! ? Colors.white : textPrimaryColorGlobal),
                maxLines: null,
              ),
              1.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: primaryTextStyle(
                      color: !widget.data!.isMe.validate() ? Colors.blueGrey.withOpacity(0.6) : whiteColor.withOpacity(0.6),
                      size: 10,
                    ),
                  ),
                  2.width,
                  widget.data!.isMe!
                      ? !widget.data!.isMessageRead!
                          ? Icon(Icons.done, size: 12, color: Colors.white60)
                          : Icon(Icons.done_all, size: 12, color: Colors.white60)
                      : Offstage()
                ],
              ),
            ],
          );
        case IMAGE:
          if (widget.data!.photoUrl.validate().isNotEmpty || widget.data!.photoUrl != null) {
            return Stack(
              children: [
                cachedImage(
                  widget.data!.photoUrl.validate(),
                  fit: BoxFit.contain,
                  width: 250,
                ).cornerRadiusWithClipRRect(10),
                Positioned(
                    bottom: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          style: primaryTextStyle(
                            color: !widget.data!.isMe.validate() ? Colors.blueGrey.withOpacity(0.6) : whiteColor.withOpacity(0.6),
                            size: 10,
                          ),
                        ),
                        2.width,
                        widget.data!.isMe!
                            ? !widget.data!.isMessageRead!
                                ? Icon(Icons.done, size: 12, color: Colors.white60)
                                : Icon(Icons.done_all, size: 12, color: Colors.white60)
                            : Offstage()
                      ],
                    ))
              ],
            );
          } else {
            return Container(child: Loader(), height: 250, width: 250);
          }
        /*   return SizedBox();
        case VIDEO:
          if (widget.data!.photoUrl.validate().isNotEmpty || widget.data!.photoUrl != null) {
            return Container(
              height: 250,
              width: 250,
              child: Stack(
                children: [
                  cachedImage(
                    widget.data!.photoUrl.validate(),
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: boxDecorationWithShadow(backgroundColor: Colors.black38, boxShape: BoxShape.circle, spreadRadius: 0, blurRadius: 0),
                    child: IconButton(
                      icon: Icon(Icons.play_arrow, color: Colors.white),
                      onPressed: () {
                        //
                      },
                    ),
                  ).center(),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          style: primaryTextStyle(
                            color: !widget.data!.isMe.validate() ? Colors.blueGrey.withOpacity(0.6) : whiteColor.withOpacity(0.6),
                            size: 10,
                          ),
                        ),
                        2.width,
                        widget.data!.isMe!
                            ? !widget.data!.isMessageRead!
                                ? Icon(Icons.done, size: 12, color: Colors.white60)
                                : Icon(Icons.done_all, size: 12, color: Colors.white60)
                            : Offstage()
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(child: Loader(), height: 250, width: 250);
          }
          return SizedBox();
        case AUDIO:
          return Container();*/
        default:
          return Container();
      }
    }

    EdgeInsetsGeometry customPadding(String? messageTypes) {
      switch (messageTypes) {
        case TEXT:
          return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        case IMAGE:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        case VIDEO:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        case AUDIO:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        default:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
      }
    }

    return GestureDetector(
      onLongPress: !widget.data!.isMe!
          ? null
          : () async {
              bool? res = await showConfirmDialog(
                context,
                language!.dltMsg,
                positiveText: language!.lblYes,
                negativeText: language!.lblNo,
                buttonColor: primaryColor,
              );
              if (res ?? false) {
                hideKeyboard(context);
                chatMessageService
                    .deleteSingleMessage(
                  senderId: widget.data!.senderId,
                  receiverId: widget.data!.receiverId!,
                  documentId: widget.data!.id,
                )
                    .then((value) {
                  //
                }).catchError(
                  (e) {
                    log(e.toString());
                  },
                );
              }
            },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.data!.isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: widget.data!.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: widget.data!.isMe.validate() ? EdgeInsets.only(top: 0.0, bottom: 0.0, left: isRTL ? 0 : context.width() * 0.25, right: 8) : EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8, right: isRTL ? 0 : context.width() * 0.25),
              padding: customPadding(widget.data!.messageType),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: gray, blurRadius: 0.1, spreadRadius: 0.2), //BoxShadow
                ],
                color: widget.data!.isMe.validate() ? primaryColor : context.cardColor,
                borderRadius: widget.data!.isMe.validate()
                    ? radiusOnly(bottomLeft: 12, topLeft: 12, bottomRight: 0, topRight: 12)
                    : radiusOnly(
                        bottomLeft: 0,
                        topLeft: 12,
                        bottomRight: 12,
                        topRight: 12,
                      ),
              ),
              child: chatItem(widget.data!.messageType),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 2, bottom: 2),
      ),
    );
  }
}
