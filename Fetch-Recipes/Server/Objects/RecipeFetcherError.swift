//
//  RecipeFetcherError.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/10/24.
//

import Foundation

enum RecipeFetcherError: Error {
    case invalidURL
    case networkError
    case malformedData
    case emptyData
}
