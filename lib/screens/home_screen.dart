import 'package:flutter/material.dart';
import 'package:sebbo/configurations.dart';
import 'package:sebbo/constants.dart';
import 'package:sebbo/models/product.dart';
import 'package:sebbo/screens/profile_screen.dart';
import 'package:sebbo/screens/search_screen.dart';
import 'package:sebbo/widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedCategory = 0;
  final _suggestedProducts = <Product>[
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
    Product(
        id: 'a1',
        description:
            'lorem fnalkdasdmm amdoamdoimo dmoamd in nfnaisnjfn indfa nafn ;aofj oifmoa noan oan nonoanfaoen oanbfoanfeon onoanwedmnajmn mnamnsdoamodmaomda ndaod o',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind having all the knowledge required'),
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
    Product(
        id: 'a1',
        description: 'bal lla flaslfla f',
        price: 299,
        imageUrl: 'https://picsum.photos/200',
        listedOn: DateTime.now(),
        owner: 'Rakesh Roshan',
        title: 'First book of mankind'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        titleSpacing: 10,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Icon(
              Icons.location_pin,
              size: 18,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Ghaziabad, UP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.expand_more,
              size: 20,
              color: Colors.white,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.profileRoute);
              },
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/200',
                ), //User's profile picture will show up here
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SearchScreen.searchRoute);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search with book name, author name...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(60),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blueAccent, Colors.blue],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          //Search box finished
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              'Browse Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _categoriesBuilder(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              'Freshly Recommended',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: _suggestedProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) => ProductItem(
              product: _suggestedProducts[i],
              addedToCart: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoriesBuilder() {
    return Container(
      height: 120,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = index;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // gradient:
                      //     selectedCategory == index ? themeGradient : null,
                      color: _selectedCategory == index
                          ? categories[index]['color']
                          : Colors.white,
                      border: Border.all(
                        width: 2,
                        color: _selectedCategory == index
                            ? Colors.white
                            : categories[index]['color'],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      categories[index]['icon'],
                      color: _selectedCategory == index
                          ? Colors.white
                          : categories[index]['color'],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  categories[index]['name'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: _selectedCategory == index
                        ? FontWeight.w400
                        : FontWeight.normal,
                    color:
                        _selectedCategory == index ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
