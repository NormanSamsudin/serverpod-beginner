import 'package:serverpod/serverpod.dart';
import 'package:serverpod_hackathon_server/src/generated/protocol.dart';

class MenuSeedEndpoint extends Endpoint {
  /// Seed sample food court menu data
  Future<int> seedMenuData(Session session) async {
    try {
      // Clear existing data (using unsafeQuery for raw SQL)
      await session.db.unsafeQuery('DELETE FROM menu_item');

      final menuItems = [
        // Chinese Restaurant
        MenuItem(
          restaurantName: 'Wong\'s Kitchen',
          name: 'Char Kway Teow',
          description:
              'Stir-fried flat rice noodles with prawns, Chinese sausage, bean sprouts, and eggs in dark soy sauce',
          price: 8.50,
          category: 'Main Course',
          cuisine: 'Chinese',
          isVegetarian: false,
          isHalal: false,
          spicyLevel: 2,
          tags: 'popular,recommended',
        ),
        MenuItem(
          restaurantName: 'Wong\'s Kitchen',
          name: 'Vegetable Fried Rice',
          description:
              'Fragrant fried rice with mixed vegetables, eggs, and light soy sauce',
          price: 6.00,
          category: 'Main Course',
          cuisine: 'Chinese',
          isVegetarian: true,
          isHalal: false,
          spicyLevel: 0,
          tags: 'vegetarian',
        ),
        MenuItem(
          restaurantName: 'Wong\'s Kitchen',
          name: 'Hot and Sour Soup',
          description:
              'Spicy and tangy soup with tofu, mushrooms, bamboo shoots, and eggs',
          price: 5.50,
          category: 'Soup',
          cuisine: 'Chinese',
          isVegetarian: true,
          isHalal: false,
          spicyLevel: 3,
        ),

        // Malay Restaurant
        MenuItem(
          restaurantName: 'Nasi Lemak Corner',
          name: 'Nasi Lemak with Fried Chicken',
          description:
              'Fragrant coconut rice served with crispy fried chicken, sambal, boiled egg, peanuts, and anchovies',
          price: 7.50,
          category: 'Main Course',
          cuisine: 'Malay',
          isVegetarian: false,
          isHalal: true,
          spicyLevel: 2,
          tags: 'popular,recommended,halal',
        ),
        MenuItem(
          restaurantName: 'Nasi Lemak Corner',
          name: 'Rendang Beef',
          description:
              'Slow-cooked beef in rich coconut curry with lemongrass and spices',
          price: 9.00,
          category: 'Main Course',
          cuisine: 'Malay',
          isVegetarian: false,
          isHalal: true,
          spicyLevel: 3,
          tags: 'halal,spicy',
        ),
        MenuItem(
          restaurantName: 'Nasi Lemak Corner',
          name: 'Mee Goreng',
          description:
              'Spicy stir-fried yellow noodles with vegetables, tofu, and chili paste',
          price: 6.50,
          category: 'Main Course',
          cuisine: 'Malay',
          isVegetarian: true,
          isHalal: true,
          spicyLevel: 3,
          tags: 'vegetarian,halal,spicy',
        ),

        // Indian Restaurant
        MenuItem(
          restaurantName: 'Tandoori Express',
          name: 'Chicken Biryani',
          description:
              'Aromatic basmati rice cooked with tender chicken, spices, and saffron',
          price: 8.00,
          category: 'Main Course',
          cuisine: 'Indian',
          isVegetarian: false,
          isHalal: true,
          spicyLevel: 2,
          tags: 'popular,halal',
        ),
        MenuItem(
          restaurantName: 'Tandoori Express',
          name: 'Palak Paneer',
          description: 'Creamy spinach curry with soft paneer cheese cubes',
          price: 7.50,
          category: 'Main Course',
          cuisine: 'Indian',
          isVegetarian: true,
          isHalal: true,
          spicyLevel: 1,
          tags: 'vegetarian,halal',
        ),
        MenuItem(
          restaurantName: 'Tandoori Express',
          name: 'Masala Dosa',
          description:
              'Crispy rice and lentil crepe filled with spiced potato masala',
          price: 6.00,
          category: 'Main Course',
          cuisine: 'Indian',
          isVegetarian: true,
          isHalal: true,
          spicyLevel: 2,
          tags: 'vegetarian,halal,recommended',
        ),

        // Western Restaurant
        MenuItem(
          restaurantName: 'Grill House',
          name: 'Grilled Chicken Chop',
          description:
              'Juicy grilled chicken breast with black pepper sauce, mashed potatoes, and coleslaw',
          price: 12.00,
          category: 'Main Course',
          cuisine: 'Western',
          isVegetarian: false,
          isHalal: false,
          spicyLevel: 0,
          tags: 'popular',
        ),
        MenuItem(
          restaurantName: 'Grill House',
          name: 'Fish and Chips',
          description:
              'Crispy battered fish fillet with golden fries and tartar sauce',
          price: 11.50,
          category: 'Main Course',
          cuisine: 'Western',
          isVegetarian: false,
          isHalal: false,
          spicyLevel: 0,
        ),
        MenuItem(
          restaurantName: 'Grill House',
          name: 'Mushroom Soup',
          description: 'Creamy mushroom soup served with garlic bread',
          price: 5.00,
          category: 'Soup',
          cuisine: 'Western',
          isVegetarian: true,
          isHalal: false,
          spicyLevel: 0,
          tags: 'vegetarian',
        ),

        // Drinks & Desserts
        MenuItem(
          restaurantName: 'Refresh Bar',
          name: 'Teh Tarik',
          description: 'Malaysian pulled milk tea, frothy and sweet',
          price: 2.50,
          category: 'Drinks',
          cuisine: 'Malaysian',
          isVegetarian: true,
          isHalal: true,
          spicyLevel: 0,
          tags: 'popular,halal',
        ),
        MenuItem(
          restaurantName: 'Refresh Bar',
          name: 'Fresh Lime Juice',
          description: 'Refreshing lime juice with ice',
          price: 3.00,
          category: 'Drinks',
          cuisine: 'Malaysian',
          isVegetarian: true,
          isHalal: true,
          spicyLevel: 0,
        ),
        MenuItem(
          restaurantName: 'Sweet Treats',
          name: 'Cendol',
          description:
              'Shaved ice dessert with coconut milk, palm sugar, and green rice flour jelly',
          price: 4.00,
          category: 'Desserts',
          cuisine: 'Malaysian',
          isVegetarian: true,
          isHalal: true,
          spicyLevel: 0,
          tags: 'popular,halal',
        ),
      ];

      int count = 0;
      for (final item in menuItems) {
        await MenuItem.db.insertRow(session, item);
        count++;
      }

      return count;
    } catch (e) {
      session.log('Error seeding menu data: $e', level: LogLevel.error);
      rethrow;
    }
  }
}
