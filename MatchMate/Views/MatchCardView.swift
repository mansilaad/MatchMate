//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import SwiftUI
//import SDWebImageSwiftUI

struct MatchCardView: View {
    let user: Result
    let onAccept: () -> Void
    let onDecline: () -> Void
    
    var body: some View {        
        if !user.name.first.isEmpty && !user.name.last.isEmpty {
            VStack(alignment: .center, spacing: 12) {
                Text("\(user.name.first) \(user.name.last), \(user.dob.age)")
                    .font(.headline)
                    .foregroundColor(.primary)

                if !user.location.city.isEmpty && !user.location.state.isEmpty {
                    Text("\(user.location.city), \(user.location.state)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let age = user.registered.age as Int? {
                    Text("\(age), \(user.location.city)").font(.subheadline)
                }

                HStack(spacing: 20) {
                    Button(action: {}) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "heart.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }

    }
}




