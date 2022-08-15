//
//  Header.swift
//  PetTap
//
//  Created by Arin Haynes on 8/14/22.
//

import SwiftUI

struct Header: View {
    var body: some View {
        
        ZStack{
            Color.theme.accent2
            
            Image ("pinkpawback")
                .resizable()
                .frame(width: 500, height: 400)
                .scaledToFit()
            
            VStack{
                Spacer()
                Image ("Pet Tap")
            }
        }
        .frame(height: 200)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewLayout(.fixed(width: 500, height: 200))
    }
}
