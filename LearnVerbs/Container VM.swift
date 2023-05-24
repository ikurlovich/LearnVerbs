import SwiftUI

class ContainerVM: ObservableObject {
    @Published var anotherDictionary = UserDefaults.standard.dictionary(forKey: "anotherDictionary") as? [String: String] ?? [:]
    @Published var dictionaryHome = UserDefaults.standard.dictionary(forKey: "dictionaryHome") as? [String: String] ?? [
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
        anotherDictionary.removeAll()
    }
}
