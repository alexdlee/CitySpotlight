//
//  HomePageView.swift
//  CitySpotlight
//
//  Created by Alex Lee on 8/2/23.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var saved: Saved
    @EnvironmentObject var hasVoted: Voting
    var businesses = businesses_list
    
    var spotlightBusiness: Businesses {
        var maxCount = 0
        var maxBusiness = businesses[0]
        for business in businesses {
            if business.votecount > maxCount {
                maxCount = business.votecount
                maxBusiness = business
            }
        }
        
        return maxBusiness
    }

    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        Background(length: 350, tall: 370, shift: 35)
                        VStack {
                            HStack {
                                Text("Weekly Business Spotlight")
                                    .font(.system(size: 27))
                                    .fontWeight(.bold)
                            }
                            NavigationLink(destination: BusinessDetailView(business: spotlightBusiness, vote: false)) {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Image("CodeNinjas")
                                            .resizable()
                                            .frame(width: 300, height:200)
                                            .border(Color.black, width: 3)
                                            .padding(.top, 20)
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        Text("CodeNinjas")
                                            .font(.system(size: 23))
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        Text("\(spotlightBusiness.rating.formatted())")
                                            .font(.system(size: 18))
                                        
                                        ForEach(1..<6) { index in
                                            Image(systemName: Int(spotlightBusiness.rating.rounded()) >= index ? "star.fill" : "star")
                                                .foregroundColor(.yellow)
                                                .frame(width: 15, height: 5)
                                        }
                                        
                                        Image(systemName: saved.savedBusinesses.contains(spotlightBusiness) ? "bookmark.fill" : "bookmark")
                                            .foregroundColor(.yellow)
                                            .onTapGesture {
                                                if saved.savedBusinesses.contains(spotlightBusiness) {
                                                    saved.savedBusinesses.removeAll { $0 == spotlightBusiness }
                                                } else {
                                                    saved.savedBusinesses.append(spotlightBusiness)
                                                }
                                            }
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        Text(spotlightBusiness.description)
                                            .font(.system(size: 12))
                                            .frame(width: 327)
                                        
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.blue)
                                            .offset(x: 150, y: 15)
                                    } .padding()
                                }
                            } .foregroundColor(.black)
                        }
                    } .padding(.bottom, 40)
                    
                    ZStack {
                        Background(length: 350, tall: 50, shift: 0)
                        NavigationLink(destination: BusinessesList(voted: hasVoted.hasVoted)) {
                            VStack {
                                HStack {
                                    Text("Want to highlight a business?")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 10)
                                
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue)
                                    
                                }
                            }
                        } .foregroundColor(.black)
                            .padding()
            
                    }
                            
                    ZStack {
                        Background(length: 350, tall: 50, shift: 0)
                        NavigationLink(destination: HelpUsGrow()) {
                            VStack {
                                HStack {
                                    Text("Help Us Grow!")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 30)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue)
                                        .offset(x: -20)
                                }
                            }
                        }   .padding()
                            .foregroundColor(.black)
                    }
                            
                    ZStack {
                        Background(length: 350, tall: 50, shift: 0)
                        NavigationLink(destination: OurVision()) {
                            VStack {
                                HStack {
                                    Text("Our Vision")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 45)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue)
                                        .offset(x: -35)
                                    
                                }
                            }
                        } .foregroundColor(.black)
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 2)
                }
            }
        }
    }
}

struct BusinessesList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "None"
    var CodeNinjasrating: Double = 4.8
    var businesses = businesses_list
    var voted: Bool
    
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
        if voted {
            ZStack {
                Background(length: 350, tall: 250, shift: 0)
                VStack {
                    Text("Thank You For Your Vote!")
                        .font(.system(size:20))
                        .fontWeight(.bold)
                        .padding()
                    Text("You have placed your vote for this week. Come back next week to place your vote for the next business spotlight!")
                        .padding(.horizontal, 20)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    // Display timer for time left until end of week, write function that also sets hasVoted back to false when it hits the end of the week
                }
            }
            
        } else {
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
                    NavigationLink(destination: BusinessDetailView(business:store, vote: true)) {
                        
                        HStack {
                            Image("CodeNinjas")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .border(Color.black, width: 1)
                            Text(store.name)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        .listRowBackground(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }
                    .listRowSeparator(.hidden)
                    .padding(.bottom, -7)
                    
                }
                
                Spacer()
                
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 2)
            }
        }
    }
    
}

struct HelpUsGrow: View {
    // some sort of tab that encourages users to help the app grow, outlining the benefits in a list. another section that lists ways to get involved: requesting to join the developer team, suggesting a small business through this "link", spreading word and encouraging others to download "CitySpotlight"
    var body: some View {
        ScrollView {
            ZStack {
                Background(length: 350, tall: 500, shift: -290)
                Background(length: 350, tall: 580, shift: 270)
                VStack {
                    VStack {
                        Text("Why Should You Help Us Grow?")
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .padding()
                        Text("1. The more users we have on our app, the more we can support local area small businesses!")
                            .padding(.horizontal, 20)
                            .padding()
                        Text("2. The more small businesses we can feature on our app, the more options users have for new destinations. Plus, users can explore and discover a lot more about their community through learning the stories of these businesses!")
                            .padding(.horizontal, 20)
                            .padding()
                        Text("3. Helping us grow will allow us to develop our app much more, which means providing new and better features for users!")
                            .padding(.horizontal, 20)
                            .padding()
                    } .frame(width: 350)
                        .padding()
                
                    
                    VStack {
                        Text("How Can You Help Us Grow?")
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .padding()
                        Text("1. Spread the Word! If you like the app, please suggest the app to friends and family so we can bring bigger and better features!")
                            .padding(.horizontal, 40)
                            .padding()
                        Text("2. Suggest a local area small business to be featured on the app through the link provided below. Every submission will be carefully considered, and if the business agrees, we'll do our best to feature them here!")
                            .padding(.horizontal, 40)
                            .padding()
                        Text("3. Reach out to the developer team through the email provided below. We are still in the beta stages of development and would love to build a bigger team for future development! Any and all submissions are welcome!")
                            .padding(.horizontal, 40)
                            .padding()
                    } .padding(.top, 20)
                }
            }
        }
    }
}

struct OurVision: View {
    var body: some View {
        ZStack {
            Background(length: 350, tall: 520, shift: -75)
            VStack {
                VStack {
                    Text("What is Our Vision?")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding()
                    Text("As an Austin resident I've grown a little tired of constantly searching for new places to eat or visit, only to settle on the same places as usual. When I visited newer, smaller businnesses, I noticed how great they were. Our vision is to highlight these newer, smaller businesses by creating an app that features solely local small businnesses. By featuring these specific businesses, we aim to support our local small businesses and also provide our community with new and amazing options! In addition, as small businesses, every business has its own unique origins and struggles. We aim to provide authentic in-depth summaries about each business so that we can discover and learn more about our own community.")
                        .padding(.horizontal, 20)
                } .frame(width: 350)
                Spacer()
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 2)
            }
        }
        
    }
}

struct Background: View {
    var length: Double
    var tall: Double
    var shift: Double
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
            .cornerRadius(10)
            .opacity(0.4)
            .frame(width: length, height: tall)
            .offset(y: shift)
    }
}

struct HomePageViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
