import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_admin_app/utils/dimension_manager.dart';

import '../../bloc/app/app_bloc.dart';
import '../../bloc/app/app_event.dart';
import '../../bloc/app/app_state.dart';
import '../../repository/app_repo.dart';
import '../../utils/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  bool isTokenEmpty = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(RepositoryProvider.of<AppRepository>(context))..add(LoadAppEvent()),
      child: Material(
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: true,
          navigationBar: const CupertinoNavigationBar(
            middle: Text("Admin dashboard"),
          ),
          child: GestureDetector(
            onTap: () {
              primaryFocus!.unfocus();
            },
            child: SafeArea(
              child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
                if (state is AppLoadingState) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (state is AppLoadedState) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: DimensionManager.width20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: DimensionManager.height20),
                        buildTitle("FCM Token", false),
                        buildTextField(tokenController, "Specific FCM Token", 0, (value) {
                          if (tokenController.text.isNotEmpty) {
                            setState(() {
                              isTokenEmpty = false;
                            });
                          } else {
                            setState(() {
                              isTokenEmpty = true;
                            });
                          }
                        }),
                        buildTitle("Title", true),
                        buildTextField(titleController, "Notification title", 0, null),
                        buildTitle("Body", true),
                        buildTextField(bodyController, "Notification body", 3, null),
                        SizedBox(height: DimensionManager.height15),
                        CupertinoButton(
                            color: (isTokenEmpty) ? AppColor.primaryColor.withOpacity(0.2) : AppColor.primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Send specific user",
                                  style: TextStyle(
                                      color: (isTokenEmpty) ? AppColor.activeIconColorLight.withOpacity(0.8) : AppColor.activeIconColorLight,
                                      fontWeight: FontWeight.w500,
                                      fontSize: DimensionManager.font12),
                                ),
                                SizedBox(width: DimensionManager.width5),
                                Icon(
                                  CupertinoIcons.arrow_up_circle,
                                  size: DimensionManager.font14,
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (isTokenEmpty == false) {
                                final appBloc = BlocProvider.of<AppBloc>(context);
                                appBloc.add(SendDataEvent(token: tokenController.text, title: titleController.text, body: bodyController.text));
                              }
                            }),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: DimensionManager.height30),
                          child: Text(
                            "OR",
                            style: TextStyle(color: AppColor.secondaryColor, fontWeight: FontWeight.w300, fontSize: DimensionManager.font14),
                          ),
                        ),
                        CupertinoButton(
                            color: AppColor.primaryColorLight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Send all users",
                                  style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w500, fontSize: DimensionManager.font12),
                                ),
                                SizedBox(width: DimensionManager.width5),
                                Icon(
                                  CupertinoIcons.arrow_up_circle,
                                  size: DimensionManager.font14,
                                  color: AppColor.primaryColor,
                                ),
                              ],
                            ),
                            onPressed: () {
                              final appBloc = BlocProvider.of<AppBloc>(context);
                              appBloc.add(SendDataEvent(title: titleController.text, body: bodyController.text));
                            }),
                        SizedBox(height: DimensionManager.height40),
                      ],
                    ),
                  );
                }

                return Container();
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint, int maxline, var onChanged) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppColor.secondaryColor, fontSize: DimensionManager.font12),
      maxLines: maxline == 0 ? null : maxline,
      cursorColor: AppColor.secondaryColor,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.secondaryColor.withOpacity(0.2),
          // contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
          hintStyle: TextStyle(color: AppColor.secondaryColor, fontSize: DimensionManager.font12),
          hintText: hint),
    );
  }

  buildTitle(String text, bool required) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: DimensionManager.height10 * 0.5),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w500, fontSize: DimensionManager.font15),
            ),
            if (required)
              Text(
                "*",
                style: TextStyle(color: AppColor.redColor, fontWeight: FontWeight.w500, fontSize: DimensionManager.font15),
              ),
          ],
        ),
      ),
    );
  }
}
