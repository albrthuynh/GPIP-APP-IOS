//
//  AddBandageView.swift
//  GPIP Outline
//
//  Created by Albert Huynh on 6/27/23.
//

import Foundation
import SwiftUI
import Charts


struct HeaderView: View{
    var body: some View{
        HStack{
            Spacer()
            Image(systemName: "staroflife.fill")
            
            Text("Bandage Data")
                .bold()
            
            Image(systemName: "staroflife.fill")
            Spacer()
        }
    }
}
    
struct SavingsPoint: Identifiable {
    let date: String
    let value: String
    var id = UUID()
    
}

struct AddBandageView: View{
    
    var chartData: [SavingsPoint]{
        return generateChartData()
    }
    
    var currentVal: String {
        return chartData.last?.value ?? "N/A"
    }

    //core data implementation
    var body: some View{
        
        let nameBandage = ["Elbow", "Arm", "Leg", "Knee", "Neck", "Shoulder"]
        let values = [2.3, 4, 8.6, 9, 10, 7.2, 7.7]
        
        
        
        VStack(alignment: .center){
            HeaderView()
                .padding(.horizontal)
       
//            Text("Current PH Level: \(chartData.last?.value ?? 0)" )
//                .font(.title)
//                .padding()
//                .foregroundColor(.blue)
            
            Text("Current PH Level: \(currentVal)" )
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.blue)
                
            
                
            
            ScrollView{
                Spacer()
                Group {
                           Text("Bandage Location: \(nameBandage.randomElement()!)")
                           Text("History of Wound (Past 7 Days)")
                       }
                       .font(.callout)
                       .fontWeight(.light)
                           
                Chart{
                      ForEach(chartData){ item in
                          BarMark(x: .value("date", item.date), y: .value("acid level", item.value))
                      }
                  }
                  .frame(minHeight: 200)
                
                if let currentPH = Double(currentVal){
                if currentPH > 7.0 && currentPH < 8.0 {
                    Text("Great Progress! \nYour doctor would like to see you!")
                        .bold()
                        .font(.title2)
                    
                    Link("Learn More About Your Wound! Link Here", destination: URL(string: "https://ieeexplore.ieee.org/abstract/document/10182338")!)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 2.0)
                            )
                }
                else if currentPH > 8.0 {
                    Text("Your doctor would like to see you!")
                        .bold()
                        .font(.title2)
                    
                    Link("Learn More About Your Wound! Link Here", destination: URL(string: "https://ieeexplore.ieee.org/abstract/document/10182338")!)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 2.0)
                            )
                }
                    else{
                        Text("Your Wound is Healing!")
                            .foregroundColor(.green)
                            .bold()
                            .font(.title2)
                        
                        Link("Learn More About Your Wound's PH Level! Link Here", destination: URL(string: "https://ieeexplore.ieee.org/abstract/document/10182338")!)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 2.0)
                            )
                    }
                }
            }
        }
        
    }
}

private func generateChartData() -> [SavingsPoint] {
    // Create a date formatter to parse and format dates
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy"

    // Get the current date
    let currentDate = Date()

    // Generate data for the past 7 days
    var data: [SavingsPoint] = []
    for day in 0..<7 {
        let date = Calendar.current.date(byAdding: .day, value: -day, to: currentDate)!
        let dateString = dateFormatter.string(from: date)
        // Replace this with your logic to fetch pH values for the specific date
        
        let randomValue = String(format: "%.1f", Double.random(in: 1.0...10.0))
        
        data.append(SavingsPoint(date: dateString, value: randomValue))
    }

    // Sort data by date in ascending order
    data.sort { dateFormatter.date(from: $0.date)! < dateFormatter.date(from: $1.date)! }

    return data
}

struct AddBandageView_Previews: PreviewProvider{
    static var previews: some View{
        Group{
            AddBandageView()
            
            AddBandageView()
                .environment(\.colorScheme, .dark)
        }
    }
}
