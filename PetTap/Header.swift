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
            Color.pink
            VStack{
                Spacer()
                Image ("Pet Tap")
                    .scaledToFit()
                    .frame(height: 70)
                    .padding()
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
