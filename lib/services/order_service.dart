import '../models/order.dart'; // Importation du modèle `Order`
import '../repository/order_repository.dart'; // Importation du dépôt `OrderRepository`

// Classe de service pour gérer les opérations liées aux commandes
class OrderService {
  // Création d'une instance du dépôt pour interagir avec la base de données
  final OrderRepository _repository = OrderRepository();

  // Méthode pour enregistrer une commande dans la base de données
  Future<int> saveOrder(Order order) async {
    // Appelle la méthode `insertOrder` du dépôt et retourne l'identifiant généré
    return await _repository.insertOrder(order);
  }
}
