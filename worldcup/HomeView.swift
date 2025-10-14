import SwiftUI

struct HomeView: View {
    let equipos: [Equipo]

    var body: some View {
        NavigationStack {
            if equipos.isEmpty {
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
                // --- VISTA ACTUALIZADA ---
                List(equipos) { equipo in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 15) {
                            Image(equipo.nombreBandera)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 25)
                            
                            Text(equipo.nombre)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        // Muestra la descripción específica del equipo
                        Text(equipo.descripcion)
                            .font(.body)
                            .padding(.bottom, 5)
                        
                        // Muestra el próximo partido específico
                        HStack {
                            Image(systemName: "calendar")
                            Text("Próximo partido: \(equipo.proximoPartido)")
                        }
                        .font(.subheadline)
                        
                        // Muestra el último resultado específico
                        HStack {
                            Image(systemName: "chart.bar.fill")
                            Text("Último resultado: \(equipo.ultimoResultado)")
                        }
                        .font(.subheadline)
                    }
                    .padding(.vertical, 10)
                }
                .navigationTitle("Mis Países")
            }
        }
    }
}


// --- #PREVIEW ACTUALIZADO ---
// El preview ahora necesita los nuevos campos para funcionar
#Preview {
    HomeView(equipos: [
        Equipo(nombre: "Argentina", nombreBandera: "argentina",
               descripcion: "La Albiceleste dominó la competencia y logró su pasaje cuatro jornadas antes del final.",
               proximoPartido: "vs Brasil",
               ultimoResultado: "Empate 0-0"),
        Equipo(nombre: "México", nombreBandera: "mexico",
               descripcion: "El Tri ha albergado el evento más veces que cualquier otro país.",
               proximoPartido: "vs Estados Unidos",
               ultimoResultado: "Victoria 2-0")
    ])
}
