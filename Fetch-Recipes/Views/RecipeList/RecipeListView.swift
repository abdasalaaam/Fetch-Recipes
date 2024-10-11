//
//  RecipeListView.swift
//  Fetch-RecipeApp
//
//  Created by Abud Salem on 10/1/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel: RecipesViewModel
    @State private var selectedRecipe: Recipe? = nil
    @State private var showDataSelection: Bool = false
    
    init(url: String) {
        _viewModel = StateObject(wrappedValue: RecipesViewModel(url: url))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Retry") {
                            Task {
                                await viewModel.fetchRecipes()
                            }
                        }
                        .padding()
                    }
                } else {
                    List(viewModel.recipes) { recipe in
                        Button(action: {
                            selectedRecipe = recipe
                        }) {
                            RecipeRow(recipe: recipe)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        Task {
                            await viewModel.fetchRecipes()
                        }
                    }
                    .sheet(item: $selectedRecipe) { recipe in
                        RecipeDetailView(recipe: recipe)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LongPressTitleView(title: "Recipes") {
                        showDataSelection = true
                    }
                }
            }
            .sheet(isPresented: $showDataSelection) {
                DataSelectionView { selectedURL in
                    Task {
                        await viewModel.fetchRecipes(from: selectedURL)
                    }
                }
            }
            .onAppear {
                if viewModel.recipes.isEmpty {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
            }
        }
    }
}
