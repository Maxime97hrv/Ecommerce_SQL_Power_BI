# 🇫🇷 Analyse des performances commerciales – SQL & Power BI Dashboard

Le département commercial d’une entreprise e-commerce indienne manquait d’une vision consolidée et exploitable de sa performance.
Les données brutes, issues de plusieurs fichiers non harmonisés, rendaient impossible le suivi dynamique des ventes, marges et objectifs.
L’enjeu était donc de centraliser, transformer et visualiser ces données pour piloter efficacement la performance et soutenir les décisions stratégiques.

## 📥 Télécharger le fichier Power BI 👉 [Clique ici pour télécharger le fichier `.pbix`](./Ecomm_dashboard.pbix)

## 🎯 Objectif

1. **Mesurer la performance commerciale** à travers les KPIs critiques : chiffre d’affaires, marge brute, taux d’atteinte des objectifs.  
2. **Identifier les tendances saisonnières** et les écarts régionaux pour orienter la stratégie produit.  
3. **Déterminer les Top Produits** à forte marge et les segments sous-performants.  
4. **Fournir une plateforme d’analyse dynamique** (Power BI) permettant une exploration libre et intuitive des données.  

## 🔍 Résultats 👉 [ici](./Screen Power BI)

À partir de la base e-commerce, quatre tables ont été créées et modélisées pour alimenter les quatre pages principales du tableau de bord Power BI, offrant une vision complète de la performance commerciale.

### Page 1: Global Dashboard
> Ce tableau de bord présente une vue d’ensemble des indicateurs de performance clés (KPI), incluant le chiffre d’affaires, le bénéfice, la marge et le taux d’atteinte des objectifs. Elle est conçue avec des filtres dynamiques permettant d'explorer la performance selon la période ou la catégorie souhaitée.
![Page 1 - Global Dashboard](./Screen%20Power%20BI/1-%20Global_Dashboard.PNG)

### Page 2: Customer & Regional Analysis
> Ce tableau de bord propose une analyse détaillée identifiant les régions et les clients où la performance commerciale est majoritairement générée, facilitant l'orientation de la stratégie produit et l'identification des écarts régionaux.
![Page 2 - Customer & Regional Analysis](./Screen%20Power%20BI/2-%20Customer_%26_Regianal_analysis.PNG)

### Page 3: Product and Category Insights
> Ce tableau de bord offre une compréhension rapide et visuelle des performances mensuelles par catégorie de produit, permettant de visualiser les tendances et de formuler des recommandations stratégiques basées sur l'optimisation d'une fraction du catalogue.
- ![Page 3 - Product and Category Insights](./Screen%20Power%20BI/3-%20Product_and_category_insights.PNG)

### Page 4: Performance Analysis
> Ce tableau de bord permet d'avoir une vision claire de la manière dont chaque catégorie impacte le résultat final, offrant ainsi les données nécessaires pour prioriser les actions commerciales. L'atteinte des objectifs (Achievement) est l'un des indicateurs de performance clés (KPI) les plus critiques qui est mesuré et suivi de manière dynamique tout au long du tableau de bord.
![Page 4 - Performance Analysis](./Screen%20Power%20BI/4-%20Performance_Analysis.PNG)


## 📊 Résultats Clés et Impact

### 🎯 Insight Majeur 1 – Concentration du Profit (Analyse de Pareto)
> En se concentrant sur les 5 premières sous-catégories, nous atteignons **65 % du profit total**.
➡ **Recommandations:** En focalisant sur les 5 meilleures sous-catégories, l'entreprise peut obtenir la majorité des bénéfices en optimisant seulement une fraction de son catalogue

### 🔍 Insight Majeur 2 – Performance Régionale
> Les villes Pune et Indore génère à elles seules **35 % du profit total** et **30 % **du revenu total probablement parce qu'elles peuvent abriter une forte proportion de clients premium ou à fort pouvoir d’achat.

### 💎 Insight Majeur 3 – Focus Produit
> Le dashboard met en évidence le **Top 6 des clients générant le profit le plus élevé ** ainsi que le **Top 6 à forte marge mais faible visibilité**.  
➡ **Nous remarquons que ce ne sont pas les mêmes:** se concentrer sur les clients à fort profit et trouver des moyens pour réduire le cout des transports et donc la marge **

### 📈 Insight Majeur 4 – Pilotage des Objectifs
> L’analyse dynamique des **écarts entre objectifs et performances réelles** a permis d’identifier les mois critiques et les catégories en retard.  
➡ **Résultat :** meilleure allocation des ressources et priorisation des actions commerciales.


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

## 💼 Réalisé par

