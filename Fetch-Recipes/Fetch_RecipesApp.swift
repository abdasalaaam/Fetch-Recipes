//
//  Fetch_RecipeAppApp.swift
//  Fetch-RecipeApp
//
//  Created by Abud Salem on 10/1/24.
//

import SwiftUI

@main
struct Fetch_RecipeAppApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        }
    }
}
