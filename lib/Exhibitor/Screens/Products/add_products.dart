import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constants/app_color.dart';
import '../../Controllers/products_provider.dart';
import '../../Controllers/profile_provider.dart';
import '../../Models/profile_model.dart';

class ProductSearchBottomSheet extends StatefulWidget {
  final String eventName;
  final int eventId;

  ProductSearchBottomSheet({required this.eventName, required this.eventId});

  @override
  _ProductSearchBottomSheetState createState() =>
      _ProductSearchBottomSheetState();
}

class _ProductSearchBottomSheetState extends State<ProductSearchBottomSheet> {
  TextEditingController _searchController = TextEditingController();
  List<Product> searchResults = [];
  String selectedProductId = '';
  String? selectedProductName = '';
  List<String> productId = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadProfileData();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      search(_searchController.text);
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  Future<void> _loadProfileData() async {
    var profileData = await Provider.of<ProfileProvider>(context, listen: false)
        .profileData();
    if (profileData != null && profileData is Map<String, dynamic>) {
      var profileModel = ProfileModel.fromJson(profileData);
      for (var event in profileModel.data!.events!) {
        if (event.id == widget.eventId) {
          productId =
              event.eventProducts?.map((e) => e.id.toString()).toList() ?? [];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: AppColor.secondary),
                prefixIcon: Icon(Icons.search, color: AppColor.secondary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: AppColor.primary),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(searchResults[index].name ?? ''),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.26,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _addProduct(searchResults[index]);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('No results found'),
                  ),
          ),
        ],
      ),
    );
  }

  void search(String query) async {
    try {
      var response = await ProductsProvider().productDetails(query);
      if (response != null && response['data'] != null) {
        List<Product> results = (response['data'] as List)
            .map((data) => Product(id: data['id'], name: data['name']))
            .toList();
        setState(() {
          searchResults = results;
        });
      } else {
        setState(() {
          searchResults = [];
        });
      }
    } catch (error) {
      setState(() {
        searchResults = [];
      });
    }
  }

  // void _addProduct(Product product) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Add Product"),
  //         content: Text("Do you want to add this product?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               EventProduct newEventProduct = EventProduct(
  //                 id: product.id.toString(),
  //                 name: product.name ?? '', // Handle potential null value
  //               );
  //               setState(() {
  //                 productId.add(newEventProduct.id ?? '');
  //               });
  //
  //               ProductsProvider().addProductstoCurrentEvent(
  //                 widget.eventId,
  //                 productId,
  //               );
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Add"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _addProduct(Product product) {
    if (productId.contains(product.id.toString())) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error in Adding Product"),
            content: Text('Product ${product.name ?? ''} is already added.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Go back"),
              ),

            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Product"),
            content: Text("Do you want to add this product?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  EventProduct newEventProduct = EventProduct(
                    id: product.id.toString(),
                    name: product.name ?? '', // Handle potential null value
                  );
                  setState(() {
                    productId.add(newEventProduct.id ?? '');
                  });

                  ProductsProvider().addProductstoCurrentEvent(
                    widget.eventId,
                    productId,
                  );
                  Navigator.of(context).pop();
                },
                child: Text("Add"),
              ),
            ],
          );
        },
      );
    }
  }

}
