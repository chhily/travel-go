import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/view/message/utility/widget/edit_message_widget.dart';
import 'package:travel_go/view/message/utility/widget/image_preview.dart';
import 'package:travel_go/view/message/utility/widget/sender_text_field.dart';

class SenderActionWidget extends StatelessWidget {
  const SenderActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MessageHandler>(context);
    return StreamBuilder<bool>(
      stream: provider.editMessageWidgetController.stream,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return _editMessageWidget(
              textEditingController: provider.editTextMessageCt,
              message: provider.textMessage ?? "N/A",
              onClose: () {
                provider.onResetEdit();
              },
              onUpdateMessage: () {
                provider.onEditTextMessage();
              });
        } else {
          return StreamBuilder<bool>(
              stream: provider.imagePreviewWidgetController.stream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    if (snapshot.data == true &&
                        provider.imageFile != null) ...[
                      ImagePreviewWidget(
                        file: File(provider.imageFile!.path),
                        onPressed: () {
                          provider.onResetImageValue();
                        },
                      ),
                    ],
                    _sendMessageWidget(
                      textEditingController: provider.textMessageCT,
                      onImagePicker: () {
                        provider.onOpenImageGallery().then((value) {
                          provider.imageConvertor(file: value).then((value) {
                            provider.onGetValuePasser(
                              base64Image: provider.base64Image,
                              imageExtension: provider.imageExtension,
                            );
                          });
                        });
                      },
                      onSendMessage: () {
                        if (provider.sendMessageType ==
                            SendMessageType.imageMessage) {
                          provider
                              .onSendImageMessage(provider.imageValue)
                              .then((value) {
                            if (provider.textMessageCT.text.isNotEmpty) {
                              provider.onSendTextMessage();
                            }
                          }).whenComplete(() => provider.onResetImageValue());
                        } else {
                          provider.onSendTextMessage();
                        }
                      },
                    ),
                  ],
                );
              });
        }
      },
    );
  }

  Widget _editMessageWidget(
      {void Function()? onUpdateMessage,
      void Function()? onClose,
      required String message,
      required TextEditingController textEditingController}) {
    return Column(
      children: [
        EditMessageWidget(onClose: onClose, message: message),
        Container(
          padding: AppGap.smallGap,
          color: AppColors.shadeWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SenderTextFieldWidget(
                  textEditingController: textEditingController,
                ),
              ),
              IconButton(
                  onPressed: onUpdateMessage,
                  icon: const Icon(FontAwesomeIcons.check))
            ],
          ),
        )
      ],
    );
  }

  Widget _sendMessageWidget(
      {void Function()? onSendMessage,
      void Function()? onImagePicker,
      required TextEditingController textEditingController}) {
    return Column(
      children: [
        Container(
          padding: AppGap.smallGap,
          color: AppColors.shadeWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SenderTextFieldWidget(
                  textEditingController: textEditingController,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: onSendMessage,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.send,
                        size: 24,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onImagePicker,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        FontAwesomeIcons.microphone,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
