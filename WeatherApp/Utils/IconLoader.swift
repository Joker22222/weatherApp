//
//  IconLoader.swift
//  Weather App
//
//  Created by Fernando Garay on 15/05/2023.
//

import Foundation

class IconLoader: ObservableObject {
    let iconURL: URL
    @Published var iconData = Data()

    init(iconURL: URL) {
        self.iconURL = iconURL
        self.loadImage()
    }

    func loadImage() {
        let task = URLSession.shared.dataTask(with: iconURL) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.iconData = data
            }
        }
        task.resume()
    }
}
