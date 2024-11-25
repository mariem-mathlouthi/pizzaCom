// Définition de la classe représentant une commande.
class Order {
  // Propriété pour l'identifiant unique de la commande (peut être null si non encore attribué par la base de données).
  int? id;
  
  // Propriété pour le nom du client associé à la commande.
  String clientName;
  
  // Propriété pour le numéro de téléphone du client.
  String clientPhone;
  
  // Propriété pour l'adresse du client.
  String clientAddress;
  
  // Propriété pour le prix total de la commande.
  double totalPrice;

  // Constructeur pour initialiser une instance de la classe Order.
  // Les champs `clientName`, `clientPhone`, `clientAddress`, et `totalPrice` sont obligatoires.
  Order({
    this.id, // `id` est optionnel, utilisé pour les cas où la commande existe déjà en base de données.
    required this.clientName, // Nom du client, obligatoire.
    required this.clientPhone, // Téléphone du client, obligatoire.
    required this.clientAddress, // Adresse du client, obligatoire.
    required this.totalPrice, // Prix total de la commande, obligatoire.
  });

  // Méthode pour convertir un objet Order en une Map, compatible avec la base de données.
  Map<String, dynamic> toMap() {
    // Retourne un dictionnaire (Map) contenant les propriétés de la commande.
    return {
      'id': id, // Ajoute l'identifiant de la commande dans la Map (peut être null si non défini).
      'clientName': clientName, // Ajoute le nom du client.
      'clientPhone': clientPhone, // Ajoute le numéro de téléphone du client.
      'clientAddress': clientAddress, // Ajoute l'adresse du client.
      'totalPrice': totalPrice, // Ajoute le prix total de la commande.
    };
  }
}
