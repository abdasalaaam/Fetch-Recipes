//
//  RecipesViewModel.swift
//  Fetch-RecipeApp
//
//  Created by Abud Salem on 10/1/24.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String? = nil
    
    private var recipeFetcher: RecipeFetching
    private var currentURL: String
    
    init(url: String, recipeFetcher: RecipeFetching? = nil) {
        self.currentURL = url
        self.recipeFetcher = recipeFetcher ?? RecipeFetcher(url: url)
    }
    
    func fetchRecipes(from url: String? = nil, withFetcher fetcher: RecipeFetching? = nil) async {
        if let newURL = url {
            self.currentURL = newURL
            self.recipeFetcher = fetcher ?? RecipeFetcher(url: newURL)
        }
        
        errorMessage = nil
        
        do {
            let recipes = try await recipeFetcher.fetchRecipes()
            self.recipes = recipes
        } catch let fetchError as RecipeFetcherError {
            self.recipes = []
            switch fetchError {
                case .invalidURL:
                    self.errorMessage = "The URL is invalid."
                case .networkError:
                    self.errorMessage = "Network error."
                case .malformedData:
                    self.errorMessage = "There was an error with loading the data."
                case .emptyData:
                    self.errorMessage = "No recipes available."
            }
        } catch {
            self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
