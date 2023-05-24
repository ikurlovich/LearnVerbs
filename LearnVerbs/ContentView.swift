import SwiftUI

struct ContentView: View {
    var ttT = DictionaryView()
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Начальная страница", systemImage: "house.fill")
                    }
                DictionaryView()
                    .badge(ttT.dictionaryHome.count)
                    .tabItem {
                        Label("Глаголы на изучении", systemImage: "character.book.closed.fill")
                    }
                DictionaryPlusView()
                    .badge(ttT.anotherDictionary.count)
                    .tabItem {
                        Label("Изученные глаголы", systemImage: "text.book.closed.fill")
                    }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
