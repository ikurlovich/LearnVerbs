
import SwiftUI

struct DictionaryView: View {
    
    @State var anotherDictionary: [String: String] = UserDefaults.standard.dictionary(forKey: "anotherDictionary") as? [String: String] ?? [:]
    
    @State var dictionaryHome: [String: String] = UserDefaults.standard.dictionary(forKey: "dictionaryHome") as? [String: String] ?? [
        "be": "was/were",
        "become": "became",
        "begin": "began",
        "buy": "bought",
        "can": "could",
        "catch": "caught",
        "choose": "chose",
        "come": "came",
        "cost": "cost",
        "cut": "cut",
        "do": "did",
        "draw": "drew",
        "dream": "dreamed/dreamt",
        "drink": "drank",
        "drive": "drove",
        "eat": "ate",
        "fall": "fell",
        "feed": "fed",
        "feel": "felt",
        "fight": "fought"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("     Правильные")
                    .font(.headline)
                Spacer()
                Text("Неправильные     ")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            List(dictionaryHome.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text(key)
                    Spacer()
                    Text(value)
                    Image(systemName: "goforward.plus")
                        .onTapGesture {
                            moveKeyValuePair(from: &dictionaryHome, to: &anotherDictionary, forKey: key)
                        }
                }
            }
            Button(action: resetUserDefaults) {
                Text("Вернуть все глаголы")
            }
            .padding()
        }
        .onDisappear {
            UserDefaults.standard.set(dictionaryHome, forKey: "dictionaryHome")
            UserDefaults.standard.set(anotherDictionary, forKey: "anotherDictionary")
        }
    }
    func moveKeyValuePair(from source: inout [String: String], to destination: inout [String: String], forKey key: String) {
        if let value = source[key] {
            destination[key] = value
            source.removeValue(forKey: key)
        }
    }
    func resetUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "dictionaryHome")
        UserDefaults.standard.removeObject(forKey: "anotherDictionary")
        dictionaryHome = [
            "be": "was/were",
            "become": "became",
            // ...
        ]
        anotherDictionary = [:]
    }
}



struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}
