class Links {
  String? rel;

  String? href;

  String? title;

  String? type;

  Links({this.rel, this.href, this.title, this.type});

  Links.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    href = json['href'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (rel != null) {
      data['rel'] = rel;
    }
    if (href != null) {
      data['href'] = href;
    }
    if (title != null) {
      data['title'] = title;
    }

    if (type != null) {
      data['type'] = type;
    }
    return data;
  }
}
