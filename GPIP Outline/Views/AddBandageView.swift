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
    let value: Double
    var id = UUID()
    
}

struct AddBandageView: View{
    
    var chartData = [SavingsPoint(date: "7/09/23", value: 2.3),
                     SavingsPoint(date: "7/10/23", value: 4),
                     SavingsPoint(date: "7/11/23", value: 8.6),
                     SavingsPoint(date: "7/12/23", value: 3.4),
                     SavingsPoint(date: "7/13/23", value: 10),
                     SavingsPoint(date: "7/14/23", value: 4.5),
                     SavingsPoint(date: "7/15/23", value: 2.3)]

    //core data implementation
    var body: some View{
        
        let nameBandage = ["Elbow", "Arm", "Leg", "Knee", "Neck", "Shoulder"]
        let values = [2.3, 4, 8.6, 9, 10, 7.2, 2.3]
        
        let currentVal = values.randomElement()!
        
        VStack(alignment: .leading){
            HeaderView()
                .padding(.horizontal)
       
//            Text("Current PH Level: \(chartData.last?.value ?? 0)" )
//                .font(.title)
//                .padding()
//                .foregroundColor(.blue)
            
            Text("Current PH Level: \(currentVal)" )
                .font(.title)
                .padding()
                .foregroundColor(.blue)
            
                
            
            ScrollView{
                Spacer()
                Group{
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
                
                
                if currentVal > 7.0 {
                    Text("Your Doctor would like to see you!")
                        .foregroundColor(.black)
                        .bold()
                        .font(.title2)
                    
                    Text("high alkaline pH have a lower healing rate in both acute and chronic wounds as compared to wounds with a pH closer to neutral. Wound healing progression decreases when pH is elevated to alkaline condition.")
                        .foregroundColor(.black)
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
                    Text("A low pH value leads to the Bohr-effect (ie, an increase of the amount of available oxygen of cells). The delivery of oxygen to damaged tissue, especially in chronic wounds, depends on perfusion as well as diffusion.")
                        .foregroundColor(.cyan)
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

struct AddBandageView_Previews: PreviewProvider{
    static var previews: some View{
        Group{
            AddBandageView()
            
            AddBandageView()
                .environment(\.colorScheme, .dark)
        }
    }
}
