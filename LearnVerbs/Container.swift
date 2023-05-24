import SwiftUI

struct Container: View {
    @StateObject private var vm = ContainerVM()
    
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Начальная страница", systemImage: "house.fill")
                    }
                
                DictionaryView()
                    .badge(vm.dictionaryHome.count)
                    .tabItem {
                        Label("Глаголы на изучении", systemImage: "character.book.closed.fill")
                    }
                
                DictionaryPlusView()
                    .badge(vm.anotherDictionary.count)
                    .tabItem {
                        Label("Изученные глаголы", systemImage: "text.book.closed.fill")
                    }
            }
            .environmentObject(vm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
}
