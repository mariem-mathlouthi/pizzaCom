// Importation de la bibliothèque sqflite pour gérer les interactions avec une base de données SQLite.
import 'package:sqflite/sqflite.dart';
// Importation de la classe DatabaseConnection pour accéder à la connexion à la base de données.
import '../db_helper/database_connection.dart';
// Importation de la classe Order pour manipuler les objets représentant des commandes.
import '../models/order.dart';

// Définition d'une classe repository pour gérer les opérations sur les commandes dans la base de données.
class OrderRepository {
  // Récupération de l'instance de la base de données depuis la connexion.
  // Cela permet d'effectuer des opérations sans réinitialiser la connexion à chaque fois.
  final db = DatabaseConnection.instance.database;

  // Méthode pour insérer une commande dans la table "orders".
  // Retourne un entier représentant l'identifiant de la commande insérée.
  Future<int> insertOrder(Order order) async {
    // Accès à la base de données via la méthode asynchrone `db`.
    final database = await db;
    // Insertion des données de la commande dans la table "orders".
    // `order.toMap()` convertit l'objet Order en un format compatible avec SQLite.
    return await database.insert("orders", order.toMap());
  }
}
