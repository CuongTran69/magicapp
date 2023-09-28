//
//  CountDownTetView.swift
//  MagicApp
//
//  Created by Cường Trần on 27/09/2023.
//

import SwiftUI

struct CountDownTetView: View {
    // Target date for Tet 2024 (January 25, 2024)
    let targetDate = DateComponents(calendar: .current, year: 2024, month: 1, day: 25).date!
    
    @State private var currentDate = Date()
    
    var timeUntilTet: TimeInterval {
        let calendar = Calendar.current
        let timeDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: targetDate)
        return TimeInterval(timeDifference.second ?? 0 + timeDifference.minute! * 60 + timeDifference.hour! * 3600 + timeDifference.day! * 86400)
    }
    
    var body: some View {
        VStack {
            Text("Countdown to Tet 2024")
                .font(.largeTitle)
                .padding()
            
            Text("\(Int(timeUntilTet / 86400)) days")
                .font(.title)
            
            Text("\(Int((timeUntilTet.truncatingRemainder(dividingBy: 86400)) / 3600)) hours")
                .font(.title)
            
            Text("\(Int((timeUntilTet.truncatingRemainder(dividingBy: 3600)) / 60)) minutes")
                .font(.title)
            
            Text("\(Int(timeUntilTet.truncatingRemainder(dividingBy: 60))) seconds")
                .font(.title)
        }
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentDate = Date()
            }
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}

struct CountDownTetView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownTetView()
    }
}
