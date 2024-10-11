//
//  RecipesViewModelTests.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/7/24.
//

import XCTest
@testable import Fetch_Recipes

class RecipesViewModelTests: XCTestCase {
    
    var viewModel: RecipesViewModel!
    let sampleRecipes = [
        Recipe(uuid: "1", cuisine: "Italian", name: "Spaghetti", photoURL: URL(string: "https://example.com/spaghetti.jpg")!, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil),
        Recipe(uuid: "2", cuisine: "Mexican", name: "Tacos", photoURL: URL(string: "https://example.com/tacos.jpg")!, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
    ]

    func testFetchRecipesSuccess() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher(result: .success(sampleRecipes))
        await MainActor.run {
            viewModel = RecipesViewModel(url: "https://example.com", recipeFetcher: mockFetcher)
        }

        // Act
        await viewModel.fetchRecipes()

        // Assert
        await MainActor.run {
            XCTAssertEqual(viewModel.recipes.count, sampleRecipes.count)
            XCTAssertNil(viewModel.errorMessage)
        }
    }

    func testFetchRecipesMalformedData() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher(result: .failure(RecipeFetcherError.malformedData))
        await MainActor.run {
            viewModel = RecipesViewModel(url: "https://example.com", recipeFetcher: mockFetcher)
        }
        
        // Act
        await viewModel.fetchRecipes()
        
        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "There was an error with loading the data.")
        }
    }

    func testFetchRecipesEmptyData() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher(result: .failure(RecipeFetcherError.emptyData))
        await MainActor.run {
            viewModel = RecipesViewModel(url: "https://example.com", recipeFetcher: mockFetcher)
        }
        // Act
        await viewModel.fetchRecipes()
        
        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "No recipes available.")
        }
    }

    func testFetchRecipesNetworkError() async {
        // Arrange
        let networkError = NSError(domain: NSURLErrorDomain, code: -1009, userInfo: nil) // Simulate no internet connection
        let mockFetcher = MockRecipeFetcher(result: .failure(RecipeFetcherError.networkError))
        await MainActor.run {
            viewModel = RecipesViewModel(url: "https://example.com", recipeFetcher: mockFetcher)
        }
        
        // Act
        await viewModel.fetchRecipes()
        
        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "Network error.")
        }
    }
    
    func testFetchRecipesInvalidURL() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher(result: .failure(RecipeFetcherError.invalidURL))
        await MainActor.run {
            viewModel = RecipesViewModel(url: "invalid_url", recipeFetcher: mockFetcher)
        }
        
        // Act
        await viewModel.fetchRecipes()
        
        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "The URL is invalid.")
        }
    }
    
    func testFetchRecipesWithNewURL() async {
        // Arrange
        let initialMockFetcher = MockRecipeFetcher(result: .success([]))
        await MainActor.run {
            viewModel = RecipesViewModel(url: "https://example.com/initial", recipeFetcher: initialMockFetcher)
        }

        let newMockFetcher = MockRecipeFetcher(result: .success(sampleRecipes))

        // Act
        await viewModel.fetchRecipes(from: "https://example.com/new", withFetcher: newMockFetcher)

        // Assert
        await MainActor.run {
            XCTAssertEqual(viewModel.recipes.count, sampleRecipes.count)
            XCTAssertNil(viewModel.errorMessage)
        }
    }
}
