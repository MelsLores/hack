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

            MapaView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Mapa")
                }

            Text("Pantalla de Búsqueda")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Buscar")
                }

            Text("Pantalla de la Comunidad")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Comunidad")
                }

            Text("Pantalla del Perfil")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
            
            Text("Pantalla de Lugares Turísticos")
                .tabItem {
                    Image(systemName: "binoculars.fill")
                    Text("Turismo")
                }
        }
        .accentColor(.blue)
    }
}
