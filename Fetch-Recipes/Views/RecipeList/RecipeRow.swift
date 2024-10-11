//
//  RecipeRow.swift
//  Fetch-RecipeApp
//
//  Created by Abud Salem on 10/1/24.
//

import SwiftUI
import Kingfisher

struct RecipeRow: View {
    let recipe: Recipe
    @State private var imageURL: URL?
    
    var body: some View {
        HStack {
            KFImage(imageURL)
                .resizable()
                .placeholder {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                }
                .onFailure { error in
                    imageURL = recipe.photoURL
                }
                .resizable()
                .cacheOriginalImage()
                .loadDiskFileSynchronously()
                .cancelOnDisappear(true)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 8)
            Spacer()
        }
        .contentShape(Rectangle())
        .onAppear {
            if let smallURL = recipe.photoURLSmall {
                imageURL = smallURL
            } else {
                imageURL = recipe.photoURL
            }
        }
        
    }
}
