//
//  MealDBService.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import Foundation

class MealDBService: MealDBServiceProtocol {
    
    // MARK: Properties
    private let baseUrl = "https://themealdb.com/api/json/v1/1"
    
    // MARK: Methods
    
    /**
     Hits the MealDB API to get all available meals with a specified category
     - Parameter category: A `MealDBCategory` to filter the available meals for. (I.e. Desserts, Vegan, Seafood, etc)
     - Returns: An array of `Meal` objects
     - Throws: Can throw a `MealDBServiceError` or a `DecodingError` if decoding the response fails
     */
    func getMealsWithCategory(category: MealDBCategory) async throws -> [Meal] {
        do {
            let response = try await request(endpoint: .getMealsWithCategory(category: .Dessert), responseType: GetMealsWithCategory.self)
            return response.meals
        } catch(let error) {
            throw error
        }
    }
    
    /**
     Hits the MealDB API to get details for a meal by its id
     - Parameter id: A `String` representing the meal's id
     - Returns: A `MealDetail` object containing details of a meal
     - Throws: Can throw a `MealDBServiceError` or a `DecodingError` if decoding the response fails
     */
    func getMealDetailsById(id: String) async throws -> MealDetail {
        do {
            let response = try await request(endpoint: .getMealDetailsById(id: id), responseType: GetMealDetailsById.self)
            if response.meals.isEmpty {
                throw MealDBServiceError.emptyData
            } else {
                return response.meals.first!
            }
        } catch(let error) {
            throw error
        }
    }
    
    // MARK: Private Methods
    
    /**
     Generic request method that hits a `MealDBEndpoint` and returns a specified `ResponseType`. `ResponseType` must conform to `Codable`
     - Parameter endpoint: The `MealDBEndpoint` to hit
     - Parameter responseType: A generic `Codable` type to decode from the response
     - Returns: The specified `ResponseType` that was decoded
     - Throws: A `MealDBServiceError`
     */
    private func request<ResponseType: Codable>(endpoint: MealDBEndpoint, responseType: ResponseType.Type) async throws -> ResponseType {
        guard let request = buildRequest(for: endpoint) else { throw MealDBServiceError.buildRequest }
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse {
            do {
                guard let statusCode = HTTPStatusCode(rawValue: response.statusCode) else { throw MealDBServiceError.unknown }
                return try handleResponse(responseType: ResponseType.self, data: data, statusCode: statusCode)
            } catch(let error) {
                throw error
            }
        } else {
            throw MealDBServiceError.unknown
        }
    }
    
    /**
     Helper function to construct a URLRequest
     - Parameter endpoint: A  `MealDBEndpoint` to configure the request for
     - Returns: A `URLRequest` if successful, nil otherwise
     */
    private func buildRequest(for endpoint: MealDBEndpoint) -> URLRequest? {
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

