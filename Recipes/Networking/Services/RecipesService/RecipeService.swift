//
//  RecipeService.swift
//
//  Created by DJ A on 11/18/24.
//

import Foundation

struct GetRecipesResponse: Codable {
    let recipes: [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    
    // MARK: Properties
    private let baseUrl = "https://d3jbb8n5wk0qxi.cloudfront.net"
    
    // MARK: Methods
    
    func getRecipes() async throws -> [Recipe] {
        do {
            let response = try await request(endpoint: .recipes, responseType: GetRecipesResponse.self)
            return response.recipes
        } catch(let error) {
            throw error
        }
    }
    
    // MARK: Private Methods
    
    /**
     Generic request method that hits a `Endpoint` and returns a specified `ResponseType`. `ResponseType` must conform to `Codable`
     - Parameter endpoint: The `Endpoint` to hit
     - Parameter responseType: A generic `Codable` type to decode from the response
     - Returns: The specified `ResponseType` that was decoded
     - Throws: A `RecipeServiceError`
     */
    private func request<ResponseType: Codable>(endpoint: Endpoint, responseType: ResponseType.Type) async throws -> ResponseType {
        guard let request = buildRequest(for: endpoint) else { throw RecipeServiceError.buildRequest }
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse {
            do {
                guard let statusCode = HTTPStatusCode(rawValue: response.statusCode) else { throw RecipeServiceError.unknown }
                return try handleResponse(responseType: ResponseType.self, data: data, statusCode: statusCode)
            } catch(let error) {
                throw error
            }
        } else {
            throw RecipeServiceError.unknown
        }
    }
    
    
    
    /**
     Helper function to construct a URLRequest
     - Parameter endpoint: A  `Endpoint` to configure the request for
     - Returns: A `URLRequest` if successful, nil otherwise
     */
    private func buildRequest(for endpoint: Endpoint) -> URLRequest? {
        let urlString = baseUrl + endpoint.rawValue
        guard let components = URLComponents(string: urlString) else { return nil }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        return request
    }
    
    /**
     Helper function to handle a request response
     - Parameter responseType: The response type to be decoded
     - Parameter data: The `Data` to be decoded into a response object
     - Parameter statusCode: The `HTTPStatusCode` used to determine the result of the request
     - Returns: The `ResponseType` that was specified
     - Throws: A `DecodingError` if decoding the object from the response was not successful
     */
    private func handleResponse<ResponseType: Codable>(responseType: ResponseType.Type, data: Data, statusCode: HTTPStatusCode) throws -> ResponseType {
        let decoder = JSONDecoder()
        return try decoder.decode(responseType.self, from: data)
    }
}

