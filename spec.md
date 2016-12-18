https://github.com/salido/platform-challenge

# Challenge for SALIDO Platform Engineer

This challenge is provided to help assess a candidate's development skills. There is no time limit, but we ask that you be prompt in submitting your solution.

## Submission Instructions

1. Complete the challenge according to the Challenge Instructions below.
1. Post your solution in a Github repo. Be sure to include a README.
1. Send a link to your solution to challenge-accepted@salido.com.

## Challenge Instructions

### Objective
Define and explain a set of data models that facilitate menu item pricing determined by a combination of 3 factors: restaurant location, order type, and time of day.

### Business Requirements
* Each restaurant **Brand** using the SALIDO platform has multiple **Locations**.
* Each **Brand** has various **Menu Items** that may be used by any of its **Locations** (e.g. Cafe Bangarang's FiDi and SoHo locations both sell a "Spicy Reuben").
* Each **Brand** has various **Price Levels** (e.g. "Regular" or "Happy Hour") that may be used by any of its **Locations**.
* Each **Menu Item** may have a price assigned for each available **Price Level** (e.g. Regular: $4, Happy Hour: $2).
* Each **Brand** has various **Order Types** (e.g. "Dine In" or "Delivery") that may be used by any of its **Locations**.
* Each **Location** has multiple **Day Parts** (e.g. "Lunch" and "Dinner").
* **Price Levels** are configured per **Location**. This is done by specifying an **Order Type** and optional **Day Part** for which it should be applied.
  * e.g. For the FiDi location:
    * The "Regular" price level is applied if the order type is "Dine In"
    * The "Happy Hour" price level is applied if the order type is "Dine In" and the day part is "Dinner"
    * The "Delivery" price level is applied if the order type is "Delivery"
* The applicable **Price Level** for any given **Menu Item** is determined at the point of sale by assessing the **Price Level** configurations for the current **Location**:
  * If the **Menu Item** has a price specified for the **Price Level** that correlates with the current **Order Type** and **Day Part**, use that **Price Level**.
  * Else, if the **Menu Item** has a price specified for the **Price Level** that correlates with the current **Order Type**, use that **Price Level**.
  * Otherwise, the **Menu Item** has no currently applicable **Price Level** and cannot be purchased.


### To Do
Produce a solution that fulfills the given business requirements. Explain in technical terms how the data should be modelled, what the relationships are, and the specific application logic required to make it all work. Be sure to elaborate on your reasoning.

Your solution may include any or all of the following:
  * Code snippets
  * Diagrams
  * Flow charts
  * UI mockups
  * Prose
  * A fully-functioning program