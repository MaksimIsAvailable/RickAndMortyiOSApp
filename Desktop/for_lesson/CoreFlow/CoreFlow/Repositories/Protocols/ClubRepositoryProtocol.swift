//
//  ClubRepositoryProtocol.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

protocol ClubRepositoryProtocol {
    func fetchClubs() async throws -> [Club]
    func fetchClub(by id: UUID) async throws -> Club?
}
