import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:medicall_exhibitor/Constants/spacing.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/Products/add_products.dart';
import 'package:provider/provider.dart';
import '../../../Constants/app_color.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/search.dart';
import '../../Controllers/local_data.dart';
import '../../Controllers/products_provider.dart';
import '../../Controllers/profile_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var profileDetails = GetStorage().read("profileData") != ''
      ? GetStorage().read("profileData")
      : '';
  bool pinCode = true;
  bool zipCode = false;
  bool country = false;
  late File _selectedImage = File('');
  bool show = false;

  Map<String, dynamic> editedProfile = {};

  List productId = [];

  Future<void> _pickImage() async {
    // show = true;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      String base64Image = base64Encode(_selectedImage.readAsBytesSync());
      ProfileProvider().editLogo(base64Image);
    }
  }

  var tokenDetails = GetStorage().read("local_store") != ''
      ? GetStorage().read("local_store")
      : '';

  @override
  Widget build(BuildContext context) {
    editedProfile['name'] = profileDetails['data']['name'];
    editedProfile['email'] = profileDetails['data']['email'];
    editedProfile['category_id'] = profileDetails['data']['category_id'];
    editedProfile['category_name'] = profileDetails['data']['category_name'];
    editedProfile['description'] = profileDetails['data']['description'];
    editedProfile['website_url'] = profileDetails['data']['website_url'];
    editedProfile['salutation'] = profileDetails['data']['salutation'];
    editedProfile['contact_person'] = profileDetails['data']['contact_person'];
    editedProfile['designation'] = profileDetails['data']['designation'];
    editedProfile['contact_number'] = profileDetails['data']['contact_number'];
    editedProfile['pincode'] = profileDetails['data']['pincode'];
    editedProfile['city'] = profileDetails['data']['city'];
    editedProfile['state'] = profileDetails['data']['state'];
    editedProfile['country'] = profileDetails['data']['country'];
    editedProfile['address'] = profileDetails['data']['address'];
    editedProfile['product_id'] = profileDetails['data']['product_id'];

    for (int i = 0; i < profileDetails['data']['events'].length; i++)
      if (profileDetails['data']['events'][i]['id'] ==
          tokenDetails['current_event_id']) {
        for (var items in profileDetails['data']['events'][i]['products'])
          productId.add(items['id']);
      }

    return Scaffold(
        backgroundColor: AppColor.bgColor,
        body: SingleChildScrollView(
          child: Consumer<LocalDataProvider>(
            builder: (context, localData, child) => Container(
              color: AppColor.bgColor,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpaces.verticalSpace20,
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: AppColor.white,
                    child: Center(
                      child: Text('Edit Profile', style: AppTextStyles.header3),
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: _selectedImage.path.isEmpty
                                ? Image.network(
                                    profileDetails['data']['logo'] ?? ' ',
                                    fit: BoxFit.fill,
                                    height: 80,
                                    width: 80,
                                    errorBuilder: (context, error, stackTrace) {
                                      return CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.grey,
                                        child: Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  )
                                : Image.file(
                                    _selectedImage,
                                    height: 80,
                                    width: 80,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColor.secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                                color: AppColor.white,
                              ),
                              onPressed: _pickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Company Name",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                initialValue: profileDetails['data']['name'],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: AppColor.grey),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.secondary),
                                  ),
                                ),
                                onChanged: (value) {
                                  editedProfile['name'] = value;
                                  profileDetails['data']['name'] = value;
                                },
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                initialValue: profileDetails['data']['email'],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: AppColor.grey),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.secondary),
                                  ),
                                ),
                                onChanged: (value) {
                                  // setState(() {
                                  editedProfile['email'] = value;
                                  profileDetails['data']['email'] = value;
                                  // });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Person",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.34,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Salutation",
                                    style: TextStyle(
                                        color: AppColor.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: DropdownButton<String>(
                                      value: profileDetails['data']
                                          ['salutation'],
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            profileDetails['data']
                                                ['salutation'] = newValue;
                                            editedProfile['salutation'] =
                                                newValue;
                                          });
                                        }
                                      },
                                      items: ['Mr', 'Ms', 'Mrs', 'Dr'].map(
                                        (String salutation) {
                                          return DropdownMenuItem<String>(
                                            value: salutation,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Text(salutation)),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        color: AppColor.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: profileDetails['data']
                                        ['contact_person'],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: AppColor.grey),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.secondary),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // setState(() {
                                      profileDetails['data']['contact_person'] =
                                          value;
                                      editedProfile['contact_person'] = value;

                                      // });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.34,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        color: AppColor.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: profileDetails['data']
                                        ['contact_number'],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: AppColor.grey),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.secondary),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // setState(() {
                                      editedProfile['contact_number'] = value;
                                      profileDetails['data']['contact_number'] =
                                          value;
                                      // });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Designation",
                                    style: TextStyle(
                                        color: AppColor.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: profileDetails['data']
                                        ['designation'],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: AppColor.grey),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.secondary),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // setState(() {
                                      editedProfile['designation'] = value;
                                      profileDetails['data']['designation'] =
                                          value;
                                      // });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Organization Info",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Company Name",
                          style: TextStyle(color: AppColor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: profileDetails['data']['name'],
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.secondary),
                            ),
                          ),
                          onChanged: (value) {
                            // setState(() {
                            editedProfile['name'] = value;
                            profileDetails['data']['name'] = value;
                            // });
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Business Type",
                          style: TextStyle(color: AppColor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        FormBuilderDropdown(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.secondary),
                            ),
                          ),
                          name: 'abc',
                          items: (profileDetails['data']['business_types']
                                  as List<dynamic>)
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item['name'].toString(),
                              child: Text(item['name'].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              var selectedItem = (profileDetails['data']
                                      ['business_types'] as List<dynamic>)
                                  .firstWhere((item) =>
                                      item['name'].toString() == value);

                              editedProfile['category_name'] =
                                  selectedItem['name'];
                              editedProfile['category_id'] = selectedItem['id'];

                              profileDetails['data']['category_name'] =
                                  selectedItem['name'];
                              profileDetails['data']['category_id'] =
                                  selectedItem['id'];
                            });
                          },
                          initialValue: editedProfile['category_name'],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Website URl",
                          style: TextStyle(color: AppColor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: profileDetails['data']['website_url'],
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.secondary),
                            ),
                          ),
                          onChanged: (value) {
                            // setState(() {
                            editedProfile['website_url'] = value;
                            profileDetails['data']['website_url'] = value;
                            // });
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Description",
                          style: TextStyle(color: AppColor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: profileDetails['data']['description'],
                          maxLines: 3,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.secondary),
                            ),
                          ),
                          onChanged: (value) {
                            // setState(() {
                            editedProfile['description'] = value;
                            profileDetails['data']['description'] = value;
                            // });
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Address",
                          style: TextStyle(color: AppColor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          maxLines: 3,
                          initialValue: profileDetails['data']['address'],
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.secondary),
                            ),
                          ),
                          onChanged: (value) {
                            // setState(() {
                            editedProfile['address'] = value;
                            profileDetails['data']['address'] = value;
                            // });
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Country",
                          style: TextStyle(color: AppColor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: profileDetails['data']['country'],
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.secondary),
                            ),
                          ),
                          onChanged: (value) {
                            editedProfile['country'] = value.capitalize;
                            if (editedProfile['country'].trim().toLowerCase() !=
                                'india') {
                              pinCode = false;
                              zipCode = true;
                            } else {
                              pinCode = true;
                              zipCode = false;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: pinCode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pincode",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              SearchDropdown(
                                oldPincode: editedProfile['pincode'],
                                onSearchResults:
                                    (Map<String, dynamic> postalAddress) {
                                  editedProfile['pincode'] =
                                      profileDetails['data']['pincode'] =
                                          postalAddress['pincode'].toString();
                                  editedProfile['city'] = profileDetails['data']
                                      ['city'] = postalAddress['districtname'];
                                  editedProfile['state'] =
                                      profileDetails['data']['state'] =
                                          postalAddress['statename'];
                                  country = true;
                                },
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: zipCode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Zipcode",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                  initialValue: profileDetails['data']
                                      ['pincode'],
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: AppColor.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColor.secondary),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    editedProfile['pincode'] =
                                        profileDetails['data']['pincode'] =
                                            value;
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: country,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.all(7),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: AppColor.grey)),
                                child: Text(
                                  profileDetails['data']['city'].toString(),
                                  style: TextStyle(color: AppColor.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: country,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "State",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.all(7),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: AppColor.grey)),
                                child: Text(
                                  profileDetails['data']['state'].toString(),
                                  style: TextStyle(color: AppColor.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        ProfileProvider().editProfile(context, editedProfile);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(AppColor.secondary),
                      ),
                      child: const Text(
                        'Save Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
