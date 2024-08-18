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
    func getMealsWithCategory(category: MealDBCategory) async throws -> [Meal] {
        do {
            let response = try await request(endpoint: .getMealsWithCategory(category: .Dessert), responseType: GetMealsWithCategory.self)
            return response.meals
        } catch(let error) {
            throw error
        }
    }
    
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
    
    private func buildRequest(for endpoint: MealDBEndpoint) -> URLRequest? {
        let urlString = baseUrl + endpoint.rawValue
        guard let components = URLComponents(string: urlString) else { return nil }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        return request
    }
    
    private func handleResponse<ResponseType: Codable>(responseType: ResponseType.Type, data: Data, statusCode: HTTPStatusCode) throws -> ResponseType {
        let decoder = JSONDecoder()
        return try decoder.decode(responseType.self, from: data)
    }
}

