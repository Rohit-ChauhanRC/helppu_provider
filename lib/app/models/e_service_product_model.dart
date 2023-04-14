import 'media_model.dart';
import 'parents/model.dart';

class EServiceProductModel extends Model {
  String id;
  String name;
  String description;
  String category_id;
  Media image;
  bool featured;
  String sub_categories_id;
  String customer_commission;
  String commission_on_product;
  String commission_agent;
  String gst;

  EServiceProductModel(
      {this.id,
      this.name,
      this.description,
      this.category_id,
      this.image,
      this.featured,
      this.sub_categories_id,
      this.customer_commission,
      this.commission_agent,
      this.commission_on_product,
      this.gst});

  EServiceProductModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    image = mediaFromJson(json, 'image');
    category_id = transStringFromJson(json, 'category_id');
    sub_categories_id = transStringFromJson(json, 'sub_categories_id');
    customer_commission = transStringFromJson(json, 'customer_commission');
    commission_on_product = transStringFromJson(json, 'commission_on_product');
    commission_agent = transStringFromJson(json, 'commission_agent');
    gst = transStringFromJson(json, 'value');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = '${this.category_id}';
    data['sub_categories_id'] = '${this.sub_categories_id}';
    data['customer_commission'] = '${this.customer_commission}';
    data['commission_on_product'] = '${this.commission_on_product}';
    data['commission_agent'] = '${this.commission_agent}';
    data['value'] = '${this.gst}';
    return data;
  }
}
