import 'package:billing/billing_wid.dart';
import 'package:billing/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _formkey = GlobalKey<FormState>();
TextEditingController product_name = TextEditingController();
TextEditingController product_price = TextEditingController();
TextEditingController quantity = TextEditingController();
TextEditingController product_total = TextEditingController();
var in_date = 'Invoice date';
var du_date = 'Due date';
var id = '';
var dd = '';
var allProducts = <Product>[];
var tb_state = false;
var gt = 0;
double width = 0;

class GradientContainer extends StatefulWidget {
  const GradientContainer({super.key});

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  @override
  Widget build(dynamic context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 253, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 253, 255),
        title: const Text('Billing'),
        surfaceTintColor: const Color.fromARGB(255, 237, 253, 255),
        foregroundColor: Colors.deepPurpleAccent,
        shadowColor: const Color.fromARGB(255, 237, 253, 255),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: width * 0.65,
            child: Column(
              children: [
                Container(
                  height: 10,
                ),
                Align(
                  alignment: const Alignment(1, 0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      DateTime? indate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2034),
                      );
                      if (indate != null) {
                        setState(() {
                          in_date =
                              ('${indate.day}/${indate.month}/${indate.year}')
                                  .toString();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    label: Text(in_date),
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
                // ignore: prefer_const_constructors
                Align(
                  alignment: const Alignment(0.7, 0),
                  child: const Text('To'),
                ),
                Align(
                  alignment: const Alignment(1, 0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (in_date != 'Invoice date') {
                        DateTime? dudate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2034),
                        );
                        if (dudate != null) {
                          setState(() {
                            du_date =
                                ('${dudate.day}/${dudate.month}/${dudate.year}')
                                    .toString();
                            id = in_date;
                            dd = du_date;
                            tb_state = true;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    label: Text(du_date),
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  controller: product_name,
                  enabled: tb_state,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 74, 197, 245),
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 5, 21),
                        width: 2,
                      ),
                    ),
                    //suffixText: 'username',
                    hintText: 'Product name',
                    prefixIcon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                //price
                TextField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: product_price,
                  enabled: tb_state,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 74, 197, 245),
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 5, 21),
                        width: 2,
                      ),
                    ),
                    //suffixText: 'username',
                    hintText: 'Product price',
                    prefixIcon: const Icon(
                      Icons.money,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                //quantity
                TextField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: quantity,
                  enabled: tb_state,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 74, 197, 245),
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 5, 21),
                        width: 2,
                      ),
                    ),
                    //suffixText: 'username',
                    hintText: 'Quantity of the product',
                    prefixIcon: const Icon(
                      Icons.add,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  onChanged: (context) {
                    product_total.text = (int.parse(product_price.text) *
                            int.parse(quantity.text))
                        .toString();
                  },
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  controller: product_total,
                  enabled: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 74, 197, 245),
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 22, 174, 235),
                        width: 2,
                      ),
                    ),
                    //suffixText: 'username',
                    hintText: 'Total price / product',
                    prefixIcon: const Icon(
                      Icons.wallet,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(
                          () {
                            in_date = 'Invoice date';
                            du_date = 'Due date';
                            product_name.clear();
                            product_price.clear();
                            quantity.clear();
                            product_total.clear();
                            tb_state = false;
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 247, 51, 51),
                      ),
                      label: const Text('Reset'),
                      icon: const Icon(Icons.repeat),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (!(product_name.value.text.isEmpty) &&
                            !(product_price.value.text.isEmpty) &&
                            !(quantity.value.text.isEmpty)) {
                          setState(
                            () {
                              gt =
                                  gt + int.parse(product_total.text.toString());
                              allProducts.add(Product(
                                pname: product_name.text.toString(),
                                price: product_price.text.toString(),
                                qty: quantity.text.toString(),
                                total: product_total.text.toString(),
                              ));
                              Fluttertoast.showToast(
                                  msg: "Product Added",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              /*showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                  title: const Text('Product added'),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  content: const Text(
                                      'the product you selected has been successfully added to the bill'),
                                ),
                              );*/
                            },
                          );

                          product_name.clear();
                          product_price.clear();
                          quantity.clear();
                          product_total.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      label: const Text('Add'),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (!(allProducts.isEmpty)) {
                        //print(mlist[0]);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const EditablePage()),
                        );
                      }
                    },
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    label: const Text('Checkout'),
                    icon: const Icon(Icons.shopping_cart_checkout),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
