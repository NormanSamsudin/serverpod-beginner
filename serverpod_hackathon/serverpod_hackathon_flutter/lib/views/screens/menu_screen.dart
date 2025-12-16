import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';
import 'package:serverpod_hackathon_flutter/main.dart';
import 'package:serverpod_hackathon_flutter/generated/l10n.dart';
import 'package:serverpod_hackathon_flutter/views/screens/base_screen.dart';

@RoutePage()
class MenuScreen extends BaseScreen {
  const MenuScreen({super.key});

  @override
  BaseScreenState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends BaseScreenState<MenuScreen> {
  List<MenuItem>? _menuItems;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchMenu();
  }

  Future<void> _fetchMenu() async {
    try {
      final items = await client.menu.getAllMenuItems();
      if (mounted) {
        setState(() {
          _menuItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget buildAppBarTitle(BuildContext context) {
    return Text(S.of(context).menuTab);
  }

  @override
  Widget buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    if (_menuItems == null || _menuItems!.isEmpty) {
      return const Center(child: Text('No menu items found.'));
    }

    return RefreshIndicator(
      onRefresh: _fetchMenu,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _menuItems!.length,
        itemBuilder: (context, index) {
          final item = _menuItems![index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ListTile(
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.restaurantName),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (item.isVegetarian)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(label: Text('Veg'), visualDensity: VisualDensity.compact),
                        ),
                      if (item.isHalal)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(label: Text('Halal'), visualDensity: VisualDensity.compact),
                        ),
                      if (item.spicyLevel > 0)
                        Chip(
                          label: Text('Spicy ${item.spicyLevel}'),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: Colors.red.withOpacity(0.1),
                        ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                'RM${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
