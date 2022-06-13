class CategoryModel {
  final String icon, title;

  CategoryModel({required this.icon, required this.title});
}

List<CategoryModel> categories = [
  CategoryModel(icon: "assets/icons/Mobile.svg", title: "Mobiles"),
  CategoryModel(icon: "assets/icons/Electronics.svg", title: "Electronics"),
  CategoryModel(icon: "assets/icons/Appliances.svg", title: "Appliances"),
  CategoryModel(icon: "assets/icons/books.svg", title: "Books"),
  CategoryModel(icon: "assets/icons/home.svg", title: "Home"),
  CategoryModel(icon: "assets/icons/dress.svg", title: "Fashion"),
  CategoryModel(icon: "assets/icons/beauty.svg", title: "Beauty"),
  CategoryModel(icon: "assets/icons/furniture.svg", title: "Furniture"),
  CategoryModel(icon: "assets/icons/sports.svg", title: "Sports"),
];
