//
//  RecipeDetailView.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/6/24.
//

import SwiftUI
import Kingfisher

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                KFImage(recipe.photoURL)
                    .placeholder {
                        ProgressView()
                    }
                    .onFailureImage(UIImage(systemName: "photo"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding()
                
                Text(recipe.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing])
                
                Text(recipe.cuisine)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing])
                
                Spacer()
                
                VStack(spacing: 16) {
                    if let sourceURL = recipe.sourceURL {
                        Button(action: {
                            openURL(sourceURL)
                        }) {
                            Text("View Recipe")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                    if let youtubeURL = recipe.youtubeURL {
                        Button(action: {
                            openURL(youtubeURL)
                        }) {
                            Text("Watch Video")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding([.leading, .trailing, .bottom])
            }
            .padding(.top)
        }
    }
}

