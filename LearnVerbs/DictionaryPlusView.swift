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
                }
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
    }    
}

struct DictionaryPlusView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryPlusView()
    }
}
