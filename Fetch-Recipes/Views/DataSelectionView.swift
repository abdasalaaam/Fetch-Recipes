//
//  DataSelectionView.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/6/24.
//

import SwiftUI

struct DataSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    var onSelectURL: (String) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Button("Load Normal Data") {
                    onSelectURL("https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Load Malformed Data") {
                    onSelectURL("https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Load Empty Data") {
                    onSelectURL("https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Select Data Source")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
