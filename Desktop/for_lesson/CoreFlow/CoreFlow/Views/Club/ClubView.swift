//
//  ClubView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct ClubView: View {
    
    @StateObject private var viewModel: ClubViewModel
    
    init(club: Club, workouts: [Workout] = []) {
        _viewModel = StateObject(wrappedValue: ClubViewModel(club: club, service: .shared, workouts: workouts))
    }
    
    var body: some View {
        GeometryReader { geometry in
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                    .padding(16)

                Divider()

                if let description = viewModel.club.description, !description.isEmpty {
                    Text(description)
                        .font(.body)
                        .foregroundStyle(Color.CF.textPrimary)
                        .lineSpacing(5)
                        .padding(16)

                    Divider()
                }

                workoutsSection

                Spacer(minLength: 24)

                Divider()

                telegramButton
                    .padding(16)
            }
            .frame(minHeight: geometry.size.height - 200)
        }
        }
        .background(Color.CF.background)
        .toolbarBackground(Color.CF.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationDestination(for: Workout.self) { workout in
            WorkoutDetailView(workout: workout, club: viewModel.club)
        }
        .navigationTitle(viewModel.club.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if viewModel.workouts.isEmpty {
                await viewModel.loadWorkouts()
            }
        }    }
    
    private var header: some View {
        HStack(spacing: 14) {
            ClubAvatarView(club: viewModel.club, size: 64)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.club.name)
                    .font(.title3)
                    .fontWeight(.bold)
                HStack(spacing: 6) {
                    ForEach(viewModel.club.sportTypes) { sport in
                        Text(sport.emoji)
                    }
                    Text("· \(viewModel.club.city)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    private var workoutsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ближайшие тренировки")
                .font(.headline)
                .padding(.horizontal, 16)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if viewModel.workouts.isEmpty {
                Text("Нет запланированных тренировок")
                    .font(.subheadline)
                    .foregroundStyle(Color.CF.textSecondary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            } else {
                VStack(spacing: 0) {
                    ForEach(viewModel.workouts) { workout in
                        NavigationLink(value: workout) {
                            ClubWorkoutRow(workout: workout)
                        }
                        .buttonStyle(.plain)
                        
                        if workout.id != viewModel.workouts.last?.id {
                            Divider()
                                .padding(.horizontal, 14)
                        }
                    }
                }
                .background(Color.CF.surface)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                //.shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 16)
    }
    
    private var telegramButton: some View {
        Group {
            if let url = URL(string: viewModel.club.telegramURL) {
                Link(destination: url) {
                    Label("Открыть канал в Telegram", systemImage: "paperplane.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.CF.primary)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
        }
    }
}

private struct ClubWorkoutRow: View {
    
    let workout: Workout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.CF.textPrimary)
                Text("\(workout.date.formatted(.dateTime.day().month().locale(Locale(identifier: "ru_RU")))) · \(workout.meetingTime.formatted(date: .omitted, time: .shortened)) · \(workout.location)")
                    .font(.caption)
                    .foregroundStyle(Color.CF.textSecondary)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color.CF.textTertiary)
        }
        .padding(14)
    }
}
