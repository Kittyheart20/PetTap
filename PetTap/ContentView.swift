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
    @State private var sPetView = true
    @State private var sAccentView = false
    @State private var sBackgroundView = false
    
    @State private var notifView = false
    @State private var notifTxt = ""
    
    @State private var cat =  Pets(animal: "cat")
    @State private var dog =  Pets(animal: "dog")
    @State private var bird =  Pets(animal: "bird")
    @State private var bunny =  Pets(animal: "bunny")
    @State private var curanimal = Pets(animal: "cat")
    
    @State private var dayBack =  Back(back: "Day")
    @State private var nightBack =  Back(back: "Night")
    @State private var indoor1 =  Back(back: "Room1")
    @State private var indoor2 =  Back(back: "Room2")
    @State private var curBack = ""
    
    
    /* Cannot be in seperate folder while on device
    class SoundManager {
        static let instance = SoundManager()
        var player: AVAudioPlayer?
        
        func sound (soundType: String) {
            guard let url = Bundle.main.url(forResource: soundType, withExtension: ".mp3") else {return}
            
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
                } catch let error {
                    print ("Error playing sound. \(error.localizedDescription)")
                }
        }
    }
    */
    
    func checkMinBal (min: Int) -> Bool {
        if(min <= coins) {
            return true
        }
        return false
    }
    
    func shopButtAni (animal: Pets) {
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
    
    
    func shopButtBack (back: Back) {
        if (!back.owned){
           if (checkMinBal(min: 100)) {
                coins -= 100
               curBack = back.back
               notifTxt = "You now have the \(back.back) background!"
               back.owned = true
            } else {
                notifTxt = "You do not have enough coins"
            }
        } else {
            notifTxt = "You switched to the \(back.back) background!"
            curBack = back.back
        }
        notifView = true
    }
    
    var body: some View {
        ZStack {
            Color.theme.accent1
                .ignoresSafeArea()
            
            GeometryReader { geo in
                Image("bluetexture")
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .position(x: geo.size.width/2, y: geo.size.height * 0.6)
                    .opacity(0.5)
                
                Image (curBack)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .position(x: geo.size.width/2, y: geo.size.height * 0.6)
                    
                    
                
                if !shopView {
                    Header()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .position(x: geo.size.width/2, y: geo.size.height * -0.13)
                    
                    VStack (spacing: 10) {
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        Button (action: {
                            coins += 1
                        }) {
                            if (curanimal.animal == "cat" && (coins % 5) != 0) {
                                Image("Cat1")
                                    .resizable()
                            } else if (curanimal.animal == "cat" && (coins % 5) == 0) {
                                    Image("Cat2")
                                        .resizable()
                            } else if (curanimal.animal == "dog" && (coins % 5) != 0) {
                                Image("Dog1")
                                    .resizable()
                            } else if (curanimal.animal == "dog" && (coins % 5) == 0) {
                                Image("Dog2")
                                    .resizable()
                            } else if (curanimal.animal == "bird" && (coins % 5) != 0) {
                                Image("Bird1")
                                    .resizable()
                            } else if (curanimal.animal == "bird" && (coins % 5) == 0) {
                                Image("Bird2")
                                    .resizable()
                            } else if (curanimal.animal == "bunny" && (coins % 5) != 0) {
                                Image("Bunny1")
                                    .resizable()
                            } else if (curanimal.animal == "bunny" && (coins % 5) == 0) {
                                Image("Bunny2")
                                    .resizable()
                            }
                        }
                        .padding()
                        .scaledToFit()
                        
                        ZStack {
                            Image ("bluetexture")
                                .opacity(0.5)
                            Text ("Coins: \(coins)")
                        }
                            .frame(width: 100, height: 30)
                            .background(Color.theme.accent1)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: -3, y: 3)
                            
                        
                        Button (action: {
                            shopView = true
                        }) {
                            ZStack {
                                Image("pinkstone")
                                    .resizable()
                                    .frame(width: 320, height: 220)
                                    .opacity(0.5)
                                Text ("Shop")
                                    .fontWeight(.bold)
                            }
                        }
                        .frame(width: 120, height: 20)
                        .padding(12)
                        .foregroundColor(.black)
                        .background(Color.theme.accent2)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: -5, y: 5)
                        
                        Spacer()
                    }
                    
                    
                    
                 
                } else {
                    ZStack {
                        VStack (spacing: 20) {
                            //Color.theme.butt2
                            Image ("pinktexture")
                                .resizable()
                                .frame(width: geo.size.width * 0.9, height: geo.size.height)
                                .scaledToFit()
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
                                Button (action: {
                                    sPetView = true
                                    sAccentView = false
                                    sBackgroundView = false
                                }) {
                                    ZStack{
                                        Image ("bluetexture")
                                            .resizable()
                                            .opacity(0.5)
                                        Text ("Pets")
                                    }
                                }
                                .frame(width: 100, height: 30)
                                .foregroundColor(.black)
                                .background(Color.theme.butt1)
                                
                                Button (action: {
                                    sPetView = false
                                    sAccentView = true
                                    sBackgroundView = false
                                }) {
                                    ZStack{
                                        Image ("bluetexture")
                                            .resizable()
                                            .opacity(0.5)
                                        Text ("Accents")
                                    }
                                }
                                .frame(width: 100, height: 30)
                                .foregroundColor(.black)
                                .background(Color.theme.butt1)
                                
                                Button (action: {
                                    sPetView = false
                                    sAccentView = false
                                    sBackgroundView = true
                                }) {
                                    ZStack{
                                        Image ("bluetexture")
                                            .resizable()
                                            .opacity(0.5)
                                        Text ("Backgrounds")
                                    }
                                }
                                .frame(width: 110, height: 30)
                                .foregroundColor(.black)
                                .background(Color.theme.butt1)
                            }
                            
                            Spacer()
                            
                            if (sPetView){
                                HStack {
                                    Text ("Cat")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtAni (animal: cat)
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!cat.owned) {
                                                Text ("100")
                                            } else {
                                                Text ("Switch")
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                                
                                HStack {
                                    Text ("Dog")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtAni (animal: dog)
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!dog.owned) {
                                                Text ("100")
                                            } else {
                                                Text ("Switch")
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                                
                                HStack {
                                    Text ("Bird")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtAni (animal: bird)
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!bird.owned) {
                                                Text ("100")
                                            } else {
                                                Text ("Switch")
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                                
                                HStack {
                                    Text ("Bunny")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtAni (animal: bunny)
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!bunny.owned) {
                                                Text ("100")
                                            } else {
                                                Text ("Switch")
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                            } else if (sAccentView) {
                                Text ("WIP")
                            } else if (sBackgroundView) {
                                
                                HStack {
                                    Text ("Default")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        curBack = ""
                                        notifTxt = "You switched to the default background!"
                                        notifView = true
                                        
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            Text ("Switch")
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                                
                                HStack {
                                    Text ("Outdoors Night")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtBack (back: nightBack)
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!nightBack.owned) {
                                                Text ("100")
                                            } else {
                                                Text ("Switch")
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                                
                                HStack {
                                    Text ("Outdoors Day")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtBack (back: dayBack)
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!dayBack.owned) {
                                                Text ("100")
                                            } else {
                                                Text ("Switch")
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.theme.butt1)
                                    .cornerRadius(15)
                                    .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                }
                                
                                    HStack {
                                        Text ("Indoors Boho")
                                            .font(.title2.weight(.medium))
                                        Spacer()
                                        Button (action: {
                                            shopButtBack (back: indoor1)
                                        }) {
                                            ZStack{
                                                Image ("bluetexture")
                                                    .resizable()
                                                    .opacity(0.5)
                                                if (!indoor1.owned) {
                                                    Text ("100")
                                                } else {
                                                    Text ("Switch")
                                                }
                                            }
                                        }
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(.black)
                                        .background(Color.theme.butt1)
                                        .cornerRadius(15)
                                        .shadow(color: .pink, radius: 3, x: -1, y: 1)
                                    }
                                    
                                    HStack {
                                        Text ("Indoors Industrial")
                                            .font(.title2.weight(.medium))
                                        Spacer()
                                        Button (action: {
                                            shopButtBack (back: indoor2)
                                        }) {
                                            ZStack{
                                                Image ("bluetexture")
                                                    .resizable()
                                                    .opacity(0.5)
                                                if (!indoor2.owned) {
                                                    Text ("100")
                                                } else {
                                                    Text ("Switch")
                                                }
                                            }
                                        }
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(.black)
                                        .background(Color.theme.butt1)
                                        .cornerRadius(15)
                                        .shadow(color: .pink, radius: 3, x: -1, y: 1)
                               }
                            }
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            Button (action: {
                                shopView = false
                            }) {
                                ZStack{
                                    Image ("bluetexture")
                                        .resizable()
                                        .opacity(0.5)
                                    Text ("Go Back")
                                }
                            }
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(Color.theme.butt1)
                            .cornerRadius(15)
                            .padding()
                            .shadow(color: .pink, radius: 3, x: -1, y: 1)
                        }
                        .frame(width: geo.size.width * 0.8)
                    }
                    
                }
                
                
                
                
                
                if (notifView == true) {
                    VStack (alignment: .leading, spacing: 20) {
                        Text (notifTxt)
                            .font(.title2.weight(.medium))
                            .padding()
                        
                        Button (action: {
                            notifView = false
                        }) {
                            Text ("Okay")
                        }
                        .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(Color.theme.butt1)
                        .cornerRadius(15)
                        .padding()
                    }
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.25)
                    .background(Color.theme.butt2)
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
