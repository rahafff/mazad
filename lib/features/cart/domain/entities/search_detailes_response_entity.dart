// To parse this JSON data, do
//
//     final searchDetResponseEntity = searchDetResponseEntityFromJson(jsonString);

import 'dart:convert';

SearchDetResponseEntity searchDetResponseEntityFromJson(String str) => SearchDetResponseEntity.fromJson(json.decode(str));

String searchDetResponseEntityToJson(SearchDetResponseEntity data) => json.encode(data.toJson());

class SearchDetResponseEntity {
  SearchDetResponseEntity({
    this.result,

  });


  Result? result;


  factory SearchDetResponseEntity.fromJson(Map<String, dynamic> json) => SearchDetResponseEntity(
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
  };
}

class Result {
  Result({
    // this.addressComponents,
    // this.adrAddress,
    // this.formattedAddress,
    this.geometry,
    // this.icon,
    // this.iconBackgroundColor,
    // this.iconMaskBaseUri,
    // this.name,
    // this.photos,
    // this.placeId,
    // this.reference,
    // this.types,
    // this.url,
    // this.utcOffset,
    // this.vicinity,
    // this.website,
  });

  // List<AddressComponent>? addressComponents;
  // String? adrAddress;
  // String? formattedAddress;
  Geometry? geometry;
  // String? icon;
  // String? iconBackgroundColor;
  // String? iconMaskBaseUri;
  // String? name;
  // List<Photo>? photos;
  // String? placeId;
  // String? reference;
  // List<String>? types;
  // String? url;
  // int? utcOffset;
  // String? vicinity;
  // String? website;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    // addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
    // adrAddress: json["adr_address"],
    // formattedAddress: json["formatted_address"],
    geometry: Geometry.fromJson(json["geometry"]),
    // icon: json["icon"],
    // iconBackgroundColor: json["icon_background_color"],
    // iconMaskBaseUri: json["icon_mask_base_uri"],
    // name: json["name"],
    // photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    // placeId: json["place_id"],
    // reference: json["reference"],
    // types: List<String>.from(json["types"].map((x) => x)),
    // url: json["url"],
    // utcOffset: json["utc_offset"],
    // vicinity: json["vicinity"],
    // website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    // "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
    // "adr_address": adrAddress,
    // "formatted_address": formattedAddress,
    "geometry": geometry?.toJson(),
    // "icon": icon,
    // "icon_background_color": iconBackgroundColor,
    // "icon_mask_base_uri": iconMaskBaseUri,
    // "name": name,
    // "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
    // "place_id": placeId,
    // "reference": reference,
    // "types": List<dynamic>.from(types!.map((x) => x)),
    // "url": url,
    // "utc_offset": utcOffset,
    // "vicinity": vicinity,
    // "website": website,
  };
}

// class AddressComponent {
//   AddressComponent({
//     this.longName,
//     this.shortName,
//     this.types,
//   });
//
//   String? longName;
//   String shortName;
//   List<String> types;
//
//   factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
//     longName: json["long_name"],
//     shortName: json["short_name"],
//     types: List<String>.from(json["types"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "long_name": longName,
//     "short_name": shortName,
//     "types": List<dynamic>.from(types.map((x) => x)),
//   };
// }

class Geometry {
  Geometry({
    this.location,
    // this.viewport,
  });

  Location? location;
  // Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    // viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    // "viewport": viewport.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  String? lat;
  String? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

// class Viewport {
//   Viewport({
//     this.northeast,
//     this.southwest,
//   });
//
//   Location northeast;
//   Location southwest;
//
//   factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
//     northeast: Location.fromJson(json["northeast"]),
//     southwest: Location.fromJson(json["southwest"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "northeast": northeast.toJson(),
//     "southwest": southwest.toJson(),
//   };
// }
//
// class Photo {
//   Photo({
//     this.height,
//     this.htmlAttributions,
//     this.photoReference,
//     this.width,
//   });
//
//   int height;
//   List<String> htmlAttributions;
//   String photoReference;
//   int width;
//
//   factory Photo.fromJson(Map<String, dynamic> json) => Photo(
//     height: json["height"],
//     htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
//     photoReference: json["photo_reference"],
//     width: json["width"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "height": height,
//     "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
//     "photo_reference": photoReference,
//     "width": width,
//   };
// }
