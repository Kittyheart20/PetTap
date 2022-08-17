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
                .frame(width: 600, height: 400)
                .scaledToFit()
                .opacity(0.7)
            
            VStack{
                Spacer()
                Image ("Pet Tap")
                Rectangle()
                    .fill(Color.theme.butt2)
                    .frame(width: 600, height: 5)
            }
        }
        .frame(height: 200)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
