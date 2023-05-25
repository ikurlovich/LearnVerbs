import SwiftUI
import AVFoundation

struct HomeView: View {
    @EnvironmentObject private var vm: ContainerVM
    
    @State private var key = ""
    @State private var value = ""
    @State private var showValue = false
    @State private var showValue2 = false
    @State private var usedKeys: Set<String> = []
    
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            GroupBox(label: Text("**Irregular Verbs**").foregroundColor(.accentColor)) {
                Text(key)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .onAppear {
                        generateRandomPair()
                    }
                
                if showValue {
                    Text(value)
                        .font(.largeTitle)
                        .padding()
                }
                
                HStack {
                    Button {
                        speak(showValue ? value : key)
                        vm.generator.selectionChanged()
                    } label: {
                        if !showValue2 {
                            Text("Озвучить  |")
                        }
                    }
                    .disabled(key.isEmpty)
                    
                    Button {
                        vm.generator.selectionChanged()
                        showValue.toggle()
                        if !showValue {
                            generateRandomPair()
                        }
                    } label: {
                        if !showValue2 {
                            Text(showValue ? "Следующий глагол >" : "Неправильная форма")
                        }
                    }
                }
                
            }
            .padding()
            
                Button {
                    vm.generator.selectionChanged()
                    usedKeys.removeAll()
                    generateRandomPair()
                    showValue2 = false
                } label: {
                    Text("Рестарт")
                        .foregroundColor(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.accentColor)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 2)
                        }
                        .shadow(color: .accentColor, radius: 5, x: 0, y: 2)
                        .padding()
                }
        }
    }
    
    func generateRandomPair() {
        let availableKeys = vm.dictionaryHome.keys.filter { !usedKeys.contains($0) }
        
        if let randomKey = availableKeys.randomElement() {
            key = randomKey
            value = vm.dictionaryHome[randomKey]!
            usedKeys.insert(randomKey)
        } else {
            key = "Глаголы закончились, повторим?"
            value = ""
            showValue2 = true
        }
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        synthesizer.speak(utterance)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContainerVM())
    }
}
