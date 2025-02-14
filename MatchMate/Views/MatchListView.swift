//
//  MatchListView.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import SwiftUI

struct MatchListView: View {
    @StateObject var viewModel = MatchViewModel()
    
    
    
    var body: some View {
            ScrollView {
                if viewModel.users.isEmpty {
                    ProgressView("Loading...")
                } else {
                    VStack(spacing: 20) {
                        ForEach(viewModel.users) { user in
                            //Text("✅ Rendering user: \(user.name.first) - ID: \(user.id)")
                            
                            //MatchCardView(user: user, onAccept: {}, onDecline: {})
                        
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
                    .padding()
                }
            }
            .navigationTitle("MatchMate")
    }
}
