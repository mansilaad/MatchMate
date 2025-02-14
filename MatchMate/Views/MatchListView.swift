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
                VStack(alignment: .leading, spacing: 20) {
                    Text("Profile Matches")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    ForEach(viewModel.users) { user in
                        if !user.name.first.isEmpty && !user.name.last.isEmpty {
                            VStack(alignment: .center, spacing: 12) {
                                Text("\(user.name.first) \(user.name.last)")
                                    .font(.title)
                                    .foregroundColor(Color("MaxBlueGreen"))
                                
                                if !user.location.city.isEmpty && !user.location.state.isEmpty {
                                    Text("\(user.dob.age), \(user.location.city), \(user.location.state)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                if viewModel.statusDict[user.id] == nil {
                                    Spacer()
                                    HStack(spacing: 20) {
                                        Button(action: {
                                            viewModel.updateUserStatus(id: user.id, status: "Declined")
                                        }) {
                                            Image(systemName: "xmark.circle")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color("MaxBlueGreen"))
                                        }
                                        
                                        Button(action: {
                                            viewModel.updateUserStatus(id: user.id, status: "Accepted")
                                        }) {
                                            Image(systemName: "checkmark.circle")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                                
                                if let status = viewModel.statusDict[user.id] {
                                    Spacer()
                                    Text(status)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color("MaxBlueGreen"))
                                        .cornerRadius(10)
                                        .padding(.top, 10)
                                }
                            }
                            .frame(width: 300, height: 250)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
