import 'package:badges/badges.dart';
import 'package:charts/layout/layout.dart';
import 'package:charts/services/models/highlighter/highlighter_model.dart';
import 'package:flutter/material.dart';

class HighlighterPage extends StatefulWidget {
  const HighlighterPage({Key? key}) : super(key: key);

  @override
  State<HighlighterPage> createState() => _HighlighterPageState();
}

class _HighlighterPageState extends State<HighlighterPage> {
  late final Future<AppHighlighterModel>? myFuture;
  
  List<Target> targets = [
    Target(name: "Animal", label: "Animal", description: "Animal"),
    Target(name: "Animal", label: "Animal", description: "Animal"),
    Target(name: "Brand", label: "Marque", description: "Marque de produit"),
    Target(name: "EMail", label: "E-Mail", description: "E-mail"),
    Target(name: "Event", label: "Événement", description: "Événement"),
    Target(name: "Facility", label: "Point d\"intérêt", description: "Point d\"intérêt"),
    Target(name: "FictionalCharacter", label: "Personnage fictif", description: "Personnage fictif"),
    Target(name: "Function", label: "Fonction", description: "Métier"),
    Target(name: "Ingredient", label: "Ingrédient", description: "Ingrédient"),
    Target(name: "Language", label: "Langue", description: "Langue"),
    Target(name: "Location", label: "Lieu", description: "Lieu"),
    Target(name: "LocationDestination", label: "Lieu de destination", description: "Lieu de destination"),
    Target(name: "Location/StreetAddress", label: "Adresse postale", description: "Adresse postale" ),
    Target(name: "LocationFuzzy", label: "Lieu approximatif", description: "Lieu approximatif"),
    Target(name: "LocationSource", label: "Lieu source", description: "Lieu source"),
    Target(name: "LocationSpan", label: "Intervalle géographique", description: "Intervalle géographique"),
    Target(name: "Measure", label: "Mesure", description: "Mesure"),
    Target(name: "Media", label: "Média", description: "Média"),
    Target(name: "Method", label: "Méthode", description: "Méthode"),
    Target(name: "Money", label: "Monnaie", description: "Monnaie"),
    Target(name: "Nation", label: "Nationalité", description: "Nationalité"),
    Target(name: "Organization", label: "Organisation", description: "Organisation"),
    Target(name: "Person", label: "Personne", description: "Nom de personne"),
    Target(name: "PhoneNumber", label: "Numéro de téléphone", description: "Numéro de téléphone"),
    Target(name: "Product", label: "Produit", description: "Nom de produit"),
    Target(name: "ProductRange", label: "Gamme de produits", description: "Gamme de produits"),
    Target(name: "Reference", label: "Référence", description: "Référence"),
    Target(name: "ReferenceDocument", label: "Référence de document", description: "Référence de document"),
    Target(name: "Reward", label: "Récompense", description: "Récompense"),
    Target(name: "Set", label: "Set", description: "Set"),
    Target(name: "Species", label: "Espèce", description: "Espèce animale"),
    Target(name: "Sport", label: "Sport", description: "Sport"),
    Target(name: "SportSteam", label: "Équipe de sport", description: "Équipe de sport"),
    Target(name: "Time", label: "Indication temporelle", description: "Expression temporelle"),
    Target(name: "TimeDuration", label: "Durée", description: "Durée"),
    Target(name: "TimeFuzzy", label: "Indication temporelle approximative", description: "Indication temporelle approximative"),
    Target(name: "TimeMax", label: "Fin de période", description: "Fin de période"),
    Target(name: "TimeMin", label: "Début de période", description: "Début de période"),
    Target(name: "TransportLine", label: "Ligne de transport", description: "Ligne de transport"),
    Target(name: "Url", label: "Lien hypertexte", description: "Lien hypertexte"),
  ];

  @override
  void initState() {
    super.initState();
    myFuture = AppHighlighterModel.loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutState(
      content: Column(
        children: [
          const Text('Highlighter',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Wrap(
              children: targets.map((e) => Padding(
                padding: const EdgeInsets.all(2),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(e.label)
                ),
              )).toList(),
            ),
          )
        ],
      ),
    );
    // return FutureBuilder<AppHighlighterModel>(
    //   future: myFuture,
    //   builder: (BuildContext context, AsyncSnapshot<AppHighlighterModel> snapshot) {
    //     if(snapshot.hasData && snapshot.data != null) {
    //       print(snapshot.data);
    //       List<Widget>? targets = this.targets
    //           .map((e) => OutlinedButton(onPressed: () {}, child: Text('data'))).toList();
    //
    //       return LayoutState(
    //         content: Column(
    //           children: [
    //             const Text('Highlighter',
    //               style: TextStyle(
    //                 fontSize: 25,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             Row(
    //               children: targets!,
    //             )
    //           ],
    //         ),
    //       );
    //     } else {
    //       return const LayoutState(
    //         content: Center(
    //           child: Text('...'),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
