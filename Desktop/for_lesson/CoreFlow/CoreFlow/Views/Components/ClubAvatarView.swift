//
//  ClubAvatarView.swift
//  CoreFlow
//
//  Created by Maksim on 5/21/26.
//

import SwiftUI
import Kingfisher

struct ClubAvatarView: View {

    let club: Club
    let size: CGFloat

    private var avatarURL: URL? {
        URL(string: "https://t.me/i/userpic/320/\(club.telegramUsername).jpg")
    }

    var body: some View {
        KFImage(avatarURL)
            .placeholder {
                ZStack {
                    RoundedRectangle(cornerRadius: size * 0.25)
                        .fill(Color.CF.primary.opacity(0.15))
                    Text(club.initials)
                        .font(.system(size: size * 0.35, weight: .bold))
                        .foregroundStyle(Color.CF.primary)
                }
            }
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: size * 0.25))
    }
}
