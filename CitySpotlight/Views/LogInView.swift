//
//  LogInView.swift
//  CitySpotlight
//
//  Created by Alex Lee on 8/1/23.
//

import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            TextField("Email:", text: $email)
                .foregroundColor(.white)
                .padding(20)
            SecureField("Password:", text: $password)
                .padding(20)
            
            Button {
                //action
            } label: {
                Text("Sign Up")
            }
            
    
        }
        
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
