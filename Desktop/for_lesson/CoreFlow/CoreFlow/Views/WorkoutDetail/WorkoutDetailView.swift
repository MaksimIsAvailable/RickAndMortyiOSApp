//
//  WorkoutDetailView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI
import Kingfisher

struct WorkoutDetailView: View {
    
    let workout: Workout
    let club: Club?
    @State private var showRouteWebView: Bool = false
    
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: workout.date)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if let posterURL = workout.posterURL,
                   let url = URL(string: posterURL) {

                    ZStack {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 420)
                            .blur(radius: 30)
                            .opacity(0.35)
                        
                        KFImage(url)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 360)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .frame(height: 420)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }

                header
                    .padding(16)

                Divider()

                details
                    .padding(16)

                if let description = workout.description.isEmpty ? nil : workout.description {
                    Divider()
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                        .padding(16)
                }

                Divider()

                actions
                    .padding(16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(workout.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.CF.background)
        .toolbarBackground(Color.CF.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                SportBadgeView(sport: workout.sportType)
                if let pace = workout.paceDescription {
                    Text(pace)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.CF.surfaceSecondary)
                        .foregroundStyle(Color.CF.textSecondary)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }

            Text(workout.title)
                .font(.title2)
                .fontWeight(.bold)

            if let club {
                NavigationLink(value: club) {
                    HStack(spacing: 8) {
                        ClubAvatarView(club: club, size: 24)
                        Text(club.name)
                            .font(.subheadline)
                            .foregroundStyle(Color.CF.textSecondary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption2)
                            .foregroundStyle(Color.CF.textTertiary)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var details: some View {
        VStack(spacing: 0) {
            DetailRow(label: "Дата", value: formattedDate)
            DetailRow(label: "Сбор", value: workout.meetingTime.formatted(date: .omitted, time: .shortened))
            DetailRow(label: "Старт", value: workout.startTime.formatted(date: .omitted, time: .shortened))
            DetailRow(label: "Место", value: workout.location)
            
            if let distance = workout.distanceKm {
                DetailRow(label: "Дистанция", value: "\(Int(distance)) км")
            }
            if let elevation = workout.elevationM {
                DetailRow(label: "Набор высоты", value: "\(elevation) м")
            }
            if let surface = workout.surfaceMix {
                DetailRow(label: "Покрытие", value: surface)
            }
            if let pace = workout.paceDescription {
                DetailRow(label: "Темп", value: pace)
            }
            if let requirements = workout.requirements {
                DetailRow(label: "Требования", value: requirements, isLast: true)
            }
        }
    }
    
    private var actions: some View {
        VStack(spacing: 10) {
            if let routeURL = workout.routeURL, let url = URL(string: routeURL) {
                Button {
                    showRouteWebView = true
                } label: {
                    Label("Открыть маршрут", systemImage: "map")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.CF.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.CF.textTertiary.opacity(0.5), lineWidth: 0.5)
                        )
                        .foregroundStyle(Color.CF.textPrimary)
                }
                .sheet(isPresented: $showRouteWebView) {
                    SafariView(url: url)
                        .ignoresSafeArea()
                }
            }
            
            if let url = URL(string: workout.telegramPostURL) {
                Link(destination: url) {
                    Label("Записаться в Telegram", systemImage: "paperplane.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.CF.primary)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            
            if let club {
                NavigationLink(value: club) {
                    Text("Канал клуба · \(club.name)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

private struct DetailRow: View {
    
    let label: String
    let value: String
    var isLast: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text(label)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: 220, alignment: .trailing)
            }
            .padding(.vertical, 11)
            
            if !isLast {
                Divider()
            }
        }
    }
}
