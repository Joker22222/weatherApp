//
//  WeatherIconView.swift
//  Weather App
//
//  Created by Fernando Garay on 15/05/2023.
//

import Foundation
import SwiftUI

struct WeatherIconView: View {
    @ObservedObject var iconLoader: IconLoader
    
    init(iconURLString: String) {
        let urlString = "https://openweathermap.org/img/wn/\(iconURLString)@2x.png"
        let iconURL = URL(string: urlString)!
        self.iconLoader = IconLoader(iconURL: iconURL)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 100, height: 100)
            
            Image(uiImage: UIImage(data: iconLoader.iconData) ?? UIImage(systemName: "questionmark.circle.fill")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
        }
    }
}
