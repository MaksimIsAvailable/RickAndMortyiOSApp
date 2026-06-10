//
//  ClubsViewModel.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

@MainActor
final class ClubsViewModel: ObservableObject {

    @Published var clubs: [Club] = []
    @Published var isLoading: Bool = false

    private let service: WorkoutService

    init(service: WorkoutService) {
        self.service = service
    }

    func loadClubs() async {
        guard clubs.isEmpty else { return }
        isLoading = true
        do {
            let result = try await service.fetchClubs()
            self.clubs = result
            self.isLoading = false
        } catch {
            self.isLoading = false
        }
    }
}
