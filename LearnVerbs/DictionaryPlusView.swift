import SwiftUI

struct DictionaryPlusView: View {
    @EnvironmentObject private var vm: ContainerVM
    
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
            
            List(vm.anotherDictionary.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text(key)
                    Spacer()
                    Text(value)
                    Image(systemName: "goforward.plus")
                        .foregroundColor(.green)
                        .onTapGesture {
                            vm.generator.selectionChanged()
                            vm.moveKeyValuePair(from: &vm.anotherDictionary, to: &vm.dictionaryHome, forKey: key)
                        }
                }
            }
        }
        .onDisappear {
            UserDefaults.standard.set(vm.anotherDictionary, forKey: "anotherDictionary")
            UserDefaults.standard.set(vm.dictionaryHome, forKey: "dictionaryHome")
        }
        .toolbarBackground(.visible, for: .tabBar)
    }
}

struct DictionaryPlusView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryPlusView()
            .environmentObject(ContainerVM())
    }
}
