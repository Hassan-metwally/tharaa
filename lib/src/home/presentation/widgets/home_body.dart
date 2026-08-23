part of '../home_page.dart';

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: AdsWidget()),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        const SliverToBoxAdapter(child: MainCategoriesHomeWidget()),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        const SliverToBoxAdapter(child: OffersProductsWidget()),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        const SliverToBoxAdapter(child: MostRequestedProductsWidget()),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
