class Login {
    Login({
        required this.token,
    });

    final String? token;

    factory Login.fromJson(Map<String, dynamic> json){ 
        return Login(
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "token": token,
    };

}
