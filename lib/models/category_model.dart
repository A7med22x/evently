
class CategoryModel {
  String id;
  String name;
  String icon;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageName,
  });
  
  static List<CategoryModel> Categories = [
    CategoryModel(id: '1', name: 'Sport', icon: 'sport', imageName: 'sport'),
    CategoryModel(id: '2', name: 'Birthday', icon: 'birthday', imageName: 'birthday'),
    CategoryModel(id: '3', name: 'Book Club', icon: 'bookclub', imageName: 'bookclub'),
    CategoryModel(id: '4', name: 'Meeting', icon: 'meeting', imageName: 'meeting'),
    CategoryModel(id: '5', name: 'Exhibition', icon: 'exhibition', imageName: 'exhibition'),
  ];
}
