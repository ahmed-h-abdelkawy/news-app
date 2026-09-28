import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/app_bar_button.dart';
import 'package:news_app/core/models/news_api_response.dart';

class ArticleDetailsPage extends StatelessWidget {
  final Artical article;
  const ArticleDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final parsedDate = DateTime.parse(
      article.publishedAt ?? DateTime.now().toString(),
    );
    final formattedDate = DateFormat.yMMMd().format(parsedDate);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                article.urlToImage ??
                'https://static.vecteezy.com/system/resources/thumbnails/011/071/660/small_2x/gallery-icon-illustration-picture-camera-icon-vector.jpg',
            width: double.infinity,
            height: size.height * 0.56,
            fit: BoxFit.cover,
          ),
          Container(
            height: size.height * 0.55,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  AppColors.black.withValues(alpha: 0.9),
                  AppColors.black.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.06,
            left: 16,
            right: 16,
            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarButton(
                    iconData: Icons.chevron_left,
                    isTransparent: true,
                    onTap: () => Navigator.of(context).pop(context),
                  ),
                  Row(
                    children: [
                      AppBarButton(
                        iconData: Icons.bookmark_border_outlined,
                        isTransparent: true,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      AppBarButton(
                        iconData: Icons.more_horiz_outlined,
                        isTransparent: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'General',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        article.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Trending . $formattedDate',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: CachedNetworkImageProvider(
                                  article.urlToImage ??
                                      'https://static.vecteezy.com/system/resources/thumbnails/011/071/660/small_2x/gallery-icon-illustration-picture-camera-icon-vector.jpg',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                article.source?.name ?? 'UNKNOWN',
                                style: Theme.of(context).textTheme.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            article.content ?? '',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
