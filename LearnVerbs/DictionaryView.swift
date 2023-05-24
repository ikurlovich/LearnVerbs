import SwiftUI

struct DictionaryView: View {
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
            
            List(vm.dictionaryHome.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text(key)
                    Spacer()
                    Text(value)
                    Image(systemName: "goforward.plus")
                        .onTapGesture {
                            vm.moveKeyValuePair(from: &vm.dictionaryHome, to: &vm.anotherDictionary, forKey: key)
                        }
                }
            }
            
            Button {
                vm.resetUserDefaults()
            } label: {
                Text("Вернуть все глаголы")
            }
            .padding()
        }
        .onDisappear {
            UserDefaults.standard.set(vm.dictionaryHome, forKey: "dictionaryHome")
            UserDefaults.standard.set(vm.anotherDictionary, forKey: "anotherDictionary")
        }
    }
}



struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}
