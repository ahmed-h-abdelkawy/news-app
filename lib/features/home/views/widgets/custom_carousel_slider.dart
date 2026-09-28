import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Artical> articals;
  const CustomCarouselSlider({super.key, required this.articals});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.articals.map((artical) {
      final parsedDate = DateTime.parse(
        artical.publishedAt ?? DateTime.now().toString(),
      );
      final publishedDate = DateFormat.yMMMd().format(parsedDate);
      return InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.articleDetails,
          arguments: artical,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(22)),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    artical.urlToImage ??
                    'https://static.vecteezy.com/system/resources/thumbnails/011/071/660/small_2x/gallery-icon-illustration-picture-camera-icon-vector.jpg',
                fit: BoxFit.cover,
                width: 1000.0,
                height: 280,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withValues(alpha: 0.85),
                        AppColors.black.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7, 1.0],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${artical.source?.name ?? ''}.$publishedDate',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        artical.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            viewportFraction: 0.85,
            enlargeFactor: 0.27,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.2,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12.0),
        // تم استبدال الـ Row اليدوي بـ AnimatedSmoothIndicator
        AnimatedSmoothIndicator(
          activeIndex: _current,
          count: widget.articals.length,
          onDotClicked: (index) {
            _controller.animateToPage(index);
          },
          effect: ExpandingDotsEffect(
            dotWidth: 10.0,
            dotHeight: 10.0,
            spacing: 7.0,
            activeDotColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.white
                : AppColors.primary,
            dotColor:
                (Theme.of(context).brightness == Brightness.dark
                        ? AppColors.white
                        : AppColors.black)
                    .withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }
}
