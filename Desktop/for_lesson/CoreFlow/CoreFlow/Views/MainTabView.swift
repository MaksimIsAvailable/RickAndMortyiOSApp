//
//  MainTabView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var feedViewModel = FeedViewModel(service: .shared)

    var body: some View {
        TabView {
            FeedView(viewModel: feedViewModel)
                .tabItem {
                    Label("Лента", systemImage: "list.bullet")
                }

            ClubsView(clubs: feedViewModel.clubs, workouts: feedViewModel.workouts)
                .tabItem {
                    Label("Клубы", systemImage: "person.3")
                }
        }
        .tint(Color.CF.primary)
    }
}
