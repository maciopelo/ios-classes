//
//  MyFirstWeatherAppApp.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import SwiftUI

@main
struct MyFirstWeatherAppApp: App {
    var viewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
