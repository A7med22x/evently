class IntroScreenModel {
  String imageName;
  String header;
  String body;
  String buttonName;

  IntroScreenModel({
    required this.imageName,
    required this.header,
    required this.body,
    required this.buttonName,
  });

  static List<IntroScreenModel> introScreenModels = [
    IntroScreenModel(
      imageName: 'introscreens_1',
      header: 'Personalize Your Experience',
      buttonName: 'Let’s start',
      body:
          "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
    ),
    IntroScreenModel(
      imageName: 'introscreens_2',
      header: 'Find Events That Inspire You',
      buttonName: 'Next',
      body:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    IntroScreenModel(
      imageName: 'introscreens_3',
      header: 'Effortless Event Planning',
      buttonName: 'Next',
      body:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    IntroScreenModel(
      imageName: 'introscreens_4',
      header: 'Connect with Friends & Share Moments',
      buttonName: 'Get started',
      body:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];
}
