import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_qoute/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes_app/features/random_qoute/presentation/widgets/quote_box.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    _getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: (context, state) {
          if (state is RandomQuoteIsLoading) {
            return SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            );
          } else if (state is RandomQuoteLoadedError) {
            return const Text('Error');
          } else if (state is RandomQuoteLoadedSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.appTitle),
              ),
              body: Center(
                child: CustomRefreshIndicator(
                  builder: MaterialIndicatorDelegate(
                    builder: (context, controller) {
                      return Icon(
                        Icons.replay,
                        color: AppColors.primaryColor,
                        size: 30.sp,
                      );
                    },
                  ),
                  onRefresh: () => _getRandomQuote(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        QuoteBox(
                          quote: state.quote,
                        ),
                        Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () => _getRandomQuote(),
                            child: const Icon(
                              Icons.replay_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
