//
//  ContentView.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel:WeatherViewModel
    
    var body: some View {
        ScrollView(.vertical){
        VStack {
            ForEach(viewModel.records){rec in
                SingleCityWeatherRowView(record: rec)
            }
        }.padding()
    }
}
}

struct SingleCityWeatherRowView: View{
    var record: WeatherModel.WeatherRecord
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius:25.0).stroke()
            HStack{
                Text("☀️").font(.largeTitle)
                Text(record.cityName)
                Text("\(record.temp,specifier: "%.2f")℃").font(.caption)
            }.padding()
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel:WeatherViewModel())
    }
}
