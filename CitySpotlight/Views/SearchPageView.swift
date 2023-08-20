//
//  SearchPageView.swift
//  CitySpotlight
//
//  Created by Alex Lee on 8/2/23.
//

import SwiftUI

struct SearchPage: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "None"
    @EnvironmentObject var saved: Saved
    
    var CodeNinjasrating: Double = 4.8
    let businesses = businesses_list
    
    var filteredBusinesses: [Businesses] {
        return businesses.filter { business in
            business.category.contains(selectedFilter)
            
        }
    }
    
    var displayedBusinesses: [Businesses] {
        if searchText.isEmpty && selectedFilter == "None" {
            return businesses
        } else if searchText.isEmpty && selectedFilter != "None" {
            return filteredBusinesses
        } else if !searchText.isEmpty && selectedFilter == "None" {
            return businesses.filter { business in
                business.name.localizedCaseInsensitiveContains(searchText)
            }
        } else {
            return filteredBusinesses.filter { business in
                business.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView { // Wrap the content with a NavigationView
            VStack {
                ZStack (alignment:.leading) {
                    TextField("search", text: $searchText)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .frame(width: 350, height: 20)
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 10)
                }
                .padding(20)
                
                HStack {
                    Text("Filter by:")
                    Picker("Filter by:", selection: $selectedFilter) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .background(Color.clear)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
                    )
                }
                
                List(displayedBusinesses) { store in
                    NavigationLink(destination: BusinessDetailView(business: store, vote: false)){
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(store.name)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Text("\(store.rating.formatted())")
                                    .font(.system(size: 18))
                                
                                ForEach(1..<6) { index in
                                    Image(systemName: Int(store.rating.rounded()) >= index ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .frame(width: 15, height: 5)
                                }
                                
                                Image(systemName: saved.savedBusinesses.contains(store) ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        if saved.savedBusinesses.contains(store) {
                                            saved.savedBusinesses.removeAll { $0 == store }
                                        } else {
                                            saved.savedBusinesses.append(store)                                        }
                                    }
                            }
                            
                            HStack {
                                ForEach(store.category, id: \.self) { cat in
                                    Text(cat + "  \u{2713}")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(Color.green)
                                        // W,T,F for color based on category
                                        .cornerRadius(8)
                                }
                            }
                                                
                            HStack(spacing: 15) {
                                Image("CodeNinjas")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75, height: 75)
                                    .border(Color.black, width: 2)
                                                    
                                Text(store.description)
                                    .font(.system(size: 12))
                            }

                        }
                        .listRowBackground(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }
                }
                .listRowSeparator(.hidden)
                .padding(.bottom, -7)

                Rectangle()
                    .fill(Color.black)
                    .frame(height: 2)
            }
        }
    }
}

struct BusinessDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var saved: Saved
    @EnvironmentObject var hasVoted: Voting
    var business: Businesses
    var vote: Bool
    
    var body: some View {
        
        if vote {
            Button {
                placeVote(store: business)
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Place Your Vote!")
            }
                
        }
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(business.name)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(business.rating.formatted())")
                    .font(.system(size: 18))
                
                ForEach(1..<6) { index in
                    Image(systemName: Int(business.rating.rounded()) >= index ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .frame(width: 15, height: 5)
                    
                }
                
                Image(systemName: saved.savedBusinesses.contains(business) ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        if saved.savedBusinesses.contains(business) {
                            saved.savedBusinesses.removeAll { $0 == business }
                        } else {
                            saved.savedBusinesses.append(business)
                            
                        }
                    }
            }
            
            HStack {
                ForEach(business.category, id: \.self) { cat in
                    Text(cat + "  \u{2713}")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.green)
                        // W,T,F for color based on category
                        .cornerRadius(8)
                }
            }
                                
            HStack(spacing: 15) {
                Image("CodeNinjas")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .border(Color.black, width: 2)
                                    
                Text(business.description)
                    .font(.system(size: 12))
            }

        } .padding(.horizontal, 20)
            .padding(.top, 20)
        
        Divider()
            .frame(height: 1)
            .background(Color.black)
            .padding(.top, 15)
        
        VStack {
            VStack {
                Text("How did we get started?")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(.horizontal, 20)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
            } .frame(width: 350, height: 200)
            
            Divider()
                .frame(height: 1)
                .background(Color.black)
            
            VStack {
                Text("Why \(business.name)?")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.horizontal, 20)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
            } .padding(.top, 10)
                .frame(width: 350, height: 200)
        }
        
        Spacer()
        .padding(.bottom, -3)

        Rectangle()
            .fill(Color.black)
            .frame(height: 2)
    }
    
    func placeVote(store: Businesses) {
        hasVoted.hasVoted.toggle()
        //functionality for voting:
        //  1. Increases individual vote count for particular business
        //  2. Sends user back to home page
        //  3. Toggles on hasVoted for user, which won't allow them to click on the "Want to highlight a business?"
    }
}

struct SearchPagePreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


