import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sebbo/constants.dart';
import 'package:sebbo/models/userData.dart';
import 'package:sebbo/userInfo.dart';
import 'package:sebbo/widgets/custom_header_back.dart';

class ProfileScreen extends StatefulWidget {
  static String profileRoute = '/home/profile';
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Razorpay _razorpay;
  @override
  void initState() {
    super.initState();

    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _openCheckout() {
    var options = {
      "key": "rzp_test_sP23BjqCUfMFbX",
      "amount": "500",
      "name": "Sebbo Co.",
      "description": "Add money to wallet",
      "contact": "8282828282",
      "email": "sampleemail@gmail.com",
      "external": {
        "wallets": ["Paytm", "PhonePe"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //design specific
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    final HEIGHT10 = HEIGHT / 53;
    final WIDTH10 = WIDTH / 32;
    //first name only
    final String _numberOfBooksListed = currentUser.noOfBooks.toString();
    final String _numberOfBooksSold = currentUser.sold.toString();
    final String _credits = currentUser.wallet.toString();
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          CustomHeaderBack(
            title: 'Profile',
          ),
          Padding(
            padding: EdgeInsets.only(
              top: WIDTH > 350 ? 30 : 15,
              left: 18.0,
            ),
            child: Text(
              currentUser.name,
              style: TextStyle(
                fontSize: WIDTH > 350 ? 50 : 36,
                color: Colors.black,
                height: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
            ),
            child: Text(
              'Seller/Buyer',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: TextButton(
              onPressed: () {
                debugPrint('Edit Profile');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return UserInfo(flag: false);
                }));
              },

              //This is just shown to self
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Edit Profile'),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: WIDTH > 350 ? 20 : 10,
              vertical: WIDTH > 350 ? 40 : 35,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconValueBuilder(
                    Icons.account_balance_wallet_outlined, _credits, 'Credit'),
                _iconValueBuilder(
                    Icons.auto_stories, _numberOfBooksListed, 'Books'),
                _iconValueBuilder(Icons.store_mall_directory_outlined,
                    _numberOfBooksSold, 'Sold'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Text(
              'Your wallet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _credits,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Current Balance',
                        style: subhead2.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      //This add the access to Razorpay gateway
                      _openCheckout();
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: themeGradient,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.blue.withOpacity(0.5), //color of shadow
                            spreadRadius: 7, //spread radius
                            blurRadius: 15, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Text(
              'Your uploads',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(5),
            itemCount: 21,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (ctx, i) => Image.network('https://picsum.photos/200'),
          )
        ],
      ),
    );
  }

  Widget _iconValueBuilder(icon, value, label) {
    final WIDTH = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Icon(
            icon,
            size: WIDTH > 350 ? 100 : 75,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
        Container(
          height: 60,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: subhead2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _handlePaymentSuccess() {
  print("Payment made was successful");
  //TODO: add money to the database
}

void _handlePaymentFailure() {
  print("Payment made was unsuccessful");
}

void _handleExternalWallet() {}
