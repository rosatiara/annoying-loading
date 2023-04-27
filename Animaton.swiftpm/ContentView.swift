import SwiftUI
import AVFoundation
var backingAudio = AVAudioPlayer()
var carAudio = AVAudioPlayer()

struct ContentView: View {
    @State var currentDegree: Double = 0
    @State var currentCarSize: CGFloat = 60.0
    
    var body: some View {
        if currentCarSize >= 360 {
            ZStack {
                Image("crack")
                    .resizable()
                    .frame(width: 500, height: 900)
                    .scaledToFit()
                    .padding()
                    .onAppear {
                        let filePath = Bundle.main.path(forResource: "glass-smash", ofType: "mp3")
                        let audioNSURL = NSURL(fileURLWithPath: filePath!)
                        
                        do { backingAudio = try AVAudioPlayer(contentsOf: audioNSURL as URL)}
                        catch { return print("Cannot Find The Audio")}
                        backingAudio.numberOfLoops = 0
                        backingAudio.volume = 0.5
                        backingAudio.play()
                    }
                VStack {
                    Text("Loaded!")
                        .bold()
                        .font(.system(size: 40))
                        .offset(y: -250)
                    
                    Text("But your phone cracked :(")
                        .offset(y: 300)
                    
                }
                
            }
            
            
        } else {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    Text("🚖")
                        .font(.system(size: currentCarSize))
                    Text("LOADING LOADINGGGG......")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .bold()
                }
                .rotationEffect(Angle(degrees: currentDegree))
                
                
            }.onAppear(perform: {
                for i in 1...6 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            currentDegree = Double(i) * 30
                            currentCarSize += 50
                        }
                        let filePathCar = Bundle.main.path(forResource: "car-horn", ofType: "m4a")
                        let audioNSURL = NSURL(fileURLWithPath: filePathCar!)
                        
                        do { carAudio = try AVAudioPlayer(contentsOf: audioNSURL as URL)}
                        catch { return print("Cannot Find The Audio")}
                        carAudio.volume = 0.5
                        carAudio.play()
                    }
                    
                }
                
                
            })
        }
        
    }
}


