//
//  FeedViewModel.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    
    @Published var workouts: [Workout] = []
    @Published var selectedSports: [SportType] = []
    @Published var selectedCity: String? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var clubs: [Club] = []
    
    var sortedSportTypes: [SportType] {
        let unselected = SportType.allCases.filter { !selectedSports.contains($0) }
        return selectedSports + unselected
    }
    
    private let service: WorkoutService
    
    init(service: WorkoutService) {
        self.service = service
        loadSelectedSports()
    }
    
    var availableCities: [String] {
        let cities = clubs.map { $0.city }
        return Array(Set(cities)).sorted()
    }
    
    var filteredWorkouts: [Workout] {
        var result = workouts
        if !selectedSports.isEmpty {
            result = result.filter { selectedSports.contains($0.sportType) }
        }
        if let city = selectedCity {
            result = result.filter { workout in
                clubs.first { $0.id == workout.clubId }?.city == city
            }
        }
        return result
    }
    
    func loadWorkouts() async {
        guard workouts.isEmpty, !isLoading else { return }
        isLoading = true
        
        for attempt in 1...5 {
            do {
                let c = try await service.fetchClubs()
                let w = try await service.fetchWorkouts(for: [])
                self.clubs = c
                self.workouts = w
                self.isLoading = false
                return
            } catch {
                if attempt < 3 {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                } else {
                    self.errorMessage = "Не удалось загрузить тренировки"
                    self.isLoading = false
                    return
                }
            }
        }
    }
    
    func reload() async {
        workouts = []
        clubs = []
        await loadWorkouts()
    }
    
    func toggle(sport: SportType) {
        if let index = selectedSports.firstIndex(of: sport) {
            selectedSports.remove(at: index)
        } else {
            selectedSports.append(sport)
        }
        saveSelectedSports()
    }
    
    func isSelected(_ sport: SportType) -> Bool {
        selectedSports.contains(sport)
    }
    
    func clearSports() {
        selectedSports.removeAll()
        saveSelectedSports()
    }
    
    func selectCity(_ city: String?) {
        selectedCity = city
    }
    
    private func loadSelectedSports() {
        let raw = UserDefaults.standard.stringArray(forKey: "selectedSports") ?? []
        selectedSports = raw.compactMap { SportType(rawValue: $0) }
    }

    private func saveSelectedSports() {
        UserDefaults.standard.set(selectedSports.map { $0.rawValue }, forKey: "selectedSports")
    }
    
    func club(for workout: Workout) -> Club? {
        clubs.first { $0.id == workout.clubId }
    }
}
