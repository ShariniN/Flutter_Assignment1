import 'package:flutter/material.dart';
import '/widgets/product_card.dart';
import '/widgets/large_product_card.dart';
import '/widgets/navbar.dart';
import '/data/product_data.dart';
import '/widgets/product.dart';
import 'product_screen.dart';

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

  void _onProductTap(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5A5CE6), Color(0xFF7C83FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5A5CE6).withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: product.hasValidImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      product.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5A5CE6),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${product.rating}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final allProducts = ProductData.getAllProducts();
    final featuredProducts = allProducts.take(4).toList();
    
    return [
      Container(
        height: 400,
        width: double.infinity,
        child: Image.asset(
          'images/banner.png', 
          fit: BoxFit.cover,
        ),
      ),
      
      SizedBox(height: 20,);

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: featuredProducts.length,
          itemBuilder: (context, index) {
            final product = featuredProducts[index];
            return GestureDetector(
              onTap: () => _onProductTap(product),
              child: _buildProductCard(product),
            );
          },
        ),
      ),
      
      SizedBox(height: 16),
      
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Categories',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
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