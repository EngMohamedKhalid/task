import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/widgets/custom_form_field.dart';
import 'package:task/app/widgets/image_widget.dart';
import 'package:task/app/widgets/text_widget.dart';
import 'package:task/features/home_feature/presentation/PLH/list_one_cubit/list_one_cubit.dart';
import 'package:task/features/home_feature/presentation/PLH/list_two_cubit/list_two_cubit.dart';
import 'package:task/features/home_feature/presentation/widgets/custom_list_two_body.dart';

import '../widgets/custom_list_one_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const TextWidget(
          title: "Task App",
          titleColor: AppColors.mainColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomFormField(
              hint: "First Search",
              onChange: (st) {
                if (st.isEmpty) {
                  ListOneCubit.get().getNews();
                }
              },
              onFieldSubmitted: (st) {
                if (st.isEmpty) {

                } else {
                  ListOneCubit.get().getNews(
                    searchKey: st,
                  );
                }
              }
            ),
            16.verticalSpace,
            CustomFormField(
              hint: "Second Search",
              onChange: (st) {
                if (st.isEmpty) {
                  ListTwoCubit.get().getNews();
                }
              },
              onFieldSubmitted: (st) {
                if (st.isEmpty){}
                else {
                  ListTwoCubit.get().getNews(
                    searchKey: st,
                  );
                }
              },
            ),
            32.verticalSpace,
            const Row(
              children: [
                TextWidget(
                    title: "List One",
                  titleSize: 20,
                  titleFontWeight: FontWeight.bold,
                  titleColor: AppColors.black,
                ),
              ],
            ),
            32.verticalSpace,
            const CustomListOneBody(),
            32.verticalSpace,
             Container(
               width: double.infinity,
               height: 50.h,
               alignment: Alignment.center,
               color: AppColors.red,
               child: const TextWidget(
                 title: "List Two",
                 titleColor: AppColors.white,
                 titleSize: 20,
                 titleFontWeight: FontWeight.bold,
               ),
             ),
            32.verticalSpace,
            const CustomListTwoBody(),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
