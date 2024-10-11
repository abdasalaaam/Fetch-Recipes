//
//  FetchRecipesTests.swift
//  Fetch-RecipesTests
//
//  Created by Abud Salem on 10/7/24.
//

import XCTest
@testable import Fetch_Recipes 

class RecipeFetcherTests: XCTestCase {

    var recipeFetcher: RecipeFetcher!
    let validURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    let malformedURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    let emptyDataURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"

    func testFetchRecipesWithValidData() async {
        recipeFetcher = RecipeFetcher(url: validURLString)
        do {
            let recipes = try await recipeFetcher.fetchRecipes()
            XCTAssertFalse(recipes.isEmpty, "Expected recipes to be non-empty")
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }

    func testFetchRecipesWithMalformedData() async {
        recipeFetcher = RecipeFetcher(url: malformedURLString)
        do {
            _ = try await recipeFetcher.fetchRecipes()
            XCTFail("Expected failure due to malformed data, but got success")
        } catch let error as RecipeFetcherError {
            if case .malformedData = error {
                // Success: Correct error thrown
            } else {
                XCTFail("Expected .malformedData error, but got \(error)")
            }
        } catch {
            XCTFail("Expected RecipeFetcherError, but got different error: \(error)")
        }
    }

    func testFetchRecipesWithEmptyData() async {
        recipeFetcher = RecipeFetcher(url: emptyDataURLString)
        do {
            _ = try await recipeFetcher.fetchRecipes()
            XCTFail("Expected failure due to empty data, but got success")
        } catch let error as RecipeFetcherError {
            if case .emptyData = error {
                // Success: Correct error thrown
            } else {
                XCTFail("Expected .emptyData error, but got \(error)")
            }
        } catch {
            XCTFail("Expected RecipeFetcherError, but got different error: \(error)")
        }
    }

    func testFetchRecipesWithNetworkError() async {
        // Use a URL that simulates a network error (e.g., unreachable domain)
        let unreachableURLString = "https://example.invalid/recipes.json"
        recipeFetcher = RecipeFetcher(url: unreachableURLString)
        do {
            _ = try await recipeFetcher.fetchRecipes()
            XCTFail("Expected network error, but got success")
        } catch let error as RecipeFetcherError {
            if case .networkError = error {
                // Success: Correct error thrown
            } else {
                XCTFail("Expected .networkError, but got \(error)")
            }
        } catch {
            XCTFail("Expected RecipeFetcherError, but got different error: \(error)")
        }
    }
}
