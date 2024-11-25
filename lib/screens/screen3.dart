// Importation de la bibliothèque Flutter pour créer des interfaces utilisateur.
import 'package:flutter/material.dart';

// Définition d'un widget d'état (StatefulWidget) pour permettre des mises à jour dynamiques de l'interface.
class CustomizePizzaScreen extends StatefulWidget {
  @override
  _CustomizePizzaScreenState createState() => _CustomizePizzaScreenState();
}

class _CustomizePizzaScreenState extends State<CustomizePizzaScreen> {
  // Liste pour stocker les détails de chaque pizza (sauce, suppléments, prix).
  List<Map<String, dynamic>> pizzas = [];
  
  // Liste des sauces disponibles.
  final List<String> sauces = ["Sauce Blanche", "Sauce Tomate", "Sauce Piquante"];
  
  // Liste des suppléments disponibles.
  final List<String> supplements = ["Mozzarella", "Thon", "Champignons"];
  
  // Prix des suppléments (associés à leur nom).
  final Map<String, double> supplementPrices = {
    "Mozzarella": 2.5,
    "Thon": 3.0,
    "Champignons": 4.0,
  };

  // Prix de base pour chaque pizza.
  final double basePrice = 9.5;

  // Méthode pour récupérer les suppléments sélectionnés à partir d'une carte (Map).
  List<String> getSelectedSupplements(Map<String, bool> supplements) {
    return supplements.entries
        .where((entry) => entry.value) // Filtrer uniquement les suppléments sélectionnés (valeur true).
        .map((entry) => entry.key) // Obtenir les noms des suppléments sélectionnés.
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des arguments passés depuis l'écran précédent.
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final pizzaCount = args['pizzaCount']; // Nombre de pizzas commandées.

    // Initialisation de la liste des pizzas si elle est vide.
    if (pizzas.isEmpty) {
      pizzas = List.generate(pizzaCount, (index) => {
            "sauce": null, // Aucun choix de sauce par défaut.
            "supplements": Map<String, bool>.fromIterable(
              supplements,
              key: (item) => item as String, // Nom du supplément.
              value: (_) => false, // Non sélectionné par défaut.
            ),
            "price": basePrice, // Prix initial égal au prix de base.
          });
    }

    return Scaffold(
      // Barre d'application avec un titre centré.
      appBar: AppBar(
        title: Text("Choisir Sauce et Suppléments"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      // Corps principal avec une liste des pizzas à personnaliser.
      body: ListView.builder(
        itemCount: pizzaCount, // Nombre total de pizzas.
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espacement autour de chaque carte.
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Bordures arrondies.
            elevation: 3, // Ombre pour donner un effet de profondeur.
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Marges internes de chaque carte.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre pour identifier chaque pizza.
                  Text(
                    "Pizza ${index + 1}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),

                  // Dropdown pour sélectionner une sauce.
                  DropdownButtonFormField<String>(
                    value: pizzas[index]['sauce'], // Valeur sélectionnée.
                    hint: Text("Choisissez une sauce"), // Texte par défaut.
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    items: sauces.map((sauce) {
                      return DropdownMenuItem<String>(
                        value: sauce,
                        child: Text(sauce),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        pizzas[index]['sauce'] = value; // Mise à jour de la sauce choisie.
                      });
                    },
                  ),
                  SizedBox(height: 16),

                  // Checkboxes pour sélectionner les suppléments.
                  Text(
                    "Choisissez les suppléments :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: supplements.map((supplement) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            supplement,
                            style: TextStyle(fontSize: 16),
                          ),
                          Checkbox(
                            value: pizzas[index]['supplements'][supplement], // État actuel du supplément.
                            onChanged: (isSelected) {
                              setState(() {
                                pizzas[index]['supplements'][supplement] = isSelected!; // Mise à jour de l'état.
                                if (isSelected) {
                                  pizzas[index]['price'] += supplementPrices[supplement]!; // Ajouter le prix du supplément.
                                } else {
                                  pizzas[index]['price'] -= supplementPrices[supplement]!; // Retirer le prix du supplément.
                                }
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8),

                  // Affichage des suppléments sélectionnés.
                  Text(
                    "Suppléments sélectionnés : ${getSelectedSupplements(pizzas[index]['supplements']).join(", ")}",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 16),

                  // Affichage du prix total pour la pizza.
                  Text(
                    "Prix de la pizza : ${pizzas[index]['price'].toStringAsFixed(2)} DT",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Bouton de validation pour confirmer les choix et passer à l'écran de résumé.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/summary', arguments: {
              "pizzas": pizzas, // Détails des pizzas.
              "clientInfo": args, // Informations client.
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            "Valider",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
