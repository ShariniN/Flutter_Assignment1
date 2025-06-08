import 'package:flutter/material.dart';
import '/widgets/product_card.dart';
import '/widgets/navbar.dart';
import '/widgets/product.dart';
import '/data/product_data.dart';
import 'product_screen.dart'; 

class CategoryPage extends StatefulWidget {
  final String categoryType;
  final String categoryName;
  final List<Product> products;
  
  const CategoryPage({
    Key? key,
    required this.categoryType,
    required this.categoryName,
    required this.products,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _currentIndex = 1;

  late RangeValues _priceRange;
  List<String> _selectedBrands = [];

  late List<String> _brands;
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _initializeFilters();
    _applyFilters();
  }

  void _initializeFilters() {
    _brands = ProductData.getBrandsByCategory(widget.categoryType);
    
    final priceRange = ProductData.getPriceRangeByCategory(widget.categoryType);
    _priceRange = RangeValues(
      priceRange['min']!,
      priceRange['max']!,
    );
  }

  void _applyFilters() {
    List<Product> filtered = List.from(widget.products);

    filtered = filtered.where((product) =>
        product.price >= _priceRange.start &&
        product.price <= _priceRange.end).toList();

    if (_selectedBrands.isNotEmpty) {
      filtered = filtered.where((product) =>
          _selectedBrands.contains(product.brand)).toList();
    }

    setState(() {
      _filteredProducts = filtered;
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

  void onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  void _showFiltersSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFiltersSheet(),
    );
  }

  Widget _buildFiltersSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back, 
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Filters',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildPriceFilter(),
                SizedBox(height: 16),
                _buildBrandFilter(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _applyFilters();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.black 
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceFilter() {
    final priceRange = ProductData.getPriceRangeByCategory(widget.categoryType);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'From',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Spacer(),
            Text(
              'To',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '\$${_priceRange.start.round()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '\$${_priceRange.end.round()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
        RangeSlider(
          values: _priceRange,
          min: priceRange['min']!,
          max: priceRange['max']!,
          divisions: 50,
          activeColor: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white 
              : Colors.black,
          inactiveColor: Colors.grey[300],
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBrandFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brand',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 250,
          child: ListView.builder(
            itemCount: _brands.length,
            itemBuilder: (context, index) {
              final brand = _brands[index];
              final isSelected = _selectedBrands.contains(brand);
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedBrands.remove(brand);
                    } else {
                      _selectedBrands.add(brand);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? (Theme.of(context).brightness == Brightness.dark 
                                  ? Colors.white 
                                  : Colors.black)
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected 
                                ? (Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.white 
                                    : Colors.black)
                                : Colors.grey[400]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 14,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.black 
                                    : Colors.white,
                              )
                            : null,
                      ),
                      SizedBox(width: 12),
                      Text(
                        brand,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return NavigationLayout(
      title: widget.categoryName,
      currentIndex: _currentIndex,
      onTabChanged: onTabChanged,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isLandscape ? 8 : 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: isLandscape ? 32 : 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(
                            ProductData.getCategoryIcons()[widget.categoryType] ?? Icons.category,
                            color: Theme.of(context).iconTheme.color,
                            size: isLandscape ? 16 : 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.categoryName,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: isLandscape ? 14 : 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).iconTheme.color,
                    size: isLandscape ? 20 : 24,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 8 : 16, 
              vertical: isLandscape ? 6 : 12
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showFiltersSheet,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLandscape ? 8 : 12, 
                      vertical: isLandscape ? 4 : 8
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Filters',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: isLandscape ? 12 : 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.tune,
                          size: isLandscape ? 14 : 16,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        if (_selectedBrands.isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (!isLandscape || screenHeight > 500)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? 8 : 16, 
                vertical: isLandscape ? 4 : 8
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Products Result: ${_filteredProducts.length}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: isLandscape ? 12 : 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: isLandscape ? 8 : 16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isLandscape ? 3 : 2,
                        childAspectRatio: isLandscape ? 0.9 : 0.8,
                        crossAxisSpacing: isLandscape ? 8 : 12,
                        mainAxisSpacing: isLandscape ? 8 : 12,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return GestureDetector(
                          onTap: () => _onProductTap(product),
                          child: ProductCard(
                            title: product.title,
                            subtitle: product.subtitle,
                            price: '\$${product.price}',
                            icon: product.icon
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}