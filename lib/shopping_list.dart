class ShoppingList {

 late final int? id;
 final String? productId;
 final String? productNames;
 final String? productData;
 final int? totalNumberOfProducts;

 ShoppingList({
  required this.id,
  required this.productId,
  required this.productNames,
  required this.productData,
  required this.totalNumberOfProducts,
});

 ShoppingList.fromMap(Map<dynamic , dynamic> res)
 : id = res["id"],
   productId = res["productId"],
   productNames = res["productNames"],
   productData = res["productData"],
   totalNumberOfProducts = res["totalNumberOfProducts"];

 Map<String, Object?> toMap(){
  return {
   "id" : id,
   "productId" : productId,
   "productNames" : productNames,
   "productData" : productData,
   "totalNumberOfProducts" : totalNumberOfProducts
  };
 }
}