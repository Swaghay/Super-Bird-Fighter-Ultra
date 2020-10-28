//
//  MainMenu.swift
//  Chicken Fighter Ultra
//
//  Created by 64004046 on 10/28/20.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        
        Button(action: {
            
            
            
        }){
            
            Image("StartButton")
                .interpolation(.none)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                            
        }
        
    /*    NavigationLink(destination: GameScene){
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.green)
                    .frame(width: 50, height: 30)
                
                Text("Start")
                    .font(.footnote)
                    .foregroundColor(Color.black)
                
            }
            
        }
        .frame(width: 50, height: 30)
    
    */
        
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

