// class Product {
//     Product({
//          this.id,
//          this.img,
//          this.sientificName,
//          this.tradeName,
//          this.price,
//          this.expiration,
//          this.quantity,
//          this.manufactureName,
//          this.details,
//          this.sectionId,
//          this.createdAt,
//          this.updatedAt,
//     });

//     final int? id;
//     final String? img;
//     final String? sientificName;
//     final String? tradeName;
//     final String? price;
//     final DateTime? expiration;
//     final int? quantity;
//     final String? manufactureName;
//     final String? details;
//     final int? sectionId;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;

//     factory Product.fromJson(Map<String, dynamic> json){ 
//         return Product(
//             id: json["id"],
//             img: json["img"],
//             sientificName: json["sientific_name"],
//             tradeName: json["trade_name"],
//             price: json["price"],
//             expiration: DateTime.tryParse(json["expiration"] ?? ""),
//             quantity: json["quantity"],
//             manufactureName: json["manufacture_name"],
//             details: json["details"],
//             sectionId: json["section_id"],
//             createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//             updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//         );
//     }

// }
