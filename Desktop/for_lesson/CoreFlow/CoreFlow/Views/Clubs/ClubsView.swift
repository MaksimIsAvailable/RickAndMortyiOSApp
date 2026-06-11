//
//  ClubsView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct ClubsView: View {
    let clubs: [Club]
    let workouts: [Workout]
    
    @State private var selectedCity: String? = nil
    @State private var selectedSports: [SportType] = []
    @State private var showFilter = false
    @State private var animationID: UUID = .init()
    
    private var availableCities: [String] {
        Array(Set(clubs.map { $0.city })).sorted()
    }
    
    private var sortedSportTypes: [SportType] {
        let selected = SportType.allCases.filter { selectedSports.contains($0) }
        let unselected = SportType.allCases.filter { !selectedSports.contains($0) }
        return selected + unselected
    }
    
    private var filteredClubs: [Club] {
        var result = clubs
        if !selectedSports.isEmpty {
            result = result.filter { club in
                selectedSports.contains { club.sportTypes.contains($0) }
            }
        }
        if let city = selectedCity {
            result = result.filter { $0.city == city }
        }
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterChips
                    .padding(.vertical, 10)

                if clubs.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if filteredClubs.isEmpty {
                    emptyState
                } else {
                    clubList
                }
            }
            .navigationTitle("Клубы")
            .background(Color.CF.background)
            .toolbarBackground(Color.CF.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilter = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(selectedCity == nil ? Color.CF.textSecondary : Color.CF.primary)
                    }
                }
            }
            .sheet(isPresented: $showFilter) {
                FilterSheetView(
                    selectedCity: Binding(
                        get: { selectedCity },
                        set: { selectedCity = $0 }
                    ),
                    availableCities: availableCities
                )
                .presentationDetents([.medium])
            }
            .navigationDestination(for: Club.self) { club in
                ClubView(club: club, workouts: workouts)
            }
        }
    }

    private var clubList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(filteredClubs.enumerated()), id: \.element.id) { index, club in
                    NavigationLink(value: club) {
                        ClubRowView(club: club)
                    }
                    .buttonStyle(.plain)
                    .modifier(CardAppearModifier(index: index, trigger: animationID))
                }
            }
            .padding(16)
        }
        .background(Color.CF.background)
        .onChange(of: selectedCity) { _ in animationID = UUID() }
        .onChange(of: selectedSports) { _ in animationID = UUID() }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("🚴")
                .font(.system(size: 48))
            Text("Нет клубов")
                .font(.headline)
                .foregroundStyle(Color.CF.textPrimary)
            Text("Попробуй выбрать другой вид спорта или сбрось фильтры")
                .font(.subheadline)
                .foregroundStyle(Color.CF.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button {
                selectedSports.removeAll()
                selectedCity = nil
            } label: {
                Text("Сбросить фильтры")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.CF.primary)
                    .clipShape(Capsule())
            }
            Spacer()
        }
    }
    
    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(
                    title: "All",
                    isSelected: selectedSports.isEmpty
                ) {
                    selectedSports.removeAll()
                }
                ForEach(sortedSportTypes) { sport in
                    FilterChip(
                        title: "\(sport.emoji) \(sport.displayName)",
                        isSelected: selectedSports.contains(sport),
                        accentColor: sport.accentColor
                    ) {
                        if let index = selectedSports.firstIndex(of: sport) {
                            selectedSports.remove(at: index)
                        } else {
                            selectedSports.append(sport)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: sortedSportTypes)
        }
    }
}

private struct ClubRowView: View {
    
    let club: Club
    
    var body: some View {
        HStack(spacing: 12) {
            ClubAvatarView(club: club, size: 72)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(club.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.CF.textPrimary)
                HStack(spacing: 4) {
                    ForEach(club.sportTypes) { sport in
                        Text(sport.emoji)
                            .font(.caption)
                    }
                    Text("· \(club.shortCity)")
                        .font(.caption)
                        .foregroundStyle(Color.CF.textSecondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color.CF.textTertiary)
        }
        .padding(14)
        .background(Color.CF.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
