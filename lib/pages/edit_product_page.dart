import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductPage extends StatefulWidget {
  // const EditProductPage({ Key? key }) : super(key: key);
  static const routeName = '/edit-product';

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _urlController = TextEditingController();
  final _urlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    description: '',
    id: null,
    imageUrl: '',
    price: 0,
    title: '',
    // isFavourite: false,
  );

  // @override
  void dispose() {
    _urlFocusNode.removeListener(_updateImgUrl);
    _priceFocusNode.dispose();

    _descriptionFocusNode.dispose();
    _urlController.dispose();
    _urlFocusNode.dispose();

    super.dispose();
  }

  void initState() {
    super.initState();
    _urlFocusNode.addListener(_updateImgUrl);
  }

  void _updateImgUrl() {
    if (!_urlFocusNode.hasFocus) {
      if (!((_urlController.text.startsWith('http:') ||
              _urlController.text.startsWith('https')) &&
          (_urlController.text.endsWith('.jpg') ||
              _urlController.text.endsWith('.jpeg') ||
              _urlController.text.endsWith('.png')))) {
        return;
      }
      setState(() {});
    }
  }

  void a() {
    print(_editedProduct.id);
    print(_editedProduct.id);
  }

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imgURL': '',
  };

  var _isInit = true;
  var _isLoading = false;
  String productId;

  void didChangeDependencies() {
    if (_isInit) {
      productId = ModalRoute.of(context).settings.arguments as String;
      // print(productId);
      if (productId != null) {
        _editedProduct = Provider.of<Products>(
          context,
          listen: false,
        ).findById(productId);

        print(_editedProduct);
        // print(_editedProduct.title);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          // 'imgURL': _editedProduct.imageUrl,
          'imgURL': '',
        };
        _urlController.text = _editedProduct.imageUrl;
      }
    }

    super.didChangeDependencies();
    _isInit = false;
  }

  Future<void> _saveForm(String prodID) async {
    // print(_editedProduct.title);
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (productId == null) {
      try {
        await Provider.of<Products>(
          context,
          listen: false,
        ).addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Okay'))
                  ],
                  title: Text('An error occurred!'),
                  content: Text('Something went wrong.'),
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    } else {
      await Provider.of<Products>(
        context,
        listen: false,
      ).updateproduct(prodID, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm(_editedProduct.id);
            },
            icon: Icon(
              Icons.save,
              // color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(
                15,
              ),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (val) {
                          _editedProduct = Product(
                            description: _editedProduct.description,
                            id: _editedProduct.id,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                            title: val,
                            isFavourite: _editedProduct.isFavourite,
                          );
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter the Title';
                          }
                          return null;
                        },
                        initialValue: _initValues['title'],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Price',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (val) {
                          _editedProduct = Product(
                            description: _editedProduct.description,
                            id: null,
                            imageUrl: _editedProduct.imageUrl,
                            price: double.parse(val),
                            title: _editedProduct.title,
                            isFavourite: _editedProduct.isFavourite,
                          );
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter the Price';
                          }
                          if (double.tryParse(val) == null) {
                            return 'Please enter a valid number';
                          }
                          if (double.parse(val) <= 0) {
                            return 'Price cannot be 0 or a negative number';
                          }
                          return null;
                        },
                        initialValue: _initValues['price'],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        maxLines: 3,
                        onSaved: (val) {
                          _editedProduct = Product(
                            description: val,
                            id: null,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                            title: _editedProduct.title,
                            isFavourite: _editedProduct.isFavourite,
                          );
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter the Description';
                          }
                          return null;
                        },
                        initialValue: _initValues['description'],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                top: 8,
                                right: 10,
                              ),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: _urlController.text.isEmpty
                                  ? Center(
                                      child: Text('Enter URL'),
                                    )
                                  : FittedBox(
                                      child: Image.network(
                                        _urlController.text,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Image URL',
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _urlController,
                              focusNode: _urlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm(_editedProduct.id);
                              },
                              onSaved: (val) {
                                _editedProduct = Product(
                                  description: _editedProduct.description,
                                  id: null,
                                  imageUrl: val,
                                  price: _editedProduct.price,
                                  title: _editedProduct.title,
                                  isFavourite: _editedProduct.isFavourite,
                                );
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please enter the URL';
                                }
                                if (!((val.startsWith('http:') ||
                                        val.startsWith('https:')) &&
                                    (val.endsWith('jpg') ||
                                        val.endsWith('jpeg') ||
                                        val.endsWith('png')))) {
                                  return 'Please enter a valid image URL';
                                }
                                return null;
                              },
                              // initialValue: _initValues['imgURL'],
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
