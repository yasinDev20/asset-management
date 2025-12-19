
import 'package:assetmanagement/core/constant/icon_assets.dart';
import 'package:assetmanagement/features/product/presentation/widgets/products_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TesPP extends StatelessWidget {
  const TesPP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final minHeight = 600.0;

          // Paksa tinggi minimal saat Expanded digunakan
          final minHeightForce = constraints.maxHeight < minHeight
              ? minHeight
              : constraints.maxHeight;
          return SingleChildScrollView(
            child: SizedBox(
              height: minHeightForce,
              child: Column(
                children: [
                  //User setting
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: Row(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          style: Theme.of(context).textTheme.labelMedium,
                          'User',
                        ),
                        SvgPicture.asset(
                          IconAssets.accountCircle,
                          height: 32,
                          width: 32,
                        ),
                      ],
                    ),
                  ),

                  //Masuk
                  //Title header
                  Row(
                    spacing: 16,
                    children: [
                      Text(
                        'Masuk',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                 
                      SvgPicture.asset(
                        IconAssets.accountCircle,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return ProductCard();
                      },
                    ),
                  ),

                  //Perubahan
                  //Title header
                  Row(
                    spacing: 16,
                    children: [
                      Text(
                        'Masuk',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      
                      SvgPicture.asset(
                        IconAssets.accountCircle,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return ProductCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
