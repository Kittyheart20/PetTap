//
//  ContentView.swift
//  PetTap
//
//  Created by Arin Haynes on 8/12/22.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var coins = 1000
    @State private var shopView = false
    @State private var notifView = false
    @State private var notifTxt = ""
    
    @State private var cat =  Pets(animal: "cat")
    @State private var dog =  Pets(animal: "dog")
    @State private var bird =  Pets(animal: "bird")
    @State private var curanimal = Pets(animal: "cat")
    
    func checkMinBal (min: Int) -> Bool {
        if(min <= coins) {
            return true
        }
        return false
    }
    
    func shopButt (animal: Pets) {
        if (!animal.owned){
           if (checkMinBal(min: 100)) {
                coins -= 100
               curanimal = animal
               notifTxt = "You now have a \(animal.animal)!"
               SoundManager.instance.sound (soundType: animal.sounds[Int.random(in: 0...3)])
               animal.owned = true
            } else {
                notifTxt = "You do not have enough coins"
            }
        } else {
            SoundManager.instance.sound (soundType: animal.sounds[Int.random(in: 0...3)])
            notifTxt = "You switched to \(animal.animal)!"
            curanimal = animal
        }
        notifView = true
    }
    
    
    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()
            GeometryReader { geo in
                if !shopView {
                    VStack (spacing: 20) {
                        Header()
                            .scaledToFit()
                            .ignoresSafeArea()
                        Button (action: {
                            coins += 1
                        }) {
                            if (curanimal.animal == "cat" && (coins % 5) != 0) {
                                Image("Cat1")
                                    .resizable()
                                    .scaledToFit()
                            } else if (curanimal.animal == "cat" && (coins % 5) == 0) {
                                    Image("Cat2")
                                        .resizable()
                                        .scaledToFit()
                            } else if (curanimal.animal == "dog" && (coins % 5) != 0) {
                                Image("Dog1")
                                    .resizable()
                                    .scaledToFit()
                            } else if (curanimal.animal == "dog" && (coins % 5) == 0) {
                                Image("Dog2")
                                    .resizable()
                                    .scaledToFit()
                            } else if (curanimal.animal == "bird" && (coins % 5) != 0) {
                                Image("Bird1")
                                    .resizable()
                                    .scaledToFit()
                            } else if (curanimal.animal == "bird" && (coins % 5) == 0) {
                                Image("Bird2")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        
                        Spacer()
                        
                        Text ("Coins: \(coins)")
                        
                        Button (action: {
                            shopView = true
                        }) {
                            Text ("Shop")
                                .fontWeight(.bold)
                        }
                        .frame(width: 120, height: 20)
                        .padding(12)
                        .foregroundColor(.black)
                        .background(.pink)
                        .cornerRadius(20)
                        Spacer()
                    }
                } else {
                    ZStack {
                        VStack (spacing: 20) {
                            Color.pink
                        }
                        .frame(width: geo.size.width * 0.9)
                        .cornerRadius(30)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .cornerRadius(30)
                        .shadow(color: .black, radius: 10, x: -5, y: 5)
                        
                        VStack (alignment: .leading, spacing: 20) {
                            Text (" ")
                                .frame(width: geo.size.width * 0.7)
                            
                            Text ("SHOP")
                                .font(.title.weight(.bold))
                                .padding()
                            
                            HStack {
                                Text ("Cat")
                                    .font(.title2.weight(.medium))
                                Spacer()
                                Button (action: {
                                    shopButt (animal: cat)
                                }) {
                                    if (!cat.owned) {
                                        Text ("100")
                                    } else {
                                        Text ("Switch")
                                    }
                                }
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.teal)
                                .cornerRadius(15)
                            }
                            
                            HStack {
                                Text ("Dog")
                                    .font(.title2.weight(.medium))
                                Spacer()
                                Button (action: {
                                    shopButt (animal: dog)
                                }) {
                                    if (!dog.owned) {
                                        Text ("100")
                                    } else {
                                        Text ("Switch")
                                    }
                                }
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.teal)
                                .cornerRadius(15)
                            }
                            
                            HStack {
                                Text ("Bird")
                                    .font(.title2.weight(.medium))
                                Spacer()
                                Button (action: {
                                    shopButt (animal: bird)
                                }) {
                                    if (!bird.owned) {
                                        Text ("100")
                                    } else {
                                        Text ("Switch")
                                    }
                                }
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.teal)
                                .cornerRadius(15)
                            }
                            Spacer()
                            
                            Button (action: {
                                shopView = false
                            }) {
                                Text ("Go Back")
                            }
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.teal)
                            .cornerRadius(15)
                            .padding()
                        }
                        .frame(width: geo.size.width * 0.8)
                    }
                    
                }
                if (notifView == true) {
                    VStack (alignment: .leading, spacing: 20) {
                        Text (notifTxt)
                            .font(.title2.weight(.medium))
                        
                        Button (action: {
                            notifView = false
                        }) {
                            Text ("Okay")
                        }
                        .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(.teal)
                        .cornerRadius(15)
                    }
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.25)
                    .background(.pink)
                    .cornerRadius(30)
                    .position(x: geo.size.width/2, y: geo.size.height/2)
                    .shadow(color: .black, radius: 10, x: -5, y: 5)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
