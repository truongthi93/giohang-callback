import 'package:appmuahang/model/product.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'Screen2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> list = ServiceProduct().allProduct();
  List<Product> selectedList = List<Product>();

  _pushToCart(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CardPage(selected: this.selectedList)),
      );
      setState(() {
        this.selectedList = result;
      });
  }


    @override
  Widget build(BuildContext homeContext) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop"),
          actions: <Widget>[
            Container(
                child: Stack(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _pushToCart(homeContext);
                  },
                ),
                new Positioned(
                    child: new Stack(
                  children: <Widget>[
                    new Icon(Icons.brightness_1, size: 22.0, color: Colors.red),
                    new Positioned(
                        top: 4.0,
                        right: 6.0,
                        child: new Center(
                          child: new Text((this.selectedList?.length ?? 0).toString(),
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                )),
              ],
            )),
          ],
        ),
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.57,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return productItem(list[index]);
            },
          ),
        ));
  }

  Widget productItem(Product product) {
    String name = product.name;
    String imageName = product.image;
    String price = product.price.toInt().toString();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2), //                   <--- border color
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(14.0) //         <--- border radius here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Max Size
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                  child: Image(
                    image: AssetImage('$imageName'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 8.0,),
                    Text(
                      '\u0024$price',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.black.withOpacity(0.05))),
                      onPressed: () {
                        setState(() {
                          if (selectedList.contains(product)) {
                              var index = this.selectedList.remove(product);
                          } else {
                            this.selectedList.add(product);
                          }
                        });
                      },
                      child:
                      Text(
                        selectedList.contains(product) ? 'xoá' : "Thêm vào "
                       ,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 8.0,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}