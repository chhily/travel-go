class SocketRoute {
  SocketRoute._();
  static const String senderToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNTlmYjdkOTZjZDQ4NGJhMTdlNTRmNyIsIm5hbWUiOiJsaW0uY2hoaWx5MTdAZ21haWwuY29tIiwiZW1haWwiOiJsaW0uY2hoaWx5MTdAZ21haWwuY29tIiwidHlwZSI6InVzZXIiLCJyb2xlcyI6WyJwb3J0YWwiXSwiaWF0IjoxNjkxNTU3MDE4LCJleHAiOjE3MjMwOTMwMTh9.hGjLEsA_JCJJ8ddPGZyw2MaAT5ezVA4kg9wZN771ZFQ";
  static const String baseUrl = "https://kas-chat-api.myoptistech.com";

  static const String pubChatById = "/chats/get";
  static const String onGetChatById = "/chats";

  /// chat new message
  static const String pubChatNew = "/chats/new";

  /// chat lists
  static const String pubUsersChatList = "/chats/chat_lists/get";
  static const String onGetUserChatListsChange = "/chats/chat_lists/change";
  static const String onGetShopChatListsChange =
      "/chats/shops/chat_lists/change";
  static const String pubChatSeen = "/chats/seen";
  static const String pubChatDelete = "/chats/delete";
  static const String pubChatEdit = "/chats/edit";

  /// shop/store chat
  static const String pubShopChatLists = "/chats/shops/chat_lists/get";

  /// store/list
  static const String pubStoreChatLists = "/chats/store/chat_lists/get";

  /// create chat
  static const String onCreateChat = "/chats/create";
  static const String onReceiveChat = "/chats/change";

  /// typing
  static const String pubTyping = "/chats/typing";

  /// total unread
  static const String totalUnReadPath = "/chats/unread_messages_count/get";

  static const String totalStoreUnread =
      "/chats/store/unread_messages_count/get";
}
