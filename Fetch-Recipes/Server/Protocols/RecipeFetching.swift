//
//  RecipeFetching.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/10/24.
//

import Foundation

protocol RecipeFetching {
    func fetchRecipes() async throws -> [Recipe]
}
