import 'dart:convert';
import 'dart:developer';
import 'package:connectana/controller/comman_dailog.dart';
import 'package:connectana/services/service.dart';
import 'package:connectana/view/auth/login_screen.dart';
import 'package:connectana/view/card/add_new_card.dart';
import 'package:connectana/view/home/app_home_screen.dart';
import 'package:connectana/view/theme/app_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AllInController extends GetxController {
  dynamic userId;

  Map requiredDataForCreateCard = {
    "card_id": "",
    "user_id": "",
    "card_name": "Personal",
    "prefix": "",
    "first_name": "",
    "middle_name": "",
    "last_name": "",
    "suffix": "",
    "accreditations": "",
    "preferred_name": "",
    "maiden_name": "",
    "pronouns": "",
    "title": "",
    "department": "",
    "company": "",
    "headline": "",
    "color": "",
    "is_profile_image": false,
    "badge": {
      "Mail": "",
      "Mobile": "",
      "Location": "",
      "Website": [],
      "Link": [],
      "Facebook": "",
      "Instagram": "",
      "Whatsapp": "",
      "Twitter": "",
      "Linkedin": "",
      "Youtube": "",
      "Telegram": "",
      "Skype": "",
      "Paypal": "",
      "Wechat": "",
      "Calendly": "",
      "Note": ""
    },
    "website_link": [],
    "profile": "",
    "profile_logo": "",
    "logo": ""
  };

  List multiLinkForWebsite = [];
  List multiLinkForLink = [];
  Future<void> signUp(Map requiredDataForSignUp) async {
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/signup', requiredDataForSignUp);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.offAll(() => const LoginSignUpScreen());
        CommanDialog.showErrorDialog(description: "Registration Successful");
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<bool> checkInternetAvailableOrNot() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected with Mobile");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected with Wifi");
      return true;
    } else {
      return false;
    }
  }

  Future<void> login(Map requiredDataForLogin) async {
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/signin', requiredDataForLogin);
      CommanDialog.hideLoading();
      if (response['status'] == true) {
        userId = response['response']['id'];
        await GetStorage().write("isuser_login", userId);
        Get.offAll(const AppHomeScreen());
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      if (!await checkInternetAvailableOrNot()) {
        CommanDialog.hideLoading();
        CommanDialog.showErrorDialog(description: "No Internet Connection");
        return;
      } else {
        CommanDialog.hideLoading();
        CommanDialog.showErrorDialog(description: error.toString());
      }
    }
  }

  Future<bool> isUserLogedIn() async {
    final checkUser = await GetStorage();
    if (await checkUser.read("isuser_login") != null) {
      userId = checkUser.read("isuser_login");
      return true;
    } else {
      return false;
    }
  }

  Future<void> virifyCard(Map requiredData) async {
    print("Verify card data $requiredData");
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response = await APICall().postRequest('/sendCard', requiredData);
      CommanDialog.hideLoading();
      if (response['status'] == true) {
        print("ggggg ${requiredData['qr_check_value']}");
        print("URRRR  ${requiredData['qr_check_value']}/$userId");

        launchUrlString("${requiredData['qr_check_value']}/$userId");
      }
      if (response['status'] == false) {
        // launchUrlString(requiredData['qr_check_value']);
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> checkCardLimit() async {
    Map requiredData = {"user_id": userId};
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/checkCardLimit', requiredData);
      CommanDialog.hideLoading();
      if (response['status'] == true) {
        print("response $response");
        multiLinkForWebsite.clear();
        multiLinkForLink.clear();
        Get.to(
          const AddNewCardScreen(
            type: "add",
          ),
        );
      }
      if (response['status'] == false) {
        Get.bottomSheet(
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              height: 250,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          "Create additional business cards with ConnectAna Professional",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 50,
                      ),
                      AppButton(
                        buttonType: "simpleButton",
                        buttonText: "Learn More",
                        onPressed: () {
                          Get.back();
                          learnMoreSheet();
                        },
                        buttonbgColor: const Color(0xFFDE0000),
                        buttonTextColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } catch (error) {
      return;
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> createNewCard(Map requiredDataForSignUp) async {
    log("${json.encode(requiredDataForSignUp)}");
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/CreateCard', requiredDataForSignUp);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        print(response);
        Get.offAll(const AppHomeScreen());
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  TextEditingController email = TextEditingController();
  void learnMoreSheet() {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          height: 250,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppButton(
                    buttonType: "simpleButton",
                    buttonText: "Submit",
                    onPressed: () {
                      if (email.text == null || email.text == "") {
                        CommanDialog.showErrorDialog(
                            description: "Email Required");
                        return;
                      }
                      Map requireData = {
                        "user_id": userId,
                        "email": email.text
                      };
                      Get.back();
                      learnmore(requireData);
                    },
                    buttonbgColor: const Color(0xFFDE0000),
                    buttonTextColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> learnmore(Map requiredData) async {
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response = await APICall().postRequest('/learnMore', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> deleteCard(requiredData) async {
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response = await APICall().postRequest('/deleteCard', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.offAll(() => const AppHomeScreen());
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> sendFeeback(requiredData) async {
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/contactSupport', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.back();
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Map sendCardOnMail = {"name": "", "user_id": "", "card_id": "", "email": ""};

  updateEmail(email) {
    print("Email $email");
    sendCardOnMail['email'] = email;
    update();
  }

  Map sendCardOnMobile = {
    "user_id": "",
    "card_id": "",
    "mobile": "",
    "message": "",
    "name": ""
  };

  Future<void> saveScanImage(image) async {
    Map requiredData = {
      "user_id": userId,
      "image": image,
      "note": "This is tet notes",
      "type": "Work"
    };
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/savescanrequeests', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> sendCardMail() async {
    sendCardOnMail['user_id'] = userId;
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/sendCardEmail', sendCardOnMail);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.offAll(() => const AppHomeScreen());
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  List generalData = [];
  List socialData = [];
  Future<void> getGeneralSectionDataOfSettings() async {
    generalData.clear();

    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response = await APICall().getRequest('/pages');
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        generalData.addAll(response['response']);
        print(generalData.length);
        update();
        getSocialSectionDataOfSettings();
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> getSocialSectionDataOfSettings() async {
    socialData.clear();
    Map requiredData = {"user_id": userId};
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/socialLinks', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        socialData.addAll(response['response']);
        print(socialData.length);
        update();
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> sendCardNumber() async {
    print("User id $userId");
    sendCardOnMobile['user_id'] = userId;
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/sendCardSms', sendCardOnMobile);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.offAll(() => const AppHomeScreen());
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> deleteAccount() async {
    Map requiredData = {"user_id": userId};
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/deleteaccount', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.to(() => const LoginSignUpScreen());
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  Future<void> forgotPassword(requiredData) async {
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/forgotPassword', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        CommanDialog.showErrorDialog(
            description: response['response'].toString());
        Get.back();
        Get.offAll(LoginSignUpScreen());
      }

      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  getDataForEditCard(indexValue) {
    dynamic data =
        allCardData.firstWhere((element) => element['id'] == indexValue);
    print("data $data");
    requiredDataForCreateCard["profile"] = data['profile'];
    requiredDataForCreateCard["logo"] = data['logo'];
    requiredDataForCreateCard["card_id"] = data['id'];
    requiredDataForCreateCard["user_id"] = data['user_id'];
    requiredDataForCreateCard["card_name"] = data['card_name'];
    requiredDataForCreateCard["prefix"] = data['prefix'];
    requiredDataForCreateCard["first_name"] = data['first_name'];
    requiredDataForCreateCard["middle_name"] = data['middle_name'];
    requiredDataForCreateCard["last_name"] = data['last_name'];
    requiredDataForCreateCard["suffix"] = data['suffix'];
    requiredDataForCreateCard["accreditations"] = data['accreditations'];
    requiredDataForCreateCard["preferred_name"] = data['preferred_name'];
    requiredDataForCreateCard["maiden_name"] = data['maiden_name'];
    requiredDataForCreateCard["pronouns"] = data['pronouns'];
    requiredDataForCreateCard["title"] = data['title'];
    requiredDataForCreateCard["department"] = data['department'];
    requiredDataForCreateCard["company"] = data['company'];
    requiredDataForCreateCard["headline"] = data['headline'];
    requiredDataForCreateCard["color"] = data['color'];
    requiredDataForCreateCard['badge']["Mail"] = data['badge']['Mail'] ?? "";
    requiredDataForCreateCard['badge']["Mobile"] =
        data['badge']['Mobile'] ?? "";
    requiredDataForCreateCard['badge']["Location"] =
        data['badge']['Location'] ?? "";
    requiredDataForCreateCard['badge']["Website"] =
        data['badge']['Website'] ?? [];
    requiredDataForCreateCard['badge']["Link"] = data['badge']['Link'] ?? [];
    requiredDataForCreateCard['badge']["Facebook"] =
        data['badge']['Facebook'] ?? "";
    requiredDataForCreateCard['badge']["Instagram"] =
        data['badge']['Instagram'] ?? "";
    requiredDataForCreateCard['badge']["Whatsapp"] =
        data['badge']['Whatsapp'] ?? "";
    requiredDataForCreateCard['badge']["Twitter"] =
        data['badge']['Twitter'] ?? "";
    requiredDataForCreateCard['badge']["Linkedin"] =
        data['badge']['Linkedin'] ?? "";
    requiredDataForCreateCard['badge']["Youtube"] =
        data['badge']['Youtube'] ?? "";
    requiredDataForCreateCard['badge']["Telegram"] =
        data['badge']['Telegram'] ?? "";
    requiredDataForCreateCard['badge']["Skype"] = data['badge']['Skype'] ?? "";
    requiredDataForCreateCard['badge']["Paypal"] =
        data['badge']['Paypal'] ?? "";
    requiredDataForCreateCard['badge']["Wechat"] =
        data['badge']['Wechat'] ?? "";
    requiredDataForCreateCard['badge']["Calendly"] =
        data['badge']['Calendly'] ?? "";
    requiredDataForCreateCard['badge']["Note"] = data['badge']['Note'] ?? "";
    multiLinkForLink.clear();
    multiLinkForWebsite.clear();
    multiLinkForLink.addAll(requiredDataForCreateCard['badge']["Link"]);
    multiLinkForWebsite.addAll(requiredDataForCreateCard['badge']["Website"]);

    Get.to(() => const AddNewCardScreen(
          type: "edit",
        ));
  }

  Future<void> editCard(Map requiredDataForEdit) async {
    print("requiredDataForEdit $requiredDataForEdit");
    // return;
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/UpdateCard', requiredDataForEdit);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        Get.offAll(() => const AppHomeScreen());
        CommanDialog.showErrorDialog(description: response['response']);
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  List allCardData = [];
  Future<void> getAllCardList() async {
    allCardData.clear();
    Map requiredData = {"user_id": userId};

    try {
      CommanDialog.showLoading(title: "Please wait..");

      final response = await APICall().postRequest('/cards', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        print("bbbbbbb$response");
        allCardData.clear();
        allCardData.addAll(response['response']);
        update();
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  List contactScetionData = [];
  List foundUsers = [];
  Future<void> getContactSectionData() async {
    Map requiredData = {"user_id": userId};
    contactScetionData.clear();
    foundUsers.clear();
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response =
          await APICall().postRequest('/contactsList', requiredData);
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        contactScetionData.addAll(response['response']);
        foundUsers = contactScetionData;
        update();
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }

  void runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = contactScetionData;
    } else {
      results = contactScetionData
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    foundUsers = results;
    update();
  }

  List moreSectionData = [];

  Future<void> getMoreSectionData() async {
    moreSectionData.clear();
    try {
      CommanDialog.showLoading(title: "Please wait..");
      final response = await APICall().getRequest('/moreitems');
      CommanDialog.hideLoading();

      if (response['status'] == true) {
        moreSectionData = response['response'];
        update();
      }
      if (response['status'] == false) {
        CommanDialog.showErrorDialog(description: response['response']);
      }
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
    }
  }
}
