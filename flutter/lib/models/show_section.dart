class ShowSection {
    ShowSection({
        required this.names,
    });

    final List<String> names;

    factory ShowSection.fromJson(Map<String, dynamic> json){ 
        return ShowSection(
            names: json["names"] == null ? [] : List<String>.from(json["names"]!.map((x) => x)),
        );
    }

}
