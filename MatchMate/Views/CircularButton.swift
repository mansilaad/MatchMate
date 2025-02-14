//
//  CircularButton.swift
//  MatchMate
//
//  Created by Mansi Laad on 14/02/25.
//

import SwiftUI

struct CircularButton: View {
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.gray)
                .padding(20)
                .background(Circle().fill(Color.white))
                .overlay(Circle().stroke(Color("MaxBlueGreen"), lineWidth: 3)) // Border
        }
    }
}
