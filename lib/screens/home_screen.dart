import 'package:flutter/material.dart';
import 'package:sebbo/configurations.dart';
import 'package:sebbo/models/product.dart';
import 'package:sebbo/screens/search_screen.dart';
import 'package:sebbo/widgets/custom_drawer.dart';
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
    //design specific variables
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    // final HEIGHT10 = HEIGHT / 53;
    // final WIDTH10 = WIDTH / 32;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        titleSpacing: WIDTH > 350 ? 10 : 5,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: WIDTH > 350 ? 24 : 20,
        ),
        title: Row(
          children: [
            Icon(
              Icons.location_pin,
              size: 18,
              color: Colors.white,
            ),
            SizedBox(
              width: WIDTH > 350 ? 10 : 5,
            ),
            Text(
              'Ghaziabad, UP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: WIDTH > 350 ? 10 : 5,
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
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                print("Push notifications screen");
              },
              child: Icon(
                Icons.notifications,
                color: Colors.white,
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
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: WIDTH > 350 ? 20 : 10),
              margin: EdgeInsets.fromLTRB(WIDTH > 350 ? 10 : 5, 0,
                  WIDTH > 350 ? 10 : 5, WIDTH > 350 ? 10 : 5),
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
                    size: WIDTH > 350 ? 24 : 18,
                  ),
                  SizedBox(
                    width: WIDTH > 350 ? 10 : 5,
                  ),
                  Text(
                    'Search with book name, author name...',
                    style: TextStyle(
                      fontSize: WIDTH > 350 ? 16 : 14,
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(WIDTH > 350 ? 60 : 40),
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
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Push Add book screen line 192 home screen');
        },
        label: Row(
          children: [
            Icon(Icons.add_outlined),
            SizedBox(
              width: WIDTH > 350 ? 5 : 1,
            ),
            Text(
              'Add a book',
              style: TextStyle(
                fontSize: WIDTH > 350 ? 16 : 12,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          //Search box finished
          SizedBox(
            height: WIDTH > 350 ? 20 : 14,
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
            padding: EdgeInsets.all(WIDTH > 350 ? 10 : 5),
            itemCount: _suggestedProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: WIDTH > 350 ? 10 : 5,
              crossAxisSpacing: WIDTH > 350 ? 10 : 5,
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
    final WIDTH = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: WIDTH > 350 ? 20 : 10),
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
                    width: WIDTH > 350 ? 70 : 60,
                    height: WIDTH > 350 ? 70 : 60,
                    margin:
                        EdgeInsets.symmetric(horizontal: WIDTH > 350 ? 18 : 12),
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
                      borderRadius: BorderRadius.circular(35),
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
                    fontSize: WIDTH > 350 ? 12 : 10,
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
