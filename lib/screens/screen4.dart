import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  // Méthode pour récupérer les suppléments sélectionnés
  List<String> getSelectedSupplements(Map<String, bool> supplements) {
    return supplements.entries
        .where((entry) => entry.value) // Filtrer les éléments où la valeur est "true"
        .map((entry) => entry.key) // Récupérer les noms des suppléments
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des arguments passés par l'écran précédent
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final pizzas = args['pizzas'] as List<Map<String, dynamic>>;
    final clientInfo = args['clientInfo'];

    // Calcul du prix total en additionnant le prix de chaque pizza
    double totalPrice = pizzas.fold(0, (sum, pizza) => sum + pizza['price']);

    return Scaffold(
      // Barre d'application avec un titre
      appBar: AppBar(title: Text("Résumé de la Commande")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage des informations client
            Text(
              "Informations Client",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Nom : ${clientInfo['name']}"),
            Text("Adresse : ${clientInfo['address']}"),
            Text("Téléphone : ${clientInfo['phone']}"),
            SizedBox(height: 20),

            // Détails des pizzas commandées
            Text(
              "Détail des Pizzas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...pizzas.map((pizza) {
              // Récupération des suppléments sélectionnés
              final selectedSupplements = getSelectedSupplements(pizza['supplements']);
              return ListTile(
                title: Text("Sauce : ${pizza['sauce'] ?? "Non spécifiée"}"),
                subtitle: Text(
                  "Suppléments : ${selectedSupplements.isEmpty ? "Aucun" : selectedSupplements.join(", ")}",
                ),
                trailing: Text("${pizza['price'].toStringAsFixed(2)} DT"),
              );
            }).toList(),
            SizedBox(height: 20),

            // Total à payer
            Text(
              "Total à payer : ${totalPrice.toStringAsFixed(2)} DT",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Retour à l'écran principal
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: Text("Retour à l'accueil"),
        ),
      ),
    );
  }
}
