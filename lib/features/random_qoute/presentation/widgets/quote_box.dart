import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/features/random_qoute/domain/entities/quote.dart';

class QuoteBox extends StatelessWidget {
  final Quote quote;
  const QuoteBox({
    Key? key,
    required this.quote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotationTransition(
          turns: const AlwaysStoppedAnimation(-10 / 360),
          child: Container(
            margin: EdgeInsets.all(30.h),
            height: 180.h,
            decoration: BoxDecoration(
              color: AppColors.secondryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.h),
          margin: EdgeInsets.all(30.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                quote.content,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  '"${quote.author}"',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