**Maxime HERVÉ**  
📎 [Mon profil LinkedIn](https://www.linkedin.com/in/maxime-herve-05925a144/)  
📧 Contact : maxime.herve97@gmail.com


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# 🇬🇧 Sales Performance Analysis – SQL & Power BI Dashboard

The sales department of an Indian e-commerce company lacked a consolidated and actionable view of its performance.
Raw data, sourced from multiple, non-harmonized files, made it impossible to dynamically track sales, margins, and goals.
The challenge was therefore to centralize, transform, and visualize this data to effectively monitor performance and support strategic decisions.

## 📥 Download the Power BI file 👉 [Click here to download the `.pbix` file](./Ecomm_dashboard.pbix)

## 🎯 Objective

1. **Measure commercial performance** through critical KPIs: revenue, gross margin, goal attainment rate.
2. **Identify seasonal trends** and regional disparities to guide product strategy.
3. **Determine Top Products** with high margins and underperforming segments.
4. **Provide a dynamic analysis platform** (Power BI) allowing free and intuitive data exploration.

## 🔍 Results 👉 [here](./Screen Power BI)

Based on the e-commerce base, four tables were created and modeled to feed the four main pages of the Power BI dashboard, offering a complete view of commercial performance.

### Page 1: Global Dashboard
> This dashboard provides an overview of key performance indicators (KPIs), including revenue, profit, margin, and target achievement rate. It is designed with dynamic filters that allow you to explore performance by period or category.
![Page 1 - Global Dashboard](./Screen%20Power%20BI/1-%20Global_Dashboard.PNG)

### Page 2: Customer & Regional Analysis
> This dashboard provides a detailed analysis identifying the regions and customers where most sales performance is generated, facilitating product strategy orientation and the identification of regional discrepancies.
![Page 2 - Customer & Regional Analysis](./Screen%20Power%20BI/2-%20Customer_%26_Regianal_analysis.PNG): Analysis – Detailed analysis of sales by category and sub-category, with a waterfall chart for gaps and a line chart for the attainment rate.

### Page 3: Product and Category Insights
> This dashboard provides a quick, visual understanding of monthly performance by product category, allowing you to visualize trends and make strategic recommendations based on optimizing a portion of the catalog.
![Page 3 - Product and Category Insights](./Screen%20Power%20BI/3-%20Product_and_category_insights.PNG)

### Page 4: Performance Analysis
> This dashboard provides a clear overview of how each category impacts the final result, providing the data needed to prioritize sales actions. Achievement is one of the most critical key performance indicators (KPIs) that is measured and tracked dynamically throughout the dashboard.
![Page 4 - Performance Analysis](./Screen%20Power%20BI/4-%20Performance_Analysis.PNG)

## 📊 Key Results and Impact

### 🎯 Major Insight 1 – Profit Concentration (Pareto Analysis)
> By focusing on the top 5 sub-categories, we achieve **65% of the total profit**.
➡ **Recommendations:** By focusing on the 5 best sub-categories, the company can achieve the majority of profits by optimizing only a fraction of its catalog.

### 🔍 Major Insight 2 – Regional Performance
> The cities of Pune and Indore alone generate **35% of the total profit** and **30%** of the total revenue, likely because they may house a high proportion of premium or high-spending customers.

### 💎 Major Insight 3 – Product Focus
> The dashboard highlights the **Top 6 customers generating the highest profit** as well as the **Top 6 with high margin but low visibility**.
➡ **We note that they are not the same:** focus on high-profit customers and find ways to reduce transport costs and thus the margin.

### 📈 Major Insight 4 – Goal Monitoring
> Dynamic analysis of **gaps between goals and actual performance** allowed for the identification of critical months and lagging categories.
➡ **Result:** better resource allocation and prioritization of sales actions.

## 🧠 Hard Skills

- Writing SQL queries: joins, aggregations, CTEs, dynamic calculations. CF code 👉 [here](./Ecomm.sql)
- Data cleaning, transformation, and modeling.
- Creating measures and KPIs in Power BI (DAX).
- Using Power Query for table management.
- Advanced visualization: waterfall chart, line chart, stacked column + line chart.
- Performance analysis (gaps, attainment rate, trends).

## 🤝 Soft Skills

- Analytical and synthesis mindset.
- Organization and rigor in data handling.
- Sense of design and visual communication.
- Autonomy in project management.

## 📊 Dashboard Overview

The dashboard presents an overview of monthly performance by product category.
The visualizations allow for:

- Comparing actual performance vs. goals (waterfall chart).
- Tracking the attainment rate (%) by category (line chart).
- Visualizing the trend of sales and goals over time (stacked column + line chart).
- Identifying the contribution of each category to overall performance.
- This dashboard offers a quick and visual understanding of commercial performance and the gaps to be corrected.

## 📁 Data

The database used for this project comes from an Indian e-commerce dataset available on Kaggle. It is composed of three main CSV files:
List of Orders: purchase information, including Order ID, purchase date, and customer details.
Order Details: order details, including Order ID, price, quantity, profit, as well as product category and sub-category.
Sales Target: sales goals by product category, with the corresponding amount and date.
This base allows for analyzing commercial performance, evaluating gaps between actual results and goals, and tracking performance by product category.

## 💼 Created by

**Maxime HERVÉ**
📎 [My LinkedIn profile](https://www.linkedin.com/in/maxime-herve-05925a144/)
📧 Contact: maxime.herve97@gmail.com