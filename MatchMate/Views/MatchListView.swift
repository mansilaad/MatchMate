//
//  MatchListView.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import SwiftUI
import SDWebImageSwiftUI


struct MatchListView: View {
    @StateObject var viewModel = MatchViewModel()
    
    var body: some View {        
        ScrollView {
            VStack(alignment: .leading){
                Text("Profile Matches")
                    .font(.headline)
                    .fontWeight(.bold)
                
                if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage, retryAction: viewModel.fetchUsers)
                } else if viewModel.users.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5) // Makes it larger
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else {
                    ForEach(viewModel.users) { user in
                        if !user.name.first.isEmpty && !user.name.last.isEmpty {
                            VStack(alignment: .center, spacing: 12) {
                                
                                if let imageUrl = URL(string: user.picture.medium), !user.picture.medium.isEmpty {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .padding(.top, 20)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .foregroundColor(.gray)
                                        .padding(.top, 20)
                                }
                                
                                Text("\(user.name.first) \(user.name.last)")
                                    .font(.title)
                                    .foregroundColor(Color("MaxBlueGreen"))
                                    .fontWeight(.bold)
                                
                                if !user.location.city.isEmpty && !user.location.state.isEmpty {
                                    Text("\(user.dob.age), \(user.location.city), \(user.location.state)")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal, 10)
                                }
                                
                                if viewModel.statusDict[user.id] == nil {
                                    Spacer()
                                    HStack(spacing: 20) {
                                        CircularButton(systemImage: "multiply") {
                                            viewModel.updateUserStatus(id: user.id, status: "Declined")
                                        }
                                        
                                        CircularButton(systemImage: "checkmark") {
                                            viewModel.updateUserStatus(id: user.id, status: "Accepted")
                                        }
                                        
                                    }
                                    .padding(.bottom, 20)
                                    
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
                            .frame(width: 300, height: 350)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }

                }
            }
            .padding()
        }

    }
}
