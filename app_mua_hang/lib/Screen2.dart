import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/product.dart';

class CardPage extends StatefulWidget {
  final List<Product> selected;
  CardPage({Key key, @required this.selected});

  @override
  _CardPageState createState() => _CardPageState(selectedProduct: selected);
}

class _CardPageState extends State<CardPage> {
  List<Product> selectedProduct;
  _CardPageState({Key key, @required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, this.selectedProduct);
          },
          child: Icon(
            Icons.arrow_back,  // add custom icons also
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: _productListView(context),
      ),
    );
  }

  Widget _productListView(BuildContext context) {
    return ListView.builder(
      itemCount: this.selectedProduct.length,
      itemBuilder: (context, index) {
        return Card( //                           <-- Card widget
          child: ListTile(
            trailing: GestureDetector(
              onTap: () {
                print(selectedProduct.length);
                print(index);
                setState(() {
                  this.selectedProduct.removeAt(index);
                  this.selectedProduct = this.selectedProduct;
                });
              },
              child: Icon(
                Icons.delete,
                size: 25,
                color: Colors.red,
              ),
            ),
            leading: Image(image: AssetImage(selectedProduct[index].image),  fit: BoxFit.fitWidth,),
            title: Text(selectedProduct[index].name),
          ),
        );
      },
    );
  }
}