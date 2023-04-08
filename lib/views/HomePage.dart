// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Color PRIMARY_COLOR = Color.fromARGB(255, 255, 125, 27);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int total = 0;
bool visible = false;

class _HomePageState extends State<HomePage> {
  double height(BuildContext context) => MediaQuery.of(context).size.height;
  double width(BuildContext context) => MediaQuery.of(context).size.width;
  int jumlah = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "sneakers",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        SvgPicture.asset("assets/icons/icon-cart.svg"),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "$jumlah",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      "assets/images/image-avatar.png",
                      width: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
          width: width(context) / 2,
          surfaceTintColor: Colors.black,
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: 24,
                  ),
                ),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    drawerItem("Collection"),
                    drawerItem("Men"),
                    drawerItem("Women"),
                    drawerItem("About"),
                    drawerItem("Contact"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: height(context) - 130,
              child: Stack(
                children: [
                  ListView(
                    children: <Widget>[
                      SizedBox(
                          width: width(context),
                          child: CarouselSlider(
                              items: image,
                              options: CarouselOptions(
                                  aspectRatio: 1,
                                  viewportFraction: 1,
                                  autoPlay: false,
                                  enableInfiniteScroll: false))),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "SNEAKER COMPANY",
                                style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Fall Limited Edition\nSneakers",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                                "These low-profile sneakers are your perfect casual wear companion. Featuring a durable rubber outer sole, they'll withstand everything the weather can offer.")
                          ],
                        ),
                      )
                    ],
                  ),
                  cartView(context)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    isDismissible: true,
                    useSafeArea: true,
                    isScrollControlled: true,
                    enableDrag: true,
                    context: context,
                    builder: ((context) {
                      return StatefulBuilder(
                          builder: (context, StateSetter setState) {
                        return BottomItem(setState);
                      });
                    }));
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                width: width(context),
                height: height(context) * 1 / 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "\$125.00",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: PRIMARY_COLOR.withOpacity(0.2)),
                          child: Text(
                            "50%",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$250.00",
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Positioned cartView(BuildContext context) {
    return Positioned(
      top: 30,
      right: 0,
      left: 0,
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 200),
        crossFadeState:
            visible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        firstChild: Container(
          color: Colors.transparent,
        ),
        secondChild: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            height: 300,
            width: width(context) / 1.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/image-product-1-thumbnail.jpg",
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Fall Limited Edition Sneakers",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "\$125.00 x $jumlah",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "\$$total.00",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset("assets/icons/icon-delete.svg")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox drawerItem(String text) {
    return SizedBox(
      height: 30,
      child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  SizedBox BottomItem(StateSetter setState) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: width(context),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "\$125.00",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: PRIMARY_COLOR.withOpacity(0.2)),
                      child: Text(
                        "50%",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: PRIMARY_COLOR),
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$250.00",
                  style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (jumlah > 0) {
                          jumlah = jumlah - 1;
                        } else {
                          jumlah = 0;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.exposure_minus_1,
                      color: PRIMARY_COLOR,
                    )),
                Text(
                  "$jumlah",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        jumlah = jumlah + 1;
                      });
                    },
                    icon: Icon(
                      Icons.plus_one,
                      color: PRIMARY_COLOR,
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    padding: EdgeInsets.all(20)),
                onPressed: () {
                  setState(
                    () {
                      total = jumlah * 125;
                    },
                  );
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: <Widget>[
                          SizedBox(
                            height: height(context) / 5,
                            width: width(context) / 0.8,
                            child: Center(
                              child: Text(
                                "Success",
                                style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                  print(total);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    Text("Add to cart")
                  ],
                )),
          )
        ],
      ),
    );
  }

  List<Image> image = [
    Image.asset("assets/images/image-product-1.jpg"),
    Image.asset("assets/images/image-product-2.jpg"),
    Image.asset("assets/images/image-product-3.jpg"),
    Image.asset("assets/images/image-product-4.jpg"),
  ];
}
