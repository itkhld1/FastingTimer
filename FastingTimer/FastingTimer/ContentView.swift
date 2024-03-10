//
//  ContentView.swift
//  FastingTimer
//
//  Created by Itkhld on 8.03.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManager = FastingManager()
    
    var title: String {
        switch fastingManager.fastingState{
            
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    
    var body: some View {
        ZStack{
            // MARK: Background
            
            Color(#colorLiteral(red: 0.05426649867, green: 0.004790317244, blue: 0.1042639349, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    
    var content: some View{
        ZStack {
            VStack(spacing: 30) {
                // MARK: Title
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1)))
                
                //MARK: Fasting Plan
                
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            VStack{
                // MARK: Progress Ring
                
                ProgressRing()
                    .environmentObject(fastingManager)
                
                HStack(spacing: 60){
                    // MARK: Start Time
                    
                    VStack(spacing: 5){
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    // MARK: End Time
                    
                    VStack(spacing: 5){
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                
                // MARK: Button
                .padding()
                Button {
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fast" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                } .padding()
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
