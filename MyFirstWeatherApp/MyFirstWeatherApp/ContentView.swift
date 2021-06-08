//
//  ContentView.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    
    @ObservedObject var viewModel:WeatherViewModel
    
    var body: some View {
        ScrollView(.vertical){
        VStack {
            ForEach(viewModel.records){rec in
                SingleCityWeatherRowView(record1: rec,
                                         viewModel1:viewModel)
            }
        }.padding()
    }
}
}

struct Place: Identifiable{
    let id = UUID()
    let  coordinate: CLLocationCoordinate2D
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
    
    @State private var region : MKCoordinateRegion
    @State private var showingSheet: Bool = false
    @State private var places: [Place]
    
    init(record1: WeatherModel.WeatherRecord, viewModel1: WeatherViewModel) {
        record = record1
        viewModel = viewModel1
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: record.latitutde, longitude: record.longitude
        ), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
        _places = State(initialValue: [Place(coordinate: .init(latitude: record.latitutde, longitude: record.longitude))])
    }
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
                        .onTapGesture {viewModel.refresh(record: record)}
                    
                    Text("🔎")
                        .onTapGesture{
                            setCoordinates(latt: record.latitutde, long: record.longitude)
                            showingSheet = true
                            }
                        .sheet(isPresented: $showingSheet, content:{
                            VStack{
                                Text("\(record.cityName)")
                            
                            Map(coordinateRegion: $region,annotationItems: places )
                                {place in MapPin(coordinate: place.coordinate)}
                            .onAppear(perform: {setCoordinates(latt: record.latitutde, long: record.longitude)})
                                
                        }
                })
                        .frame(alignment: .trailing)
                        .padding(.trailing, 10)
                    
                }
            })
        }.frame(
            maxWidth: .infinity,
            minHeight: CGFloat(MIN_ROW_HEIGHT),
            maxHeight: CGFloat(MAX_ROW_HEIGHT)
        )
        
        
    }
    
    func setCoordinates(latt: Double, long: Double){
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latt, longitude: long), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        print(region.center)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel:WeatherViewModel())
    }
}
