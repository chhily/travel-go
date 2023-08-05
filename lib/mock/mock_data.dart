class MockData {
  MockData._();

  static const List<String> countryImgUrl = [
    "https://i.pinimg.com/564x/87/10/fe/8710fe60ac262b1e7f23e1f87b90dc3b.jpg",
    "https://i.pinimg.com/564x/b8/2e/33/b82e332473712b0f1b56b5b331970d5b.jpg",
    "https://i.pinimg.com/564x/de/eb/14/deeb14358042b9f77581e923740c1b4c.jpg",
    "https://i.pinimg.com/564x/34/cf/fb/34cffbe6160b2cedf3d8e59d27d901e9.jpg",
    "https://i.pinimg.com/564x/78/5c/c4/785cc4a79c67112c8d15a6ccda181eca.jpg",
    "https://i.pinimg.com/564x/82/43/0e/82430e56d426a43b3d5951a760571e1d.jpg",
    "https://i.pinimg.com/564x/1f/7a/36/1f7a36ee1580c0fc154ba480a16d5ec1.jpg",
    "https://i.pinimg.com/564x/ff/2d/e3/ff2de3cae2cb3a174558f8734348e695.jpg"
  ];

  static const List<String> country = [
    "Italia",
    "Paris",
    "Japan",
    "Japan - FUJI",
    "Cambodia",
    "Bali",
    "Singapore",
    "China"
  ];

  static const List<String?> countryDes = [
    "Italia is a country in Southern Europe, known for its historical cities, world-renowned cuisine, and stunning scenery. Some of the most popular tourist destinations in Italia include Rome, Florence, Venice, and the Amalfi Coast.",
    "Paris is the capital of France and one of the most popular tourist destinations in the world. The city is known for its iconic landmarks, such as the Eiffel Tower, the Louvre Museum, and the Notre Dame Cathedral. Paris is also a great city for food, shopping, and culture.",
    "Japan is a country in East Asia, known for its unique culture, beautiful nature, and delicious food. Some of the most popular tourist destinations in Japan include Tokyo, Kyoto, Osaka, and Mount Fuji.",
    "Japan is a country in East Asia, known for its unique culture, beautiful nature, and delicious food. Some of the most popular tourist destinations in Japan include Tokyo, Kyoto, Osaka, and Mount Fuji.",
    "Cambodia is a country in Southeast Asia, known for its ancient temples, such as Angkor Wat, and its beautiful beaches. Some of the most popular tourist destinations in Cambodia include Siem Reap, Phnom Penh, and the Koh Rong Islands.",
    "Bali is an island in Indonesia, known for its beautiful beaches, lush rice terraces, and vibrant culture. Some of the most popular tourist destinations in Bali include Ubud, Seminyak, and Canggu.",
    "Singapore is a city-state in Southeast Asia, known for its cleanliness, efficient transportation system, and diverse cultures. Some of the most popular tourist destinations in Singapore include Marina Bay, Gardens by the Bay, and Sentosa Island.",
    "China is a country in East Asia, known for its vast size, rich history, and diverse cultures. Some of the most popular tourist destinations in China include Beijing, Shanghai, Xi'an, and the Great Wall of China."
  ];

  static const String bgImage =
      "https://i.pinimg.com/564x/72/fd/7e/72fd7e36ebd2d212ac7825ab4037d5c9.jpg";

  static const String userCoverImg =
      "https://i.pinimg.com/564x/f6/33/76/f63376dde3fbeb37398655ea9472a286.jpg";
}

class ItemList {
  List<ItemObject>? itemList;

  ItemList({this.itemList});
}

class ItemObject {
  String? description;
  String? image;
  String? title;

  ItemObject({this.description, this.image, this.title});
}
