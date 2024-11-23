class User {
    User({
        required this.token,
    });

    final String? token;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "token": token,
    };

}
