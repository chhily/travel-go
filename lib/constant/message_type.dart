class MessageType {
  MessageType._();
  static const String voiceType = 'VOICE';
  static const String textType = 'TEXT';
  static const String photoType = 'PHOTO';
  static const String productType = 'PRODUCT';
  static const String buyListingType = 'BUY_LISTING';
  static const String invoiceType = "INVOICE";
  static const String paymentType = "PAYMENT";
}

class SendMessageType {
  SendMessageType._();
  static const String textMessage = "text";
  static const String imageMessage = "image";
  static const String voiceMessage = "voice";
}
