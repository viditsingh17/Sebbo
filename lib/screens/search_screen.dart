import 'package:flutter/material.dart';
import 'package:sebbo/models/product.dart';
import 'package:sebbo/widgets/product_item.dart';

class SearchScreen extends StatefulWidget {
  static const String searchRoute = '/home/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool firstHandNeeded = true, secondHandNeeded = true;
  List<Map> filterChipList = [
    {
      'label': 'Syllabus',
      'status': false,
    },
    {
      'label': 'Handwritten',
      'status': false,
    },
    {
      'label': 'IIT',
      'status': false,
    },
    {
      'label': 'Medical',
      'status': false,
    },
    {
      'label': 'classes 1-4',
      'status': false,
    },
    {
      'label': 'classes 5&6',
      'status': false,
    },
    {
      'label': 'Novels & Storybooks',
      'status': false,
    },
  ];
  var resultProducts = <Product>[
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
      // appBar: AppBar(
      //   title: Text('Search'),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15.0),
      //       child: CircleAvatar(
      //         radius: 18,
      //         child: Text('U'), //User's profile picture will show up here
      //       ),
      //     ),
      //   ],
      // ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                'Search',
                style: TextStyle(
                  fontSize: 22,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            // padding: const EdgeInsets.all(20),
            width: double.infinity,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      Expanded(
                        child: TextField(
                          autocorrect: true,
                          style: TextStyle(
                            fontSize: 16,
                            height: 0.5,
                          ),
                          scrollPadding: const EdgeInsets.all(0),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            alignLabelWithHint: true,

                            contentPadding: const EdgeInsets.all(0),

                            // errorText: 'Search key invalid',

                            labelText: 'Search with book name, author name...',
                            isDense: true,
                            filled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text('First hand'),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: firstHandNeeded,
                    onChanged: (value) {
                      setState(() {
                        firstHandNeeded = value;
                      });
                    }),
                CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text('Second hand'),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: secondHandNeeded,
                    onChanged: (value) {
                      setState(() {
                        secondHandNeeded = value;
                      });
                    }),
                Wrap(
                  spacing: 5,
                  runSpacing: -9,
                  children: filterChipList
                      .map(
                        (item) => FilterChip(
                          selected: item['status'],
                          label: Text(item['label']),
                          onSelected: (value) {
                            setState(() {
                              item['status'] = value;
                            });
                          },
                        ),
                      )
                      .toList()
                      .cast<Widget>(),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Submitted');
                    },
                    child: Text('Let\'s go!'),
                  ),
                ),
              ],
            ),
          ),
          //Search box finished
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Text(
              'Results',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: resultProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) => ProductItem(
              product: resultProducts[i],
              addedToCart: false,
            ),
          ),
        ],
      ),
    );
  }
}
