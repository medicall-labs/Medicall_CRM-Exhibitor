class ProfileModel {
  String? status;
  Data? data;

  ProfileModel({this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? name;
  String? email;
  String? mobileNumber;
  String? logo;
  int? categoryId;
  String? categoryName;
  List<int>? productId;
  List<String>? productName;
  String? websiteUrl;
  String? description;
  String? salutation;
  String? contactPerson;
  String? designation;
  String? contactNumber;
  String? pincode;
  String? city;
  String? state;
  String? country;
  String? address;
  List<BusinessTypes>? businessTypes;
  List<Event>? events;
  List<Product>? products;

  Data({
    this.username,
    this.name,
    this.email,
    this.mobileNumber,
    this.logo,
    this.categoryId,
    this.categoryName,
    this.productId,
    this.productName,
    this.websiteUrl,
    this.description,
    this.salutation,
    this.contactPerson,
    this.designation,
    this.contactNumber,
    this.pincode,
    this.city,
    this.state,
    this.country,
    this.address,
    this.businessTypes,
    this.events,
    this.products,
  });

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    logo = json['logo'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    productId = json['product_id'].cast<int>();
    productName = json['product_name'].cast<String>();
    websiteUrl = json['website_url'];
    description = json['description'];
    salutation = json['salutation'];
    contactPerson = json['contact_person'];
    designation = json['designation'];
    contactNumber = json['contact_number'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    if (json['business_types'] != null) {
      businessTypes = [];
      json['business_types'].forEach((v) {
        businessTypes!.add(BusinessTypes.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events!.add(Event.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['logo'] = this.logo;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['website_url'] = this.websiteUrl;
    data['description'] = this.description;
    data['salutation'] = this.salutation;
    data['contact_person'] = this.contactPerson;
    data['designation'] = this.designation;
    data['contact_number'] = this.contactNumber;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['address'] = this.address;
    if (this.businessTypes != null) {
      data['business_types'] =
          this.businessTypes!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessTypes {
  int? id;
  String? name;

  BusinessTypes({this.id, this.name});

  BusinessTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Event {
  int? id;
  String? name;
  String? registrationDate;
  String? stallNo;
  List<EventProduct>? eventProducts;
  // List<String>? productId;
  // List<String>? productName;

  Event({
    this.id,
    this.name,
    this.registrationDate,
    this.stallNo,
    this.eventProducts,
    // this.productId,
    // this.productName,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    registrationDate = json['registration_date'];
    stallNo = json['stall_no'];
    // productId = json['product_id']?.cast<String>();
    // productName = json['product_name']?.cast<String>();

    if (json['products'] != null) {
      eventProducts = [];
      json['products'].forEach((v) {
        eventProducts!.add(EventProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['registration_date'] = this.registrationDate;
    data['stall_no'] = this.stallNo;
    // data['product_id'] = this.productId;
    // data['product_name'] = this.productName;
    if (this.eventProducts != null) {
      data['products'] = this.eventProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventProduct {
  String? id;
  String? name;

  EventProduct({this.id, this.name});

  EventProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  List<ImageFile>? images;

  Product({this.id, this.name, this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(ImageFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageFile {
  String? id;
  String? path;

  ImageFile({this.id, this.path});

  ImageFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    return data;
  }
}
