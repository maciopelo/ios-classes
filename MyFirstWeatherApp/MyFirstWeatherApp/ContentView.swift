//
//  ContentView.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel:WeatherViewModel
    
    var body: some View {
        ScrollView(.vertical){
        VStack {
            ForEach(viewModel.records){rec in
                SingleCityWeatherRowView(record: rec,
                                         viewModel:viewModel)
            }
        }.padding()
    }
}
}


let MIN_ROW_HEIGHT = 69.0
let MAX_ROW_HEIGHT = 69.0
let ROW_RADIUS = 20.0
let WEATHER_ICON_RATIO = 0.1
let DEFAULT_PADDING = 10
let VSTACK_MIN_WIDTH = 120.0

struct SingleCityWeatherRowView: View{
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius:CGFloat(ROW_RADIUS)).stroke()
            GeometryReader(content: { rec in
                    
                HStack(alignment: .center){
                    Text(verbatim:viewModel.getProperIcon(record: record))
                        .font( .system( size: CGFloat(WEATHER_ICON_RATIO) * rec.size.width ) )
                        .padding(.leading, CGFloat(DEFAULT_PADDING))
                        
                    VStack(alignment: .leading){
                        Text(record.cityName)
                        Text("Temp: \(record.temp,specifier: "%.2f") ℃").font(.caption)
                        Text("Hum: \(record.humidity,specifier: "%.2f") %").font(.caption)
                        Text("Wind: \(record.windSpeed,specifier: "%.2f") mps").font(.caption)
                    }.frame(minWidth:CGFloat(VSTACK_MIN_WIDTH), maxWidth: .infinity, alignment: .center)
                    
                    Text("⟳")
                        .font(.largeTitle)
                        .padding(.trailing, CGFloat(DEFAULT_PADDING))
                        .onTapGesture {
                            viewModel.refresh(record: record)
                        }
                }
            })
        }.frame(
            maxWidth: .infinity,
            minHeight: CGFloat(MIN_ROW_HEIGHT),
            maxHeight: CGFloat(MAX_ROW_HEIGHT)
        )
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel:WeatherViewModel())
    }
}
