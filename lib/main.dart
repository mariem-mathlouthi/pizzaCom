import 'package:flutter/material.dart';
import 'screens/screen1.dart'; // Importation de l'écran pour les informations client
import 'screens/screen2.dart'; // Importation de l'écran pour le nombre de pizzas
import 'screens/screen3.dart'; // Importation de l'écran pour la personnalisation de la pizza
import 'screens/screen4.dart'; // Importation de l'écran pour afficher le résumé

void main() {
  runApp(MyApp()); // Démarre l'application Flutter avec MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pizza App", // Titre de l'application affiché dans la barre d'application
      initialRoute: '/', // Route initiale au démarrage de l'application
      routes: {
        '/': (context) => ClientInfoScreen(), // Écran d'informations du client
        '/screen2': (context) => PizzaCountScreen(), // Écran pour choisir le nombre de pizzas
        '/screen3': (context) => CustomizePizzaScreen(), // Écran pour personnaliser les pizzas
        '/summary': (context) => SummaryScreen(), // Écran pour afficher le résumé de la commande
      },
    );
  }
}
