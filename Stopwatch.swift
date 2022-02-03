//
//  Stopwatch.swift
//  iOS Lab Day 1
//
//  Created by Amogh Mantri on 1/27/22.
//

import SwiftUI

struct Stopwatch: View {
    
    let timer = Timer.publish(every: f0.01, on: .main, in: .common).autoconnect()
    @State var milliSeconds = 0
    @State var seconds = 0
    @State var minutes = 0
    @State var running = false
    @State var lap = 1
    @State var lapMinutes = 0
    @State var lapSeconds = 0
    @State var lapMilliseconds = 0
    @State var laps : [Lap] = []
    var body: some View {
        VStack{
            getTimeString(cS: milliSeconds, sS: seconds, mS: minutes).font(.system(size: 60, design: .monospaced))
                .frame(width: 300.0, height: 100.0)
                .onReceive(timer) { input in
                    if(running){
                        if(milliSeconds < 100){
                            milliSeconds += 1
                            
                        }
                        else{
                            milliSeconds = 0
                            seconds += 1
                        }
                        if(seconds > 59){
                            seconds = 0
                            minutes += 1
                        }
                        
                        if(lapMilliseconds < 100){
                            lapMilliseconds += 1
                            
                        }
                        else{
                            lapMilliseconds = 0
                            lapSeconds += 1
                        }
                        if(lapSeconds > 59){
                            lapSeconds = 0
                            lapMinutes += 1
                        }

                    }
                    
                }
            HStack{
                Button(action: {
                    if(running){
                    laps.append(Lap(n: lap, t: "\(lapMinutes):\(lapSeconds):\(lapMilliseconds)"))
                    lapMinutes = 0
                    lapMilliseconds = 0
                    lapSeconds = 0
                    lap += 1
                    }else{
                        lapMinutes = 0
                        lapMilliseconds = 0
                        lapSeconds = 0
                        laps = []
                        minutes = 0
                        seconds = 0
                        milliSeconds = 0
                    }
                }) {
                    ZStack{
                        Circle().fill(Color.gray).frame(width: 60, height: 60)
                        Text("\(running ? "Lap" : "Reset")").foregroundColor(Color.white)
                    }
                }
                Spacer()
                Button(action: {
                    running.toggle()
                }) {
                    ZStack{
                        Circle().fill(running ? Color.red : Color.green).frame(width: 60, height: 60)
                        Text("\(running ? "Stop" : "Start")").foregroundColor(Color.white)
                    }
                }
            }
            
        }.padding()
        
        List {
            Lap(n: lap, t: "\(lapMinutes):\(lapSeconds):\(lapMilliseconds)")
            ForEach(self.laps.reversed()) { time in
                time
            }
        }
    }
    
    
    func getTimeString(cS: Int, sS : Int, mS: Int) -> Text{
        var centiString = String(cS)
        var secString = String(sS)
        var minString = String(mS)
        if(cS<10){
            centiString = "0\(cS)"
        }
        if(sS<10){
            secString = "0\(sS)"
        }
        if(mS<10){
            minString = "0\(mS)"
        }
        return Text("\(minString):\(secString).\(centiString)")
    }
    
}

struct Lap : View, Identifiable{
    var id = UUID()
    let num : Int
    let time : String
    
    var body : some View{
        HStack{
            Text("Lap \(num)").font(.system(size: 20, design: .monospaced))
            Spacer()
            Text(time).font(.system(size: 20, design: .monospaced))
        }
    }
    
    init(n : Int, t : String){
        num = n
        time = t
    }
}


struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch()
    }
}
