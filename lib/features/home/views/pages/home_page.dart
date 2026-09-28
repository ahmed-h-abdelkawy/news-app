import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/views/widgets/app_bar_button.dart';
import 'package:news_app/core/views/widgets/app_drawer.dart';
import 'package:news_app/features/home/home_cubit/home_cubit.dart';
import 'package:news_app/features/home/views/widgets/custom_carousel_slider.dart';
import 'package:news_app/features/home/views/widgets/recommendation_list_widget.dart';
import 'package:news_app/features/home/views/widgets/title_headline_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeCubit = HomeCubit();
        homeCubit.getTopHeadlines();
        homeCubit.getRecommendationItems();
        return homeCubit;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AppBarButton(
              iconData: Icons.menu,
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          actions: [
            AppBarButton(
              iconData: Icons.search,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.search),
            ),
            const SizedBox(width: 10),
            AppBarButton(iconData: Icons.notifications_none_rounded, onTap: () {}),
            const SizedBox(width: 16),
          ],
        ),
        drawer: AppDrawer(),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final homeCubit = BlocProvider.of<HomeCubit>(context);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TitleHeadlineWidget(
                        title: 'Breaking News',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<HomeCubit, HomeState>(
                      bloc: homeCubit,
                      buildWhen: (previous, current) =>
                          current is TopHeadlinesLoading ||
                          current is TopHeadlinesLoaded ||
                          current is TopHeadlinesError,
                      builder: (context, state) {
                        if (state is TopHeadlinesLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is TopHeadlinesLoaded) {
                          final articles = state.articles;
                          return CustomCarouselSlider(articals: articles ?? []);
                        } else if (state is TopHeadlinesError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TitleHeadlineWidget(
                        title: 'Recommendation',
                        onTap: () {},
                      ),
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      bloc: homeCubit,
                      buildWhen: (previous, current) =>
                          current is RecommendedNewsLoading ||
                          current is RecommendedNewsLoaded ||
                          current is RecommendedNewsError,
                      builder: (context, state) {
                        if (state is RecommendedNewsLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is RecommendedNewsLoaded) {
                          final articles = state.articles;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: RecommendationListWidget(
                              articles: articles ?? [],
                            ),
                          );
                        } else if (state is RecommendedNewsError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
