/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import '../../common/uuid.dart';
import 'address_model.dart';
import 'availability_hour_model.dart';
import 'e_provider_type_model.dart';
import 'e_service_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'review_model.dart';
import 'tax_model.dart';
import 'user_model.dart';

class EProvider extends Model {
  String id;
  String name;
  String gstNumber;
  String pancardNumber;
  String numberOfEmployees;
  String accHolderName;
  String accNumber;
  String ifscCode;
  String branchName;
  List<String> categories;
  List<String> subCategories;
  String description;
  List<Media> images;
  String phoneNumber;
  String mobileNumber;
  EProviderType type;
  List<AvailabilityHour> availabilityHours;
  double availabilityRange;
  bool available;
  bool featured;
  List<Address> addresses;
  List<Tax> taxes;
  List<String> services;

  List<User> employees;
  double rate;
  List<Review> reviews;
  int totalReviews;
  bool verified;
  int bookingsInProgress;

  EProvider({
    this.id,
    this.name,
    this.description,
    this.images,
    this.phoneNumber,
    this.mobileNumber,
    this.type,
    this.availabilityHours,
    this.availabilityRange,
    this.available,
    this.featured,
    this.addresses,
    this.employees,
    this.rate,
    this.reviews,
    this.totalReviews,
    this.verified,
    this.bookingsInProgress,
    this.gstNumber,
    this.numberOfEmployees,
    this.pancardNumber,
    this.taxes,
    this.categories,
    this.subCategories,
    this.accHolderName,
    this.accNumber,
    this.branchName,
    this.ifscCode,
    this.services,
  });

  EProvider.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    accHolderName = transStringFromJson(json, 'account_holder_name');
    accNumber = transStringFromJson(json, 'account_number');
    ifscCode = transStringFromJson(json, 'ifsc_code');
    branchName = transStringFromJson(json, 'branch_name');
    gstNumber = transStringFromJson(json, 'gst_no');
    pancardNumber = transStringFromJson(json, 'pancard');
    numberOfEmployees = transStringFromJson(json, 'no_of_employee');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    phoneNumber = stringFromJson(json, 'phone_number');
    mobileNumber = stringFromJson(json, 'mobile_number');
    type = objectFromJson(
        json, 'e_provider_type', (v) => EProviderType.fromJson(v));
    availabilityHours = listFromJson(
        json, 'availability_hours', (v) => AvailabilityHour.fromJson(v));
    availabilityRange = doubleFromJson(json, 'availability_range');
    available = boolFromJson(json, 'available');
    featured = boolFromJson(json, 'featured');
    addresses = listFromJson(json, 'addresses', (v) => Address.fromJson(v));
    taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    employees = listFromJson(json, 'users', (v) => User.fromJson(v));
    rate = doubleFromJson(json, 'rate');
    reviews =
        listFromJson(json, 'e_provider_reviews', (v) => Review.fromJson(v));
    totalReviews =
        reviews.isEmpty ? intFromJson(json, 'total_reviews') : reviews.length;
    verified = boolFromJson(json, 'verified');
    bookingsInProgress = intFromJson(json, 'bookings_in_progress');
    if (json['categories'] is List<String>) {
      categories = json['categories'];
    } else if (json['categories'] is String) {
      categories = json['categories'].split(',');
    }
    ;
    if (json['sub_categories_id'] is List<String>) {
      subCategories = json['categories'];
    } else if (json['sub_categories_id'] is String) {
      subCategories = json['sub_categories_id'].split(',');
    }
    ;
    //services = json["service_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (categories != null) data['categories'] = this.categories;
    if (subCategories != null) data['sub_categories_id'] = this.subCategories;
    if (name != null) data['name'] = this.name;
    if (accHolderName != null) data['account_holder_name'] = this.accHolderName;
    if (accNumber != null) data['account_number'] = this.accNumber;
    if (ifscCode != null) data['ifsc_code'] = this.ifscCode;
    if (branchName != null) data['branch_name'] = this.branchName;
    if (description != null) data['description'] = this.description;
    if (numberOfEmployees != null) data['no_of_employee'] = this.description;
    if (available != null) data['available'] = this.available;
    if (phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (mobileNumber != null) data['mobile_number'] = this.mobileNumber;
    if (rate != null) data['rate'] = this.rate;
    if (totalReviews != null) data['total_reviews'] = this.totalReviews;
    if (verified != null) data['verified'] = this.verified;
    if (this.type != null) {
      data['e_provider_type_id'] = this.type.id;
    }
    if (this.images != null) {
      data['image'] = this
          .images
          .where((element) => Uuid.isUuid(element.id))
          .map((v) => v.id)
          .toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v?.id).toList();
    }
    if (this.employees != null) {
      data['employees'] = this.employees.map((v) => v?.id).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes.map((v) => v?.id).toList();
    }
    if (this.availabilityRange != null) {
      data['availability_range'] = availabilityRange;
    }
    if (this.services != null) {
      data['service_id'] = services;
    }

    return data;
  }

  String get firstImageUrl => this.images?.first?.url ?? '';

  String get firstImageThumb => this.images?.first?.thumb ?? '';

  String get firstImageIcon => this.images?.first?.icon ?? '';

  String get firstAddress {
    if (this.addresses.isNotEmpty) {
      return this.addresses.first?.address;
    }
    return '';
  }

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  Map<String, List<AvailabilityHour>> groupedAvailabilityHours() {
    Map<String, List<AvailabilityHour>> result = {};
    this.availabilityHours.forEach((element) {
      if (result.containsKey(element.day)) {
        result[element.day].add(element);
      } else {
        result[element.day] = [element];
      }
    });
    return result;
  }

  List<String> getAvailabilityHoursData(String day) {
    List<String> result = [];
    this.availabilityHours.forEach((element) {
      if (element.day == day) {
        result.add(element.data);
      }
    });
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is EProvider &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          images == other.images &&
          phoneNumber == other.phoneNumber &&
          mobileNumber == other.mobileNumber &&
          type == other.type &&
          availabilityRange == other.availabilityRange &&
          available == other.available &&
          featured == other.featured &&
          addresses == other.addresses &&
          rate == other.rate &&
          reviews == other.reviews &&
          totalReviews == other.totalReviews &&
          verified == other.verified &&
          bookingsInProgress == other.bookingsInProgress;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      type.hashCode ^
      availabilityRange.hashCode ^
      available.hashCode ^
      featured.hashCode ^
      addresses.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode ^
      bookingsInProgress.hashCode;
}

class Strings extends Model {
  String category;

  Strings(
    this.category,
  );

  Strings.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    category = stringFromJson(json, 'categories[]');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['categories[]'] = this.id;

    return data;
  }
}
