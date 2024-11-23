class Section {
    Section({
        required this.data,
    });

    final List<Datum> data;

    factory Section.fromJson(Map<String, dynamic> json){ 
        return Section(
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final dynamic img;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            name: json["name"],
            img: json["img"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
