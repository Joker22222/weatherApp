//
//  SplashView.swift
//  WeatherApp
//
//  Created by Fernando Garay on 13/05/2023.
//

import Foundation

import SwiftUI


struct SplashView: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            VStack {
                VStack {
                    Spacer()
                    Image("logo").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom)
                    Spacer()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }.background(Color.black.ignoresSafeArea())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
