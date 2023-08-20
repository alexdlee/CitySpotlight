//
//  ProfileView.swift
//  CitySpotlight
//
//  Created by Alex Lee on 8/2/23.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Your Profile")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Text("Saved Businesses")
                // Image
                
                Spacer()
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 2)
            }
        }
        
    }
}
