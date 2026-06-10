//
//  APIService.swift
//  CoreFlow
//
//  Created by Maksim on 5/27/26.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    private let baseURL = "https://coreflowapp.ru"
    
    private init() {}
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8
        config.timeoutIntervalForResource = 30
        config.httpShouldUsePipelining = false
        config.httpMaximumConnectionsPerHost = 2
        return URLSession(configuration: config)
    }()
    
    func fetchWorkouts(sportType: String? = nil, city: String? = nil) async throws -> [WorkoutResponse] {
        var urlString = "\(baseURL)/workouts/"
        var params: [String] = []
        params.append("_=\(Int(Date().timeIntervalSince1970))")
        if let sportType { params.append("sport_type=\(sportType)") }
        if let city { params.append("city=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city)") }
        urlString += "?" + params.joined(separator: "&")
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([WorkoutResponse].self, from: data)
    }

    func fetchClubs() async throws -> [ClubResponse] {
        let urlString = "\(baseURL)/clubs/?_=\(Int(Date().timeIntervalSince1970))"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([ClubResponse].self, from: data)
    }
}
