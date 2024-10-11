//
//  RecipeFetcherResponse.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/10/24.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
