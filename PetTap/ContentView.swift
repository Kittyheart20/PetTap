//
//  ContentView.swift
//  PetTap
//
//  Created by Arin Haynes on 8/12/22.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State private var coins: Int
    @State private var mute = false
    @State private var tutorial: Int
    
    
    @State private var shopView = false
    @State private var sPetView = true
    @State private var sAccentView = false
    @State private var sBackgroundView = false
    
    @State private var notifView = false
    @State private var notifTxt = ""
    
    @State private var curanimal = Pets(animal: "")
    @State private var pets: [Pets]
    
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
    
    init () {
        SoundManager.instance.startBM ()
        if UserDefaults.standard.value(forKey: "COINS_KEY") == nil {
            coins = 50
            UserDefaults.standard.set(50, forKey: "COINS_KEY") 
        } else {
            coins = UserDefaults.standard.integer(forKey: "COINS_KEY")
        }

        if UserDefaults.standard.value(forKey: "TUTORIAL") == nil {
            tutorial = 0
            UserDefaults.standard.set(0, forKey: "TUTORIAL")
            notifTxt = "Welcome to PetTap! To get started, we need a pet! Click on shop"
            notifView = true
        } else {
            tutorial = UserDefaults.standard.integer(forKey: "TUTORIAL")
        }
        
        if let data = UserDefaults.standard.data(forKey: "Pets_Key") {
            if let decoded = try? JSONDecoder().decode([Pets].self, from: data) {
                pets = decoded
                return
            }
        }
        pets = [Pets(animal: "cat"), Pets(animal: "dog"), Pets(animal: "bird"), Pets(animal: "bunny"), Pets(animal: "fish")]
    }
    
    func saveData () {
        if let encoded = try? JSONEncoder().encode(pets) {
            UserDefaults.standard.set(encoded, forKey: "Pets_Key")
        }
        UserDefaults.standard.set(coins, forKey: "COINS_KEY")
    }
    
    func checkMinBal (min: Int) -> Bool {
        if(min <= coins) {
            return true
        }
        return false
    }
    
    func shopButtAni (animal: Pets) {
        if (!animal.owned){
           if (checkMinBal(min: animal.price)) {
               coins -= animal.price
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
        saveData()
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
                    
                    
                
                if (!shopView) {
                    Header()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .position(x: geo.size.width/2, y: geo.size.height * -0.1)
                    
                    VStack (spacing: 10) {
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        Button (action: {
                            coins += 1
                            saveData()
                            if (tutorial == 4) {
                                notifTxt = "Congratualtions! You have completed the tutorial! Have fun!"
                                notifView = true
                            }
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
                            } else if (curanimal.animal == "fish" && (coins % 5) != 0) {
                                Image("Fish1")
                                    .resizable()
                            } else if (curanimal.animal == "fish" && (coins % 5) == 0) {
                                Image("Fish2")
                                    .resizable()
                            }
                        }
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.7)
                        .position(x: geo.size.width/2, y: geo.size.height * 0.41)
                        
                        ZStack {
                            Image ("bluetexture")
                                .opacity(0.5)
                            Text ("Coins: \(coins)")
                        }
                            .frame(width: 100, height: 30)
                            .background(Color.theme.accent1)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: -3, y: 3)
                            .position(x: geo.size.width/2, y: geo.size.height * 0.47)
                            
                        HStack (spacing: 10) {
                            Button (action: {
                                shopView = true
                                if (tutorial == 1) {
                                    notifTxt = "This is the store where you can buy pets. Let's start with the fish."
                                    notifView = true
                                }
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
                            .position(x: geo.size.width * 0.45, y: geo.size.height * 0.23)
                            
                            Button (action: {
                                if (mute) {
                                    mute = false
                                    SoundManager.instance.resumeBM ()
                                } else {
                                    mute = true
                                    SoundManager.instance.stopSound()
                                }
                            }) {
                                if (mute) {
                                    Image ("mute")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                        .position(x: geo.size.width * 0.2, y: geo.size.height * 0.23)
                                } else {
                                    Image ("volume")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                        .position(x: geo.size.width * 0.2, y: geo.size.height * 0.23)
                                }
                            }
                            
                        }
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
                                        shopButtAni (animal: pets [0])
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!pets [0].owned) {
                                                Text ("1000")
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
                                        shopButtAni (animal: pets [1])
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!pets [1].owned) {
                                                Text ("1000")
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
                                        shopButtAni (animal: pets [3])
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!pets [3].owned) {
                                                Text ("500")
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
                                        shopButtAni (animal: pets [2])
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!pets [2].owned) {
                                                Text ("200")
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
                                    Text ("Fish")
                                        .font(.title2.weight(.medium))
                                    Spacer()
                                    Button (action: {
                                        shopButtAni (animal: pets [4])
                                        if (tutorial == 2) {
                                            notifTxt = "Great! You can also toggle tabs above to buy new backgrounds. Let's go back to see our fish."
                                            notifView = true
                                        }
                                    }) {
                                        ZStack{
                                            Image ("bluetexture")
                                                .resizable()
                                                .opacity(0.5)
                                            if (!pets [4].owned) {
                                                Text ("50")
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
                                if (tutorial == 3) {
                                    notifTxt = "Tap on the fish to collect coins."
                                    notifView = true
                                }
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
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Button (action: {
                            notifView = false
                            if (tutorial < 5) {
                                tutorial += 1
                            }
                        }) {
                            Text ("Okay")
                        }
                        .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(Color.theme.butt1)
                        .cornerRadius(15)
                        .padding()
                    }
                    .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.3)
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
