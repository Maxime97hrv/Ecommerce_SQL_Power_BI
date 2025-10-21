# 🇫🇷 Analyse des performances commerciales – SQL & Power BI Dashboard

Ce projet vise à analyser la performance commerciale d’une entreprise à travers un tableau de bord interactif créé sur Power BI.
Les données ont été extraites, nettoyées et transformées à l’aide de SQL, puis visualisées dans Power BI afin de faciliter le suivi des performances par rapport aux objectifs.

## 📥 Télécharger le fichier Power BI

👉 [Clique ici pour télécharger le fichier `.pbix`](./Ecomm_dashboard.pbix)

## 🎯 Objectif

- Extraire et transformer les données brutes à l’aide de requêtes SQL.
- Concevoir un tableau de bord Power BI clair et dynamique pour suivre la performance des ventes. 
- Mettre en évidence les écarts entre les résultats réels et les objectifs fixés.
- Fournir un outil visuel d’aide à la décision pour le management.

## 🧠 Hard Skills

- Rédaction de requêtes SQL : jointures, agrégations, CTE, calculs dynamiques. CF code 👉 [ici](./Ecomm.sql)
- Nettoyage, transformation et modélisation des données.
- Création de mesures et KPI dans Power BI (DAX).
- Utilisation de Power Query pour la gestion des tables.
- Visualisation avancée : waterfall chart, line chart, stacked column + line chart.
- Analyse de la performance (écarts, taux d’atteinte, tendances).

## 🤝 Soft Skills

- Esprit d’analyse et synthèse.
- Organisation et rigueur dans la manipulation de données.
- Sens du design et de la communication visuelle.
- Autonomie dans la gestion de projet.

## 📊 Aperçu du Dashboard

Le tableau de bord présente une vue d’ensemble de la performance mensuelle par catégorie de produit.
Les visualisations permettent de :

- Comparer la performance réelle vs les objectifs (waterfall chart).
- Suivre le taux d’atteinte (%) selon la catégorie (line chart).
- Visualiser la tendance des ventes et des objectifs dans le temps (stacked column + line chart).
- Identifier la contribution de chaque catégorie dans la performance globale.
- Ce dashboard offre une compréhension rapide et visuelle de la performance commerciale et des écarts à corriger.

## 📁 Données

La base de données utilisée pour ce projet provient d’un dataset e-commerce indien disponible sur Kaggle. Elle est composée de trois fichiers CSV principaux :
List of Orders : informations sur les achats, incluant l’ID de commande, la date d’achat et les détails du client.
Order Details : détails des commandes, incluant l’ID de commande, le prix, la quantité, le profit, ainsi que la catégorie et sous-catégorie des produits.
Sales Target : les objectifs de vente par catégorie de produit, avec le montant et la date correspondante.
Cette base permet d’analyser les performances commerciales, d’évaluer les écarts entre résultats réels et objectifs, et de suivre la performance par catégorie de produit.

## 🔍 Résultats

À partir de la base de données e-commerce, quatre tables ont été créées et modélisées afin d’alimenter les quatre pages principales du tableau de bord Power BI.
Chaque page offre une perspective complémentaire sur la performance commerciale.

[Page 1: Global Dashboard](./Screen Power BI/1- Global_Dashboard.PNG) : Cette première page présente les indicateurs clés de performance (KPI) : chiffre d’affaires, bénéfice, marge et taux d’atteinte des objectifs.
Des filtres dynamiques permettent de visualiser les performances par période, catégorie ou sous-catégorie.
L’objectif est de donner une vision synthétique et immédiate de la santé commerciale de l’entreprise.

- *Page 2 : Customer_&_Regianal_analysis* : Cette page détaille la performance des ventes par catégorie et sous-catégorie de produits.
Un waterfall chart met en évidence la différence entre les performances réelles et les objectifs, tandis qu’un line chart illustre le taux d’atteinte (%) de chaque catégorie.
Elle permet d’identifier les produits performants et ceux nécessitant une attention particulière.

- *Page 3 : Product_and_category_insights* : Cette page se concentre sur l’évolution des ventes et des objectifs dans le temps.
Un graphique combiné (stacked column + line chart) affiche la somme des montants vendus par période, avec une ligne représentant la somme des objectifs.
Elle aide à comprendre la saisonnalité des ventes et à repérer les mois de sur- ou sous-performance.

- *Page 4 : Performance_Analysis* : Cette dernière page met en avant la répartition et la contribution des catégories dans la performance globale.
Elle comprend un stacked column chart avec les pourcentages d’atteinte et une vue synthétique par produit.
Cette page facilite la comparaison entre catégories et soutient la prise de décision stratégique.

## 💼 Réalisé par

**Maxime HERVÉ**  
📎 [Mon profil LinkedIn](https://www.linkedin.com/in/maxime-herve-05925a144/)  
📧 Contact : maxime.herve97@gmail.com

---