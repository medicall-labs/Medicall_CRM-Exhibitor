import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Constants/app_color.dart';

class SearchDropdown extends StatefulWidget {
  final Function(Map<String, dynamic> postalAddress) onSearchResults;
  String oldPincode;
  // Constructor with a callback function to handle search results
  SearchDropdown({required this.onSearchResults, required this.oldPincode});

  @override
  _SearchDropdownState createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _selectedPostalAddress;
  bool _isLoading = false;

  Future<void> _fetchSearchResults(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.data.gov.in/resource/6176ee09-3d56-4a3b-8115-21841576b2f6?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&filters%5Bpincode%5D=$query'));

    if (response.statusCode == 200) {
      final Map<String,dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        print("pincode----> ${data['records'][0]['districtname']}");
        _selectedPostalAddress = data['records'][0];
        print("pincode_details----> ${_selectedPostalAddress}");
        widget.onSearchResults(_selectedPostalAddress!);
      }
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: widget.oldPincode.toString(),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColor.grey),
        ),
        // suffixIcon:
        //     _isLoading ? CircularProgressIndicator() : Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.secondary),
        ),
      ),
      onChanged: (query) {
        setState(() {
          _isLoading = true;
        });
        _fetchSearchResults(query).then((_) {
          setState(() {
            _isLoading = false;
          });
        }).catchError((error) {
          setState(() {
            _isLoading = false;
          });
        });
      },
    );
  }
}
