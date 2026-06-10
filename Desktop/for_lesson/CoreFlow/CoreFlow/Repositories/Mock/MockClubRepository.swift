//
//  MockClubRepository.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

final class MockClubRepository: ClubRepositoryProtocol {

    func fetchClubs() async throws -> [Club] {
        MockData.clubs
    }

    func fetchClub(by id: UUID) async throws -> Club? {
        MockData.clubs.first { $0.id == id }
    }
}
