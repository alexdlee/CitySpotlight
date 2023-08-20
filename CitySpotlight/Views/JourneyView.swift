//
//  JourneyView.swift
//  CitySpotlight
//
//  Created by Alex Lee on 8/4/23.
//

import SwiftUI
import MapKit

struct JourneyView: View {
    @EnvironmentObject var saved: Saved
    @EnvironmentObject var visited: Visited
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Your Journey!")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    MapView()
                    Text("Your Destinations!")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    List(saved.savedBusinesses) { save in
                        NavigationLink(destination: DestinationView(business: save)) {
                            HStack {
                                Image(systemName: visited.visitedBusinesses.contains(save) ? "checkmark.circle" : "none")
                                Text(save.name)

                            }
                        }
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

struct MapView: View {
    var body: some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.3725793, longitude: -97.7575667), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))))
            .frame(width: 350, height: 300)
            .cornerRadius(8)
            .border(Color.black, width: 2)
    }
}

struct DestinationView: View {
    @EnvironmentObject var saved: Saved
    @EnvironmentObject var visited: Visited
    var business: Businesses
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(business.name)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Text("\(business.rating.formatted())")
                    .font(.system(size: 18))
                
                ForEach(1..<6) { index in
                    Image(systemName: Int(business.rating.rounded()) >= index ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .frame(width: 15, height: 5)
                    
                }
                                
                Spacer()
            } .padding(.top, 20)
            
            HStack(spacing: 15) {
                Image("CodeNinjas")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .border(Color.black, width: 2)
                
                Text(business.description)
                    .font(.system(size: 12))
            }
            .padding(.horizontal, 20)
            
            HStack {
                Spacer()
                
                // make some sort of toggle to make the button disappear if you've already checked off the business
                Button {
                    checkOff(checkedOff: business)
                } label: {
                    Text("Visited!")
                    // make it more clear what this button does
                }
                Spacer()
                
                Button {
                    createEntry()
                } label: {
                    Text("Create Journal Entry")
                }
                Spacer()
            }   .padding(.horizontal, 20)
                .padding(.top, 20)
            
            Spacer()
            Rectangle()
                .fill(Color.black)
                .frame(height: 2)
        }
    }
    
    func checkOff(checkedOff: Businesses) {
        visited.visitedBusinesses.append(checkedOff)
        saved.savedBusinesses.removeAll { $0 == checkedOff }
        saved.savedBusinesses.append(checkedOff)
    }
    
    func createEntry() {
        
    }
}

struct JourneyViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
