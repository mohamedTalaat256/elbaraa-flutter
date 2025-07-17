// ignore_for_file: unnecessary_null_comparison

class Brand{

  int? id;
  String?  name, image;

Brand({
  required this.id,
  required this.name,
  required this.image,
});

Brand.fromJson(Map<dynamic, dynamic>map){
  if(map == null){
    return;
  }
  id=map['id'];
  name=map['name'];
  image=map['image'];
}

  toJson(){
    return{
      'id': id,
      'name': name,
      'image': image,
    };
  }
}