import SwiftUI

struct MainView: View {
    // Recibe la lista de equipos desde ContentView
    let equiposSeleccionados: [Equipo]

    var body: some View {
        TabView {
            // Pasa los equipos a la HomeView
            HomeView(equipos: equiposSeleccionados)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Text("Pantalla de Cultura")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Cultura")
                }

            Text("Pantalla de Estadio")
                .tabItem {
                    Image(systemName: "sportscourt.fill")
                    Text("Estadio")
                }

            MapaView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Mapa")
                }
        }
        .accentColor(Color.theme.primaryAccent)
    }
}
