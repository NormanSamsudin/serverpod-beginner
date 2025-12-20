import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';
import 'package:serverpod_hackathon_flutter/viewmodels/add_menu_viewmodel.dart';

@RoutePage()
class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formKey = GlobalKey<FormState>();

  String _restaurantName = '';
  String _name = '';
  String _description = '';
  double _price = 0.0;
  String _category = '';
  String _cuisine = '';
  bool _isVegetarian = false;
  bool _isHalal = false;
  int _spicyLevel = 0;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final addMenuViewModel = context.read<AddMenuViewModel>();
      final success = await addMenuViewModel.createMenuItem(
        restaurantName: _restaurantName,
        name: _name,
        description: _description,
        price: _price,
        category: _category,
        cuisine: _cuisine,
        isVegetarian: _isVegetarian,
        isHalal: _isHalal,
        spicyLevel: _spicyLevel,
      );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(addMenuViewModel.successMessage ?? 'Success')),
          );
          context.router.back();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(addMenuViewModel.errorMessage ?? 'Error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final addMenuViewModel = context.watch<AddMenuViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Restaurant Name'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onSaved: (value) => _restaurantName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dish Name'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onSaved: (value) => _description = value!,
                maxLines: 3,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category (e.g., Main Course, Drinks)'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onSaved: (value) => _category = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cuisine (e.g., Chinese, Western)'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onSaved: (value) => _cuisine = value!,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Vegetarian'),
                value: _isVegetarian,
                onChanged: (val) => setState(() => _isVegetarian = val),
              ),
              SwitchListTile(
                title: const Text('Halal'),
                value: _isHalal,
                onChanged: (val) => setState(() => _isHalal = val),
              ),
              const SizedBox(height: 16),
              Text('Spicy Level: $_spicyLevel'),
              Slider(
                value: _spicyLevel.toDouble(),
                min: 0,
                max: 5,
                divisions: 5,
                label: _spicyLevel.toString(),
                onChanged: (val) => setState(() => _spicyLevel = val.round()),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: addMenuViewModel.isLoading ? null : _submit,
                child: addMenuViewModel.isLoading 
                    ? const CircularProgressIndicator() 
                    : const Text('Add Menu Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
