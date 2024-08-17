import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/presentation/blocs/promo_provider.dart';
import 'package:front/features/promo/presentation/widgets/promo_widget.dart';

class PromoCarousel extends ConsumerStatefulWidget {
  const PromoCarousel({Key? key}) : super(key: key);

  @override
  _PromoCarouselState createState() => _PromoCarouselState();
}

class _PromoCarouselState extends ConsumerState<PromoCarousel> {
  @override
  void initState() {
    super.initState();
    // Fetch promos when the widget is initialized
    ref.read(promoNotifierProvider.notifier).getPromoList();
  }

  @override
  Widget build(BuildContext context) {
    final promoState = ref.watch(promoNotifierProvider);

    return promoState.when(
      initial: () => const Center(child: Text("No promotions available.")),
      loading: () => const Center(child: CircularProgressIndicator()),
      failure: (error) => Center(child: Text('Error: $error')),
      loaded: (promos) => CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: promos.map((promo) {
          return Builder(
            builder: (BuildContext context) {
              return PromoWidget(promo: promo);
            },
          );
        }).toList(),
      ),
    );
  }
}
