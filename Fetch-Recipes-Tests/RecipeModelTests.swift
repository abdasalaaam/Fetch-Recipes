//
//  RecipeModelTests.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/7/24.
//

import XCTest
@testable import Fetch_Recipes

class RecipeModelTests: XCTestCase {
    func testDecodeValidRecipe() {
        let json = """
        {
            "uuid": "12345",
            "cuisine": "Italian",
            "name": "Spaghetti Bolognese",
            "photo_url_large": "https://example.com/photo_large.jpg",
            "photo_url_small": "https://example.com/photo_small.jpg",
            "source_url": "https://example.com/recipe",
            "youtube_url": "https://youtube.com/watch?v=abc123"
        }
        """.data(using: .utf8)!
        
        do {
            let recipe = try JSONDecoder().decode(Recipe.self, from: json)
            XCTAssertEqual(recipe.uuid, "12345")
            XCTAssertEqual(recipe.cuisine, "Italian")
            XCTAssertEqual(recipe.name, "Spaghetti Bolognese")
            XCTAssertEqual(recipe.photoURL.absoluteString, "https://example.com/photo_large.jpg")
            XCTAssertEqual(recipe.photoURLSmall?.absoluteString, "https://example.com/photo_small.jpg")
            XCTAssertEqual(recipe.sourceURL?.absoluteString, "https://example.com/recipe")
            XCTAssertEqual(recipe.youtubeURL?.absoluteString, "https://youtube.com/watch?v=abc123")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testDecodeRecipeWithMissingOptionalFields() {
        let json = """
        {
            "uuid": "67890",
            "cuisine": "Mexican",
            "name": "Tacos",
            "photo_url_large": "https://example.com/photo_large.jpg"
        }
        """.data(using: .utf8)!
        
        do {
            let recipe = try JSONDecoder().decode(Recipe.self, from: json)
            XCTAssertEqual(recipe.uuid, "67890")
            XCTAssertEqual(recipe.cuisine, "Mexican")
            XCTAssertEqual(recipe.name, "Tacos")
            XCTAssertEqual(recipe.photoURL.absoluteString, "https://example.com/photo_large.jpg")
            XCTAssertNil(recipe.photoURLSmall)
            XCTAssertNil(recipe.sourceURL)
            XCTAssertNil(recipe.youtubeURL)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    
    func testDecodeRecipeWithMissingRequiredFields() {
        let json = """
        {
            "uuid": "98765",
            "name": "Pancakes"
        }
        """.data(using: .utf8)!
        
        do {
            _ = try JSONDecoder().decode(Recipe.self, from: json)
            XCTFail("Decoding should have failed due to missing required fields")
        } catch {
            // Expected failure due to missing required fields
            XCTAssertTrue(error is DecodingError)
        }
    }
}

