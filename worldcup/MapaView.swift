import SwiftUI
import MapKit

struct MapaView: View {
    // --- DATOS DE EJEMPLO ---
    let lugares: [LugarTuristico] = [
        .init(nombre: "FIFA Fan Zone", tipo: "Fan Zone", coordenada: .init(latitude: 34.0522, longitude: -118.2437), presupuesto: .bajo),
        .init(nombre: "Reunión de Aficionados", tipo: "Evento", coordenada: .init(latitude: 34.055, longitude: -118.25), presupuesto: .medio),
        .init(nombre: "Restaurante Temático", tipo: "Restaurante", coordenada: .init(latitude: 34.049, longitude: -118.24), presupuesto: .alto)
    ]

    // --- ESTADO DE LA VISTA ---
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var presupuestoSeleccionado: LugarTuristico.Presupuesto? = nil

    var lugaresFiltrados: [LugarTuristico] {
        if let presupuesto = presupuestoSeleccionado {
            return lugares.filter { $0.presupuesto == presupuesto }
        }
        return lugares
    }

    var body: some View {
        ZStack(alignment: .top) {
            // --- MAPA COMPATIBLE ---
            // Usamos la sintaxis anterior que funciona en iOS 15/16
            Map(coordinateRegion: $region, annotationItems: lugaresFiltrados) { lugar in
                MapAnnotation(coordinate: lugar.coordenada) {
                    VStack {
                        Image(systemName: "star.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        Text(lugar.nombre)
                            .font(.caption)
                            .foregroundColor(.primary)
                            .padding(5)
                            .background(.white.opacity(0.8))
                            .cornerRadius(5)
                    }
                }
            }
            .ignoresSafeArea()
            // --- FIN DEL MAPA COMPATIBLE ---

            // El Filtro de Presupuesto (sin cambios)
            VStack {
                Picker("Presupuesto", selection: $presupuestoSeleccionado) {
                    Text("Todos").tag(nil as LugarTuristico.Presupuesto?)
                    ForEach(LugarTuristico.Presupuesto.allCases) { presupuesto in
                        Text(presupuesto.rawValue).tag(presupuesto as LugarTuristico.Presupuesto?)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                .padding()
            }
        }
    }
}

#Preview {
    MapaView()
}
