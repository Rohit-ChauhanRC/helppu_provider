import 'package:get/get.dart';

import '../../common/uuid.dart';
import 'category_model.dart';
import 'e_provider_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class EService extends Model {
  String id;
  String name;
  String product_d;
  String description;
  List<Media> images;
  double price;
  double discountPrice;
  String priceUnit;
  String quantityUnit;
  double rate;
  int totalReviews;
  String duration;
  bool featured;
  bool enableBooking;
  bool isFavorite;
  List<Category> categories;
  List<Category> subCategories;
  EProvider eProvider;
  Category product;

  EService({
    this.id,
    this.name,
    this.product_d,
    this.description,
    this.images,
    this.price,
    this.discountPrice,
    this.priceUnit,
    this.quantityUnit,
    this.rate,
    this.totalReviews,
    this.duration,
    this.featured,
    this.enableBooking,
    this.isFavorite,
    this.categories,
    this.subCategories,
    this.eProvider,
    this.product,
  });

  EService.fromJson(Map<String, dynamic> json) {
    name = transStringFromJson(json, 'name');
    product_d = transStringFromJson(json, 'product_id');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    priceUnit = stringFromJson(json, 'price_unit');
    quantityUnit = transStringFromJson(json, 'quantity_unit');
    rate = doubleFromJson(json, 'rate');
    totalReviews = intFromJson(json, 'total_reviews');
    duration = stringFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    enableBooking = boolFromJson(json, 'enable_booking');
    isFavorite = boolFromJson(json, 'is_favorite');
    categories = listFromJson<Category>(
        json, 'categories', (value) => Category.fromJson(value));
    subCategories = listFromJson<Category>(
        json, 'sub_categories', (value) => Category.fromJson(value));
    eProvider = objectFromJson(
        json, 'e_provider', (value) => EProvider.fromJson(value));
    product =
        objectFromJson(json, 'e_provider', (value) => Category.fromJson(value));
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (product_d != null) data['product_d'] = this.product_d;
    if (this.description != null) data['description'] = this.description;
    if (this.price != null) data['price'] = this.price;
    if (discountPrice != null) data['discount_price'] = this.discountPrice;
    if (priceUnit != null) data['price_unit'] = this.priceUnit;
    if (quantityUnit != null && quantityUnit != 'null')
      data['quantity_unit'] = this.quantityUnit;
    if (rate != null) data['rate'] = this.rate;
    if (totalReviews != null) data['total_reviews'] = this.totalReviews;
    if (duration != null) data['duration'] = this.duration;
    if (featured != null) data['featured'] = this.featured;
    if (enableBooking != null) data['enable_booking'] = this.enableBooking;
    if (isFavorite != null) data['is_favorite'] = this.isFavorite;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v?.id).toList();
    }
    if (this.images != null) {
      data['image'] = this
          .images
          .where((element) => Uuid.isUuid(element.id))
          .map((v) => v.id)
          .toList();
    }
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    if (this.eProvider != null && this.eProvider.hasData) {
      data['e_provider_id'] = this.eProvider.id;
    }
    if (this.product != null && this.product.hasData) {
      data['product_id'] = this.product.id;
    }
    return data;
  }

  String get firstImageUrl => this.images?.first?.url ?? '';

  String get firstImageThumb => this.images?.first?.thumb ?? '';

  String get firstImageIcon => this.images?.first?.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }

  String get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit.isNotEmpty) {
        return "/" + quantityUnit.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is EService &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          rate == other.rate &&
          isFavorite == other.isFavorite &&
          enableBooking == other.enableBooking &&
          categories == other.categories &&
          subCategories == other.subCategories &&
          eProvider == other.eProvider;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      eProvider.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}
