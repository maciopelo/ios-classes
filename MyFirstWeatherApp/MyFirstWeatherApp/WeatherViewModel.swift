//
//  WeatherViewModel.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation

class WeatherViewModel{
    
    private(set) var model: WeatherModel = WeatherModel( cities: ["Warsaw", "Paris", "Berlin", "Barcelona","Rome","London","Madrid"])
    
    var records: Array<WeatherModel.WeatherRecord>{
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
}
