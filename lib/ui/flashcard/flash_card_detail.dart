import 'package:flutter/material.dart';

class FlashCardDetail extends StatelessWidget {
  const FlashCardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                'assets/images/logo.png',
                height: 36,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                child: Text(
                  'Nấm độc tại rừng quốc gia Việt Nam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Nấm phiến đốm chuông",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Ảnh minh họa",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 180,
                height: 140,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://toongadventure.vn/wp-content/uploads/2021/05/2411-0-2ef4e0e42889ca05c07f8f3bee359d30.jpeg"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Mô tả chi tiết",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Tuy có kích thước nhỏ nhưng nồng độ chất độc lại khá cao. Khi ăn phải một lượng nhiều, nấm có thể gây ảo giác, thậm chí là tử vong. Mũ nấm hình chuông, đường kính từ 2 đến 3.5cm. Các phiến có vân, màu xanh rồi đen. Nấm có lớp thịt mỏng, màu da sơn dương.  Những chất độc gây ảo giác nằm ở phiến đốm chuông không mùi.  Bạn có thể tìm thấy nấm phiến đốm chuông trên phân hoại mục ở các bãi cỏ từ tháng 1 đến tháng 9 hằng năm.Tuy có kích thước nhỏ nhưng nồng độ chất độc lại khá cao. Khi ăn phải một lượng nhiều, nấm có thể gây ảo giác, thậm chí là tử vong. Mũ nấm hình chuông, đường kính từ 2 đến 3.5cm. Các phiến có vân, màu xanh rồi đen. Nấm có lớp thịt mỏng, màu da sơn dương.  Những chất độc gây ảo giác nằm ở phiến đốm chuông không mùi.  Bạn có thể tìm thấy nấm phiến đốm chuông trên phân hoại mục ở các bãi cỏ từ tháng 1 đến tháng 9 hằng năm.Tuy có kích thước nhỏ nhưng nồng độ chất độc lại khá cao. Khi ăn phải một lượng nhiều, nấm có thể gây ảo giác, thậm chí là tử vong. Mũ nấm hình chuông, đường kính từ 2 đến 3.5cm. Các phiến có vân, màu xanh rồi đen. Nấm có lớp thịt mỏng, màu da sơn dương.  Những chất độc gây ảo giác nằm ở phiến đốm chuông không mùi.  Bạn có thể tìm thấy nấm phiến đốm chuông trên phân hoại mục ở các bãi cỏ từ tháng 1 đến tháng 9 hằng năm.",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
