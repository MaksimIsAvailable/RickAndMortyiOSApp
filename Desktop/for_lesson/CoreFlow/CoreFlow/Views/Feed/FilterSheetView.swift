//
//  FilterSheetView.swift
//  CoreFlow
//
//  Created by Maksim on 5/22/26.
//

import SwiftUI

struct FilterSheetView: View {

    @Binding var selectedCity: String?
    let availableCities: [String]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("Город") {
                    Button {
                        selectedCity = nil
                        dismiss()
                    } label: {
                        HStack {
                            Text("Все города")
                                .foregroundStyle(Color.CF.textPrimary)
                            Spacer()
                            if selectedCity == nil {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.CF.primary)
                            }
                        }
                    }

                    ForEach(availableCities, id: \.self) { city in
                        Button {
                            selectedCity = city
                            dismiss()
                        } label: {
                            HStack {
                                Text(city)
                                    .foregroundStyle(Color.CF.textPrimary)
                                Spacer()
                                if selectedCity == city {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(Color.CF.primary)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.CF.background)
            .navigationTitle("Фильтры")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.CF.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                    .foregroundStyle(Color.CF.primary)
                }
            }
        }
    }
}
