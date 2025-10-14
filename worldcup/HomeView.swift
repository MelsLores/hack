import SwiftUI

struct HomeView: View {
    let equipos: [Equipo]

    var body: some View {
        NavigationStack {
            if equipos.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: Constants.SFSymbols.noEquipos)
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text(Constants.Textos.noEquiposTitulo)
                        .font(.headline)
                    Text(Constants.Textos.noEquiposSubtitulo)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .navigationTitle(Constants.Titulos.homeSinSeleccion)
            } else {
                List(equipos) { equipo in
                    PaisFilaView(equipo: equipo)
                }
                .navigationTitle(Constants.Titulos.homeConSeleccion)
            }
        }
    }
}

#Preview {
    HomeView(equipos: [
        Equipo(nombre: "Argentina", nombreBandera: "argentina",
               descripcion: "La Albiceleste dominó la competencia.",
               proximoPartido: "vs Brasil",
               ultimoResultado: "Empate 0-0"),
        Equipo(nombre: "México", nombreBandera: "mexico",
               descripcion: "El Tri ha albergado el evento más veces.",
               proximoPartido: "vs Estados Unidos",
               ultimoResultado: "Victoria 2-0")
    ])
}
