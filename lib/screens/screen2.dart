// Importation de la bibliothèque Flutter pour créer des interfaces utilisateur.
import 'package:flutter/material.dart';

// Définition d'une classe sans état (StatelessWidget) pour l'écran où l'utilisateur choisit le nombre de pizzas.
class PizzaCountScreen extends StatelessWidget {
  // Contrôleur pour capturer l'entrée utilisateur dans le champ du nombre de pizzas.
  final TextEditingController pizzaCountController = TextEditingController();

  // Méthode obligatoire pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    // Récupération des arguments passés depuis l'écran précédent via le mécanisme de navigation.
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      // Barre d'application affichant le titre de la page.
      appBar: AppBar(title: Text("Commande de Pizza")),
      
      // Contenu principal de la page.
      body: Padding(
        // Ajout de marges internes autour du contenu.
        padding: const EdgeInsets.all(16.0),
        
        // Organisation des widgets sous forme de colonne (verticalement).
        child: Column(
          children: [
            // Texte de bienvenue personnalisé pour afficher le nom de l'utilisateur.
            Text(
              "Bonjour ${args['name']}, combien de pizzas voulez-vous commander ?"
            ),
            
            // Champ de texte pour saisir le nombre de pizzas.
            TextField(
              controller: pizzaCountController, // Lie le champ au contrôleur.
              keyboardType: TextInputType.number, // Définit le clavier numérique pour ce champ.
              decoration: InputDecoration(labelText: "Nombre de pizzas"), // Label au-dessus du champ.
            ),
            
            // Espacement vertical entre le champ de texte et le bouton.
            SizedBox(height: 20),
            
            // Bouton pour valider l'entrée et passer à l'écran suivant.
            ElevatedButton(
              // Action exécutée lorsqu'on appuie sur le bouton.
              onPressed: () {
                // Navigation vers l'écran suivant `/screen3` en passant des arguments supplémentaires.
                Navigator.pushNamed(
                  context, 
                  '/screen3', 
                  arguments: {
                    'name': args['name'], // Nom récupéré depuis l'écran précédent.
                    'phone': args['phone'], // Téléphone récupéré depuis l'écran précédent.
                    'address': args['address'], // Adresse récupérée depuis l'écran précédent.
                    'pizzaCount': int.parse(pizzaCountController.text), // Nombre de pizzas saisi par l'utilisateur.
                  },
                );
              },
              // Texte affiché sur le bouton.
              child: Text("Suivant"),
            ),
          ],
        ),
      ),
    );
  }
}
