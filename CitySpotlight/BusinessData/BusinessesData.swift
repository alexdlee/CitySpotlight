//
//  BusinessesData.swift
//  CitySpotlight
//
//  Created by Alex Lee on 8/2/23.
//

import Foundation

let categories = ["None", "Education", "Retail", "Food", "Entertainment"]

struct Businesses: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let rating: Double
    let category: [String]
    let description: String
    var votecount = 0
    
}

class Voting: ObservableObject {
    @Published var hasVoted: Bool = false
}

var businesses_list = [
    Businesses(name: "CodeNinjas", rating: 4.8, category: [categories[1]], description: "CodeNinjas is a business striving to teach young students basic coding concepts. Sign your child up today!"),
                                                            
    Businesses(name: "Best Buy", rating: 4.8, category: [categories[2]], description: "Best Buy is an electronics retailer"),
                                                                     
    Businesses(name: "AMC Movie Theatres", rating: 2.9, category: [categories[4]], description: "AMC Movie Theatres is a movie theatre"),
    
    Businesses(name: "Pizza Hut", rating: 3.9, category: [categories[3]], description: "Pizza Hut is a pizza shop."),
    
    Businesses(name: "Westwood High School", rating: 4.9, category: [categories[1]], description: "Westwood High School is a high school located in Austin, TX.")
    
]

class Saved: ObservableObject {
    @Published var savedBusinesses: [Businesses] = []
}

class Visited: ObservableObject {
    @Published var visitedBusinesses: [Businesses] = []
}




