import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_finalproject/const/const.dart';
import 'package:seller_finalproject/controllers/auth_controller.dart';
import 'package:seller_finalproject/controllers/loading_Indcator.dart';
import 'package:seller_finalproject/controllers/profile_controller.dart';
import 'package:seller_finalproject/services/store_services.dart';
import 'package:seller_finalproject/views/auth_screen/login_screen.dart';
import 'package:seller_finalproject/views/messages_screen/messages_screen.dart';
import 'package:seller_finalproject/views/profile_screen/edit_screen.dart';
import 'package:seller_finalproject/views/shop_screen/shop_settings_screen.dart';
import 'package:seller_finalproject/views/widgets/text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, color: fontBlack, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signoutMethod(context);
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout, color: fontBlack))
          ],
        ),
        body: FutureBuilder(
            future: StoreServices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndcator(circleColor: fontLightGrey);
              } else {
                controller.snapshotData = snapshot.data!.docs[0];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    
                    ListTile(
                      leading: controller.snapshotData['imageUrl'] == ''
                          ? Image.asset(
                              imgProfile,
                              width: 130,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              controller.snapshotData['imageUrl'],
                              width: 130,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),

                      title: boldText(
                          text: "${controller.snapshotData['vendor_name']}",
                          color: fontBlack),
                      subtitle: normalText(
                          text: "${controller.snapshotData['email']}",
                          color: fontGreyDark),
                    ),
                    const Divider(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(
                            profileButtonsIcons.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const ShopSettings());

                                        break;
                                      case 1:
                                        Get.to(() => const MessagesScreen());

                                        break;
                                      default:
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonsIcons[index],
                                    color: fontGreyDark,
                                  ),
                                  title: normalText(
                                    text: profileButtonsTitles[index],
                                    color: fontGreyDark,
                                  ),
                                )),
                      ),
                    )
                  ]),
                );
              }
            }));
  }
}
