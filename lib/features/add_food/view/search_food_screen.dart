import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/local/database.dart';
import '../../../data/repositories/food_repository.dart';
import '../viewmodel/search_viewmodel.dart';

class SearchFoodScreen extends ConsumerStatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  ConsumerState<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends ConsumerState<SearchFoodScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher'),
        bottom: TabBar(
          controller: _tabCtrl,
          tabs: const [
            Tab(icon: Icon(Icons.search), text: 'Recherche'),
            Tab(icon: Icon(Icons.star), text: 'Favoris'),
            Tab(icon: Icon(Icons.history), text: 'Récents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _buildSearchTab(),
          _buildFavoritesTab(),
          _buildRecentsTab(),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    final results = ref.watch(searchResultsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchCtrl,
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Rechercher un aliment...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: _searchCtrl.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchCtrl.clear();
                        ref.read(searchQueryProvider.notifier).state = '';
                        setState(() {});
                      },
                    ),
            ),
            onChanged: (v) {
              ref.read(searchQueryProvider.notifier).state = v;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: results.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur : $e')),
            data: (foods) => _foodsList(foods, 'Aucun résultat'),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    final favs = ref.watch(favoritesProvider);
    return favs.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (foods) => _foodsList(foods, 'Aucun favori pour le moment'),
    );
  }

  Widget _buildRecentsTab() {
    final rec = ref.watch(recentsProvider);
    return rec.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (foods) => _foodsList(foods, 'Aucun aliment récent'),
    );
  }

  Widget _foodsList(List<Food> foods, String emptyMessage) {
    if (foods.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            emptyMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: foods.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final food = foods[i];
        return ListTile(
          title: Text(food.name),
          subtitle: Text([
            if (food.brand != null) food.brand!,
            '${food.kcalPer100g.toStringAsFixed(0)} kcal / 100 g',
          ].join(' · ')),
          trailing: IconButton(
            icon: Icon(
              food.isFavorite ? Icons.star : Icons.star_border,
              color: food.isFavorite ? Colors.amber : null,
            ),
            onPressed: () async {
              await ref
                  .read(foodRepositoryProvider)
                  .toggleFavorite(food.id);
              ref.invalidate(favoritesProvider);
              ref.invalidate(searchResultsProvider);
              ref.invalidate(recentsProvider);
            },
          ),
          onTap: () => context.push('/add-food/quantity/${food.id}'),
        );
      },
    );
  }
}
