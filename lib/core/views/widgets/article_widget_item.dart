import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class ArticleWidgetItem extends StatelessWidget {
  final Artical article;
  final bool isSearch;
  const ArticleWidgetItem({super.key, required this.article, this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(
      article.publishedAt ?? DateTime.now().toString(),
    );
    final formattedDate = DateFormat.yMMMd().format(parsedDate);
    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(AppRoutes.articleDetails, arguments: article),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: CachedNetworkImage(
              imageUrl:
                  article.urlToImage ??
                  'https://static.vecteezy.com/system/resources/thumbnails/011/071/660/small_2x/gallery-icon-illustration-picture-camera-icon-vector.jpg',
              width: isSearch ? 135 : 135,
              height: isSearch ? 125 : 125,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.source?.name ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey2,
                    fontWeight: FontWeight.bold,
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
