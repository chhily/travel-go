import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/view/message/utility/widget/bottom_sheet.dart';
import 'package:travel_go/view/message/widget/receiver/receiver_buy_listing.dart';
import 'package:travel_go/view/message/widget/receiver/receiver_image.dart';
import 'package:travel_go/view/message/widget/receiver/receiver_invoice.dart';
import 'package:travel_go/view/message/widget/receiver/receiver_message.dart';
import 'package:travel_go/view/message/widget/receiver/receiver_product.dart';
import 'package:travel_go/view/message/widget/sender/sender_buy_listing.dart';
import 'package:travel_go/view/message/widget/sender/sender_image.dart';
import 'package:travel_go/view/message/widget/sender/sender_invoice.dart';
import 'package:travel_go/view/message/widget/sender/sender_message.dart';
import 'package:travel_go/view/message/widget/sender/sender_payment.dart';
import 'package:travel_go/view/message/widget/sender/sender_product.dart';

import '../audio/audio_widget.dart';
import 'receiver/receiver_payment.dart';

class ValidatedMessageTypeWidget extends StatelessWidget {
  final PersonalMessageModel? personalMessageModel;
  const ValidatedMessageTypeWidget(
      {super.key, required this.personalMessageModel});

  @override
  Widget build(BuildContext context) {
    if (personalMessageModel?.senderId == AppUrl.senderId) {
      return buildSenderWidget(context);
    } else {
      return buildReceiverWidget();
    }
  }

  Widget buildSenderWidget(BuildContext context) {
    if (personalMessageModel?.type == MessageType.textType) {
      return GestureDetector(
          onLongPress: () {
            final provider =
                Provider.of<MessageHandler>(context, listen: false);
            showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                return ActionSheet(
                  onPressedEdit: () {
                    provider.onGetMessageId(
                        textMessage: personalMessageModel?.message,
                        messageId: personalMessageModel?.id,
                        isEdit: true);
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: SenderMessageWidget(
              message: personalMessageModel?.message ?? ""));
    } else if (personalMessageModel?.type == MessageType.photoType) {
      return SenderImageWidget(imageUrl: personalMessageModel?.photoUrl ?? "");
    } else if (personalMessageModel?.type == MessageType.voiceType) {
      return AudioPlayerMessage(
        audioSource:
            "${personalMessageModel?.voiceUrl}?token=${AppUrl.senderToken}",
        isReceiverAudio: false,
      );
    } else if (personalMessageModel?.type == MessageType.invoiceType) {
      return const SenderInvoiceWidget();
    } else if (personalMessageModel?.type == MessageType.paymentType) {
      return SenderPaymentWidget(personalMessageModel: personalMessageModel);
    } else if (personalMessageModel?.type == MessageType.productType) {
      return SenderProductWidget(
        productModel: personalMessageModel?.product,
      );
    } else if (personalMessageModel?.type == MessageType.buyListingType) {
      return SenderBuyListingWidget(
          buyListingModel: personalMessageModel?.buyListing);
    } else {
      return const Placeholder(
        fallbackHeight: 100,
        fallbackWidth: 100,
      );
    }
  }

  Widget buildReceiverWidget() {
    if (personalMessageModel?.type == MessageType.textType) {
      return ReceiverMessageWidget(
          message: personalMessageModel?.message ?? "");
    } else if (personalMessageModel?.type == MessageType.photoType) {
      return ReceiverImageWidget(
          imageUrl: personalMessageModel?.photoUrl ?? "");
    } else if (personalMessageModel?.type == MessageType.voiceType) {
      return AudioPlayerMessage(
        audioSource:
            "${personalMessageModel?.voiceUrl}?token=${AppUrl.senderToken}",
        isReceiverAudio: true,
      );
    } else if (personalMessageModel?.type == MessageType.invoiceType) {
      // return SizedBox();
      return ReceiverInvoiceWidget(personalMessageModel: personalMessageModel);
    } else if (personalMessageModel?.type == MessageType.paymentType) {
      return ReceiverPaymentWidget(personalMessageModel: personalMessageModel);
    } else if (personalMessageModel?.type == MessageType.productType) {
      return const ReceiverProductWidget();
    } else if (personalMessageModel?.type == MessageType.buyListingType) {
      return ReceiverBuyListingWidget(
          buyListingModel: personalMessageModel?.buyListing);
    } else {
      return const Placeholder(
        fallbackHeight: 100,
        fallbackWidth: 100,
      );
    }
  }
}
