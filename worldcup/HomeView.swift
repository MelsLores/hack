import SwiftUI

struct HomeView: View {
    // Recibe la lista de equipos seleccionados
    let equipos: [Equipo]

    var body: some View {
        NavigationStack {
            // La vista ahora depende de si hay equipos o no
            if equipos.isEmpty {
                // Mensaje si el usuario no seleccionó o saltó el paso
                VStack(spacing: 10) {
                    Image(systemName: "shield.slash.fill")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No has seleccionado equipos")
                        .font(.headline)
                    Text("Ve a tu Perfil para elegir tus equipos favoritos.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .navigationTitle("Home")
            } else {
                // Lista con la información provisional de cada equipo
                List {
                    ForEach(equipos) { equipo in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 15) {
                                Image(systemName: equipo.logoName)
                                    .font(.title)
                                    .foregroundColor(.blue)
                                Text(equipo.nombre)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            
                            Text("INFORMACIÓN PROVISIONAL")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "calendar")
                                Text("Próximo partido: Mañana vs. Rival F.C.")
                            }
                            .font(.subheadline)
                            
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                Text("Último resultado: Victoria 2-1")
                            }
                            .font(.subheadline)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .navigationTitle("Mis Equipos")
            }
        }
    }
}

// Para la previsualización, podemos crear datos de ejemplo
#Preview {
    HomeView(equipos: [
        Equipo(nombre: "Arsenal", logoName: "sportscourt.fill"),
        Equipo(nombre: "Chelsea", logoName: "crown.fill")
    ])
}
