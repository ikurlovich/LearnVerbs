import SwiftUI
import AudioToolbox

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
            .padding(.top)
            
            List(vm.dictionaryHome.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text(key)
                    Spacer()
                    Text(value)
                    Image(systemName: "trash.circle")
                        .foregroundColor(.red)
                        .onTapGesture {
                            vm.generator.selectionChanged()
                            vm.moveKeyValuePair(from: &vm.dictionaryHome, to: &vm.anotherDictionary, forKey: key)
                            
                        }
                }
            }
            
            Button {
                vm.resetUserDefaults()
                vm.generator.selectionChanged()
            } label: {
                Text("Вернуть все глаголы из архива")
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
            .environmentObject(ContainerVM())
    }
}
