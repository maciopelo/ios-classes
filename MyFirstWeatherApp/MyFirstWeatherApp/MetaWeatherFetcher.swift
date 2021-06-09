//
//  MetaWeatherFetcher.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 08/06/2021.
//

import Foundation
import Combine

class MetaWeatherFetcher{
    
    func forecast(forId woeId: String) -> AnyPublisher<MetaWeatherResponse,Error>
    {
        let apiURL = URL(string: "https://www.metaweather.com/api/location/\(woeId)")!

        return URLSession.shared
            .dataTaskPublisher(for: apiURL)
            .map {$0.data}
            .decode(type: MetaWeatherResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

