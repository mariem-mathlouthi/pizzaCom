// Importation de la bibliothèque sqflite pour gérer les bases de données SQLite dans Flutter.
import 'package:sqflite/sqflite.dart';
// Importation de la bibliothèque path pour gérer les chemins de fichiers de manière compatible entre les plateformes.
import 'package:path/path.dart';

// Définition d'une classe pour gérer la connexion à la base de données.
class DatabaseConnection {
  // Création d'une instance unique (singleton) de la classe DatabaseConnection.
  static final DatabaseConnection instance = DatabaseConnection._init();
  
  // Déclaration d'une variable pour stocker l'instance de la base de données.
  static Database? _database;

  // Constructeur privé pour empêcher l'instanciation directe de la classe.
  DatabaseConnection._init();

  // Méthode pour accéder à la base de données. Si elle n'est pas encore initialisée, elle est créée.
  Future<Database> get database async {
    // Si la base de données est déjà initialisée, la retourner.
    if (_database != null) return _database!;
    // Sinon, initialiser la base de données.
    _database = await _initDB('pizza_app.db');
    return _database!;
  }

  // Méthode privée pour initialiser la base de données en spécifiant son chemin et ses paramètres.
  Future<Database> _initDB(String filePath) async {
    // Récupérer le chemin par défaut pour les bases de données sur l'appareil.
    final dbPath = await getDatabasesPath();
    // Combiner le chemin par défaut avec le nom du fichier pour obtenir le chemin complet.
    final path = join(dbPath, filePath);

    // Ouvrir ou créer la base de données au chemin spécifié.
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Méthode appelée lors de la création initiale de la base de données pour définir les tables.
  Future _createDB(Database db, int version) async {
    // Création de la table "orders" pour stocker les commandes des clients.
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Identifiant unique pour chaque commande.
        clientName TEXT,                     // Nom du client.
        clientPhone TEXT,                    // Numéro de téléphone du client.
        clientAddress TEXT,                  // Adresse du client.
        totalPrice REAL                      // Prix total de la commande.
      )
    ''');
    
    // Création de la table "pizzas" pour stocker les informations sur les pizzas dans chaque commande.
    await db.execute('''
      CREATE TABLE pizzas (
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Identifiant unique pour chaque pizza.
        orderId INTEGER,                     // Référence à l'identifiant de la commande (clé étrangère).
        sauce TEXT,                          // Type de sauce utilisé pour la pizza.
        supplements TEXT,                    // Liste des suppléments ajoutés à la pizza.
        price REAL,                          // Prix de la pizza.
        FOREIGN KEY (orderId) REFERENCES orders (id) // Définition de la clé étrangère reliant la pizza à une commande.
      )
    ''');
  }
}
