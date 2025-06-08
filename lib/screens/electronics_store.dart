// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import '/widgets/product_card.dart';
import '/widgets/large_product_card.dart';
import '/widgets/navbar.dart';

class ElectronicsStore extends StatefulWidget {
  @override
  State<ElectronicsStore> createState() => _ElectronicsStoreState();
}

class _ElectronicsStoreState extends State<ElectronicsStore> {
  int _currentIndex = 0;
  
  void onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _buildSections(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return [
      Container(
        height: 400,
        width: double.infinity,
        child: Image.asset(
          'images/banner.png', 
          fit: BoxFit.cover,
        ),
      ),
      
      // AirPods & Apple Watch Row
      Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ProductCard(
                title: 'AirPods Pro',
                subtitle: '2nd generation',
                price: '\$249',
                color: theme.cardColor,
                icon: Icons.headphones,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ProductCard(
                title: 'Apple Watch',
                subtitle: 'Series 8',
                price: '\$399',
                color: theme.cardColor,
                icon: Icons.watch,
              ),
            ),
          ],
        ),
      ),
      
      // iPhone & AirPods Row + Categories
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ProductCard(
                    title: 'iPhone 14',
                    subtitle: 'From \$799',
                    price: '',
                    color: theme.cardColor,
                    icon: Icons.phone_iphone,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ProductCard(
                    title: 'AirPods',
                    subtitle: '3rd generation',
                    price: '\$179',
                    color: theme.cardColor,
                    icon: Icons.earbuds,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Categories',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      // Spacer
      SizedBox(height: 16),
      
      // Large Product Cards
      LargeProductCard(
        title: 'Apple',
        subtitle: 'iPhone Max',
        backgroundColor: isDark ? Color(0xFF2D3748) : Color(0xFFe8f5e8),
      ),
      
      LargeProductCard(
        title: 'Apple Vision Pro',
        subtitle: '',
        backgroundColor: isDark ? Color(0xFF1A202C) : Color(0xFFf3e5f5),
      ),
      
      LargeProductCard(
        title: 'PlayStation 5',
        subtitle: '',
        backgroundColor: isDark ? Color(0xFF2D3748) : Color(0xFFe3f2fd),
      ),
      
      LargeProductCard(
        title: 'MacBook Air',
        subtitle: '',
        backgroundColor: isDark ? Color(0xFF4A5568) : Color(0xFFfff3e0),
      ),
      
      LargeProductCard(
        title: 'iPad Pro',
        subtitle: '',
        backgroundColor: isDark ? Color(0xFF2D3748) : Color(0xFFfce4ec),
      ),
      
      // Sale Banner
      Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF667eea),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Big Summer Sale',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Up to 50% off',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      
      // Bottom Spacer
      SizedBox(height: 100),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(context);
    
    return NavigationLayout(
      title: 'Electronics Store',
      currentIndex: _currentIndex,
      onTabChanged: onTabChanged,
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return sections[index];
        },
      ),
    );
  }
}