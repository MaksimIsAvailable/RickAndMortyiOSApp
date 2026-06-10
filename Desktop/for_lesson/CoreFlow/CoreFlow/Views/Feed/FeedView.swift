//
//  FeedView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct FeedView: View {

    @ObservedObject var viewModel: FeedViewModel
    @State private var showFilter = false
    

    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                
                filterChips
                    .padding(.vertical, 10)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    VStack(spacing: 12) {
                        Text("⚠️")
                            .font(.system(size: 48))
                        Text(error)
                            .font(.headline)
                            .foregroundStyle(Color.CF.textPrimary)
                        Button {
                            Task { await viewModel.reload() }
                        } label: {
                            Text("Повторить")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.CF.primary)
                                .clipShape(Capsule())
                        }
                    }
                    Spacer()
                } else if viewModel.filteredWorkouts.isEmpty {
                    emptyState
                } else {
                    workoutList
                }
            }
            .navigationTitle("Заезды")
            .background(Color.CF.background)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.CF.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: Workout.self) { workout in
                WorkoutDetailView(workout: workout, club: viewModel.club(for: workout))
            }
            .navigationDestination(for: Club.self) { club in
                ClubView(club: club, workouts: viewModel.workouts)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilter = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(viewModel.selectedCity == nil ? Color.CF.textSecondary : Color.CF.primary)
                    }
                }
            
            }
            
            .sheet(isPresented: $showFilter) {
                FilterSheetView(
                    selectedCity: Binding(
                        get: { viewModel.selectedCity },
                        set: { viewModel.selectCity($0) }
                    ),
                    availableCities: viewModel.availableCities
                )
                .presentationDetents([.medium])
            }
            .onAppear {
                Task {
                    await viewModel.loadWorkouts()
                }
            }
        }
    }

    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(
                    title: "All",
                    isSelected: viewModel.selectedSports.isEmpty
                ) {
                    viewModel.clearSports()
                }

                ForEach(viewModel.sortedSportTypes) { sport in
                    FilterChip(
                        title: "\(sport.emoji) \(sport.displayName)",
                        isSelected: viewModel.isSelected(sport),
                        accentColor: sport.accentColor
                    ) {
                        viewModel.toggle(sport: sport)
                    }
                }
            }
            .padding(.horizontal, 16)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewModel.sortedSportTypes)
        }
    }

    private var workoutList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.filteredWorkouts) { workout in
                    NavigationLink(value: workout) {
                        WorkoutCardView(workout: workout, club: viewModel.club(for: workout))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
        }
        .background(Color.CF.background)
        .refreshable {
            await viewModel.reload()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("🏁")
                .font(.system(size: 48))
            Text("Нет тренировок")
                .font(.headline)
                .foregroundStyle(Color.CF.textPrimary)
            Text("Попробуй выбрать другой вид спорта или сбрось фильтры")
                .font(.subheadline)
                .foregroundStyle(Color.CF.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button {
                viewModel.clearSports()
                viewModel.selectCity(nil)
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
            Button {
                Task {
                    await viewModel.reload()
                }
            } label: {
                Text("Повторить")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.CF.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.CF.surface)
                    .clipShape(Capsule())
            }
            Spacer()
        }
    }
}
