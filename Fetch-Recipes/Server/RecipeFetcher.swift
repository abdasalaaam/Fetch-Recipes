//
//  RecipeFetcher.swift
//  Fetch-RecipeApp
//
//  Created by Abud Salem on 10/1/24.
//

import Foundation

class RecipeFetcher : RecipeFetching {
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: url) else {
            throw RecipeFetcherError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            
            if decodedResponse.recipes.isEmpty {
                throw RecipeFetcherError.emptyData
            }
            return decodedResponse.recipes
        } catch _ as DecodingError {
            throw RecipeFetcherError.malformedData
        } catch let error as RecipeFetcherError {
            throw error
        } catch {
            throw RecipeFetcherError.networkError
        }
    }
}

class MockRecipeFetcher: RecipeFetching {
    var result: Result<[Recipe], Error>

    init(result: Result<[Recipe], Error>) {
        self.result = result
    }

    func fetchRecipes() async throws -> [Recipe] {
        switch result {
        case .success(let recipes):
            return recipes
        case .failure(let error):
            throw error
        }
    }
}
