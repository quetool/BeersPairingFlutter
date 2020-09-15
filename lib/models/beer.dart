class Beer {
  Beer(
      {this.id,
      this.name,
      this.tagline,
      this.firstBrewed,
      this.description,
      this.imageUrl,
      this.abv,
      this.ibu,
      this.targetFg,
      this.targetOg,
      this.ebc,
      this.srm,
      this.ph,
      this.attenuationLevel,
      this.volume,
      this.boilVolume,
      this.method,
      this.ingredients,
      this.foodPairing,
      this.brewersTips,
      this.contributedBy});

  Beer.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    tagline = json['tagline'] as String;
    firstBrewed = json['first_brewed'] as String;
    description = json['description'] as String;
    imageUrl = json['image_url'] as String;
    abv = ((json['abv'] ?? 0.0) * 1.0) as double;
    ibu = ((json['ibu'] ?? 0.0) * 1.0) as double;
    targetFg = ((json['target_fg'] ?? 0.0) * 1.0) as double;
    targetOg = ((json['target_og'] ?? 0.0) * 1.0) as double;
    ebc = ((json['ebc'] ?? 0.0) * 1.0) as double;
    srm = ((json['srm'] ?? 0.0) * 1.0) as double;
    ph = ((json['ph'] ?? 0.0) * 1.0) as double;
    attenuationLevel = ((json['attenuation_level'] ?? 0.0) * 1.0) as double;
    volume = json['volume'] != null
        ? Volume.fromJson(json['volume'] as Map<String, dynamic>)
        : null;
    boilVolume = json['boil_volume'] != null
        ? Volume.fromJson(json['boil_volume'] as Map<String, dynamic>)
        : null;
    method = json['method'] != null
        ? Method.fromJson(json['method'] as Map<String, dynamic>)
        : null;
    ingredients = json['ingredients'] != null
        ? Ingredients.fromJson(json['ingredients'] as Map<String, dynamic>)
        : null;
    foodPairing = json['food_pairing'].cast<String>() as List<String>;
    brewersTips = json['brewers_tips'] as String;
    contributedBy = json['contributed_by'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tagline'] = tagline;
    data['first_brewed'] = firstBrewed;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['abv'] = abv;
    data['ibu'] = ibu;
    data['target_fg'] = targetFg;
    data['target_og'] = targetOg;
    data['ebc'] = ebc;
    data['srm'] = srm;
    data['ph'] = ph;
    data['attenuation_level'] = attenuationLevel;
    if (volume != null) {
      data['volume'] = volume.toJson();
    }
    if (boilVolume != null) {
      data['boil_volume'] = boilVolume.toJson();
    }
    if (method != null) {
      data['method'] = method.toJson();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients.toJson();
    }
    data['food_pairing'] = foodPairing;
    data['brewers_tips'] = brewersTips;
    data['contributed_by'] = contributedBy;
    return data;
  }

  int id;
  String name;
  String tagline;
  String firstBrewed;
  String description;
  String imageUrl;
  double abv;
  double ibu;
  double targetFg;
  double targetOg;
  double ebc;
  double srm;
  double ph;
  double attenuationLevel;
  Volume volume;
  Volume boilVolume;
  Method method;
  Ingredients ingredients;
  List<String> foodPairing;
  String brewersTips;
  String contributedBy;
}

class Volume {
  Volume({this.value, this.unit});

  Volume.fromJson(Map<String, dynamic> json) {
    value = json['value'] as int;
    unit = json['unit'] as String;
  }

  int value;
  String unit;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}

class Method {
  Method({this.mashTemp, this.fermentation, this.twist});

  Method.fromJson(Map<String, dynamic> json) {
    if (json['mash_temp'] != null) {
      mashTemp = <MashTemp>[];
      json['mash_temp'].forEach((dynamic v) {
        mashTemp.add(MashTemp.fromJson(v as Map<String, dynamic>));
      });
    }
    fermentation = json['fermentation'] != null
        ? Fermentation.fromJson(json['fermentation'] as Map<String, dynamic>)
        : null;
    twist = json['twist'] as String;
  }

  List<MashTemp> mashTemp;
  Fermentation fermentation;
  String twist;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (mashTemp != null) {
      data['mash_temp'] = mashTemp.map((v) => v.toJson()).toList();
    }
    if (fermentation != null) {
      data['fermentation'] = fermentation.toJson();
    }
    data['twist'] = twist;
    return data;
  }
}

class MashTemp {
  MashTemp({this.temp, this.duration});

  MashTemp.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null
        ? Volume.fromJson(json['temp'] as Map<String, dynamic>)
        : null;
    duration = json['duration'] as int;
  }

  Volume temp;
  int duration;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (temp != null) {
      data['temp'] = temp.toJson();
    }
    data['duration'] = duration;
    return data;
  }
}

class Fermentation {
  Fermentation({this.temp});

  Fermentation.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null
        ? Volume.fromJson(json['temp'] as Map<String, dynamic>)
        : null;
  }

  Volume temp;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (temp != null) {
      data['temp'] = temp.toJson();
    }
    return data;
  }
}

class Ingredients {
  Ingredients({this.malt, this.hops, this.yeast});

  Ingredients.fromJson(Map<String, dynamic> json) {
    if (json['malt'] != null) {
      malt = <Malt>[];
      json['malt'].forEach((dynamic v) {
        malt.add(Malt.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['hops'] != null) {
      hops = <Hops>[];
      json['hops'].forEach((dynamic v) {
        hops.add(Hops.fromJson(v as Map<String, dynamic>));
      });
    }
    yeast = json['yeast'] as String;
  }

  List<Malt> malt;
  List<Hops> hops;
  String yeast;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (malt != null) {
      data['malt'] = malt.map((v) => v.toJson()).toList();
    }
    if (hops != null) {
      data['hops'] = hops.map((v) => v.toJson()).toList();
    }
    data['yeast'] = yeast;
    return data;
  }
}

class Malt {
  Malt({this.name, this.amount});

  Malt.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    amount = json['amount'] != null
        ? Amount.fromJson(json['amount'] as Map<String, dynamic>)
        : null;
  }

  String name;
  Amount amount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    if (amount != null) {
      data['amount'] = amount.toJson();
    }
    return data;
  }
}

class Amount {
  Amount({this.value, this.unit});

  Amount.fromJson(Map<String, dynamic> json) {
    value = (json['value'] * 1.0) as double;
    unit = json['unit'] as String;
  }

  double value;
  String unit;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}

class Hops {
  Hops({this.name, this.amount, this.add, this.attribute});

  Hops.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    amount = json['amount'] != null
        ? Amount.fromJson(json['amount'] as Map<String, dynamic>)
        : null;
    add = json['add'] as String;
    attribute = json['attribute'] as String;
  }

  String name;
  Amount amount;
  String add;
  String attribute;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    if (amount != null) {
      data['amount'] = amount.toJson();
    }
    data['add'] = add;
    data['attribute'] = attribute;
    return data;
  }
}
