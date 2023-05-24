import SwiftUI
import AVFoundation

struct HomeView: View {
    @State private var key = ""
    @State private var value = ""
    @State private var showValue = false
    @State private var showValue2 = false
    @State private var usedKeys: Set<String> = []
    let synthesizer = AVSpeechSynthesizer()
    var ddD = DictionaryView()
    
    var body: some View {
        VStack {
            
            GroupBox(label:
                        Text("**Irregular Verbs**").foregroundColor(.accentColor)) {
                Text(key)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .onAppear(perform: {
                        generateRandomPair()
                    })
                if showValue {
                    Text(value)
                        .font(.largeTitle)
                        .padding()
                }
                
                HStack {
                    Button(action: {
                        speak(text: showValue ? value : key)
                    }) {
                        if showValue2 == false {
                            Text("Озвучить  |")
                        }
                    }
                    .disabled(key.isEmpty)
                    Button(action: {
                        showValue.toggle()
                        if showValue == false {
                            generateRandomPair()
                        }
                    }) {
                        if showValue2 == false {
                            Text(showValue ? "Следующий глагол >" : "Неправильная форма")
                        }
                    }
                }
                if usedKeys.count == ddD.dictionaryHome.count {
                    Button(action: {
                        usedKeys.removeAll()
                        generateRandomPair()
                        showValue2 = false
                    }) {
                        Text("Повторить")
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
    
    func generateRandomPair() {
        let availableKeys = ddD.dictionaryHome.keys.filter { !usedKeys.contains($0) }
        if let randomKey = availableKeys.randomElement() {
            key = randomKey
            value = ddD.dictionaryHome[randomKey]!
            usedKeys.insert(randomKey)
        } else {
            key = "Глаголы закончились, повторим?"
            value = ""
            showValue2 = true
        }
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        synthesizer.speak(utterance)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
