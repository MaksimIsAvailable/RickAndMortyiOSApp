//
//  APIClubRepository.swift
//  CoreFlow
//
//  Created by Maksim on 5/27/26.
//

import Foundation

final class APIClubRepository: ClubRepositoryProtocol {

    func fetchClubs() async throws -> [Club] {
        let response = try await APIService.shared.fetchClubs()
        return response.map { $0.toClub() }
    }

    func fetchClub(by id: UUID) async throws -> Club? {
        let clubs = try await fetchClubs()
        return clubs.first { $0.id == id }
    }
}
