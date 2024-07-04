import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/widgets/custom_form_field.dart';
import 'package:task/app/widgets/image_widget.dart';
import 'package:task/app/widgets/text_widget.dart';
import 'package:task/features/home_feature/presentation/PLH/list_two_cubit/list_two_cubit.dart';

import '../../../../app/widgets/loading.dart';

class CustomListTwoBody extends StatefulWidget {
  const CustomListTwoBody({super.key});

  @override
  State<CustomListTwoBody> createState() => _CustomListTwoBodyState();
}

class _CustomListTwoBodyState extends State<CustomListTwoBody> {
  @override
  void initState() {
    super.initState();
    ListTwoCubit.get().getNews();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListTwoCubit, ListTwoState>(
      builder: (context, state) {
        var cubit = ListTwoCubit.get();
        return
          state is ListTwoInitial ?
          cubit.newsList?.length==0?
          const Center(child: TextWidget(
            title: "No Data Found",
            titleColor: AppColors.black,
            titleFontWeight: FontWeight.bold,
            titleSize: 20,
            titleMaxLines: 1,
          ))
              :
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit.newsList?.length??0,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          spreadRadius: 2,
                          blurRadius: 2
                      )
                    ]
                ),
                child: Row(
                  children: [
                    ImageWidget(
                      imageUrl: cubit.newsList?[index].urlToImage??"assets/images/logo.png",
                      width: 80.w,
                      height: 80.h,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title:cubit.newsList?[index].author?? "Tesla short sellers lost \$3.5 billion in two days of trading after deliveries report",
                            titleColor: AppColors.black,
                            titleFontWeight: FontWeight.bold,
                            titleSize: 20.sp,
                            titleMaxLines: 1,
                          ),
                          2.verticalSpace,
                          TextWidget(
                            title:cubit.newsList?[index].description?? "Tesla's better-than-expected deliveries report this week has been bad news for traders betting on a drop in the electric vehicle maker's stock.\r\nWith the shares rallying 17% in the two trading days s… [+4054 chars]",
                            titleColor: AppColors.gery4,
                            titleFontWeight: FontWeight.w400,
                            titleMaxLines: 3,
                            titleSize: 16.sp,
                            titleAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
              :
          const Center(child: Loading(),);
      },
    );
  }
}
