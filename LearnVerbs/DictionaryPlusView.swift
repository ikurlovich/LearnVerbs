//
//  DictionaryPlusView.swift
//  LearnVerbs
//
//  Created by Илья Курлович on 25.05.2023.
//

import SwiftUI

struct DictionaryPlusView: View {
    
    var dView = DictionaryView()
    
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
            
            List(dView.anotherDictionary.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text(key)
                    Spacer()
                    Text(value)
                }
            }
        }
    }
    func moveKeyValuePair(from source: inout [String: String], to destination: inout [String: String], forKey key: String) {
        if let value = source[key] {
            destination[key] = value
            source.removeValue(forKey: key)
        }
    }
}

struct DictionaryPlusView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryPlusView()
    }
}
