import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 56.0),
      child: Container(
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 10,
              offset: Offset(1, 2),
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => {},
                    child: Text.rich(
                      TextSpan(
                        text: 'Mô tả chi tiết',
                        style: TextStyle(
                          fontStyle: FontStyle.italic, // Chữ nghiêng
                          decoration: TextDecoration.underline, // Gạch dưới
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground, // Màu xanh giống như link
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.favorite_border),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 220,
              height: 200,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://toongadventure.vn/wp-content/uploads/2021/05/2411-0-2ef4e0e42889ca05c07f8f3bee359d30.jpeg"),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 32.0,
                right: 24.0,
                left: 24.0,
                bottom: 28.0,
              ),
              child: Text(
                "Nấm phiến đốm chuông",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
