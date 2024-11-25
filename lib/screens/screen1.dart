// Importation de la bibliothèque Flutter pour la création d'interfaces utilisateur.
import 'package:flutter/material.dart';

// Définition d'une classe sans état (StatelessWidget) pour l'écran des informations client.
class ClientInfoScreen extends StatelessWidget {
  // Contrôleurs pour capturer les entrées utilisateur dans les champs de texte.
  final TextEditingController nameController = TextEditingController(); // Pour le nom du client.
  final TextEditingController phoneController = TextEditingController(); // Pour le téléphone du client.
  final TextEditingController addressController = TextEditingController(); // Pour l'adresse du client.

  // Méthode obligatoire pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application en haut de l'écran, avec un titre.
      appBar: AppBar(title: Text("Information Client")),
      
      // Contenu principal de la page.
      body: Padding(
        // Ajout de marges internes autour du contenu.
        padding: const EdgeInsets.all(16.0),
        
        // Organisation des widgets sous forme de colonne (verticalement).
        child: Column(
          children: [
            // Champ de texte pour le nom du client, avec un label "Nom".
            TextField(
              controller: nameController, // Lie le champ au contrôleur `nameController`.
              decoration: InputDecoration(labelText: "Nom"), // Texte descriptif au-dessus du champ.
            ),
            
            // Champ de texte pour le téléphone du client, avec un label "Téléphone".
            TextField(
              controller: phoneController, // Lie le champ au contrôleur `phoneController`.
              decoration: InputDecoration(labelText: "Téléphone"), // Texte descriptif au-dessus du champ.
            ),
            
            // Champ de texte pour l'adresse du client, avec un label "Adresse".
            TextField(
              controller: addressController, // Lie le champ au contrôleur `addressController`.
              decoration: InputDecoration(labelText: "Adresse"), // Texte descriptif au-dessus du champ.
            ),
            
            // Espacement vertical entre les champs de texte et le bouton.
            SizedBox(height: 20),
            
            // Bouton pour soumettre les informations et passer à l'écran suivant.
            ElevatedButton(
              // Action exécutée lorsqu'on appuie sur le bouton.
              onPressed: () {
                // Navigation vers un autre écran nommé `/screen2`.
                // Les données saisies dans les champs sont passées comme arguments.
                Navigator.pushNamed(
                  context, 
                  '/screen2', 
                  arguments: {
                    'name': nameController.text, // Récupère le nom saisi.
                    'phone': phoneController.text, // Récupère le téléphone saisi.
                    'address': addressController.text, // Récupère l'adresse saisie.
                  },
                );
              },
              // Texte affiché sur le bouton.
              child: Text("Commander"),
            ),
          ],
        ),
      ),
    );
  }
}
