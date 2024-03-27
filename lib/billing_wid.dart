//import 'package:billing/data.dart';

import 'package:billing/model.dart';
import 'package:billing/utils.dart';
import 'package:billing/home.dart';
import 'package:billing/text_dialog_widget.dart';
import 'package:billing/num_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

var gttxt = NumberToWordsEnglish.convert(gt);
int tmpt = 0;

class EditablePage extends StatefulWidget {
  const EditablePage({super.key});

  @override
  _EditablePageState createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();

    // ignore: unnecessary_this
    this.products = List.of(allProducts);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 253, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 237, 253, 255),
          title: const Text('Billing'),
          surfaceTintColor: const Color.fromARGB(255, 237, 253, 255),
          foregroundColor: Colors.deepPurpleAccent,
          shadowColor: const Color.fromARGB(255, 237, 253, 255),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(-0.8, 0),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text('Invoice date : $id\nDue date : $dd')),
                  ),
                  Container(
                    height: 10,
                  ),
                  SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          buildDataTable(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: width - 25,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurpleAccent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                              'Grand total  : $gt Rs/-\nGrand total in words : Rupees $gttxt'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            label: const Text('Print'),
            icon: const Icon(Icons.print),
          ),
        ),
      );

  Widget buildDataTable() {
    final columns = ['Product', 'Price', 'Quantity', 'Total'];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child: DataTable(
        columns: getColumns(columns),
        rows: getRows(products),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      final total = column == columns[3];

      return DataColumn(
        label: Text(column),
        numeric: total,
      );
    }).toList();
  }

  List<DataRow> getRows(List<Product> products) =>
      products.map((Product product) {
        final cells = [
          product.pname,
          product.price,
          product.qty,
          product.total
        ];
        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              SizedBox(
                  width: 40,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Text(cell))),
              onTap: () {
                switch (index) {
                  case 0:
                    editpname(product);
                    break;
                  case 1:
                    editprice(product);
                    break;
                  case 2:
                    editqty(product);
                    break;
                }
              },
            );
          }),
        );
      }).toList();

  Future editpname(Product editProduct) async {
    final pname = await showTextDialog(
      context,
      title: 'Change Product Name',
      value: editProduct.pname,
    );

    setState(() => products = products.map((product) {
          final isEditedProduct = product == editProduct;
          return isEditedProduct ? product.copy(pname: pname) : product;
        }).toList());
    setState(() {
      allProducts = products;
    });
  }

  Future editprice(Product editProduct) async {
    final price = await showNumDialog(
      context,
      title: 'Change Price',
      value: editProduct.price,
    );

    setState(() => products = products.map((product) {
          final isEditedProduct = product == editProduct;
          tmpt = (int.parse(editProduct.price) - int.parse(controllern.text)) *
              int.parse(editProduct.qty);
          return isEditedProduct
              ? product.copy(
                  price: price,
                  total:
                      (int.parse(controllern.text) * int.parse(editProduct.qty))
                          .toString())
              : product;
        }).toList());
    setState(() {
      allProducts = products;
      gt = gt - tmpt;
      gttxt = NumberToWordsEnglish.convert(gt);
    });
  }

  Future editqty(Product editProduct) async {
    final qty = await showNumDialog(
      context,
      title: 'Change Quantity',
      value: editProduct.qty,
    );

    setState(() => products = products.map((product) {
          final isEditedProduct = product == editProduct;
          tmpt = (int.parse(editProduct.qty) - int.parse(controllern.text)) *
              int.parse(editProduct.price);

          return isEditedProduct
              ? product.copy(
                  qty: qty,
                  total: (int.parse(controllern.text) *
                          int.parse(editProduct.price))
                      .toString())
              : product;
        }).toList());

    setState(() {
      allProducts = products;
      gt = gt - tmpt;
      gttxt = NumberToWordsEnglish.convert(gt);
    });
  }
}
