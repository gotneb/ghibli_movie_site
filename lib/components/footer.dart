import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/styles.dart';
import 'package:image_pixels/image_pixels.dart';
import 'dart:html' as html;

class Footer extends StatelessWidget {
  const Footer({super.key, required this.movie});

  final Movie movie;

  static const _insta = 'https://www.instagram.com/dearrev_/';
  static const _pinterest = 'https://br.pinterest.com/DearRev_/';
  static const _twitter = 'https://twitter.com/DearRev_';
  static const _name = 'DearRev_';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
      height: 50,
      child: ImagePixels(
        imageProvider: NetworkImage(movie.promotionalImage),
        builder: (context, img) {
          if (img.hasImage) {
            return _buildRow(
              img.pixelColorAtAlignment!(Alignment.bottomCenter),
            );
          }
          return _buildRow(Colors.black);
        },
      ),
    );
  }

  Widget _buildRow(Color color) {
    final icons = [
      'https://i.postimg.cc/vTKS7Y1N/instagram.png',
      'https://i.postimg.cc/m2cnLHJf/pinterest.png',
      'https://i.postimg.cc/dQNXcBWj/twitter.png',
    ]
        .map((link) => GestureDetector(
              onTap: () => openLink(link: _pinterest),
              child: CircleAvatar(
                  backgroundColor: color,
                  radius: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child:
                        Image.network(link, filterQuality: FilterQuality.low),
                  )),
            ))
        .toList();

    final iconsBox = SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: icons,
      ),
    );

    return Row(children: [
      Text(movie.originalTitle,
          style: CustomStyle.footerText.copyWith(color: color)),
      Text(' | ${movie.alternativeTitle}',
          style: CustomStyle.footerText2.copyWith(color: color)),
      const Spacer(),
      iconsBox,
      const SizedBox(width: 18),
      Text(_name, style: CustomStyle.footerText2.copyWith(color: color)),
    ]);
  }

  Future<void> openLink({required String link}) async {
    html.window.open(link, _name);
  }
}
