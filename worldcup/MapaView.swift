import SwiftUI
import MapKit

struct MapaView: View {
    // --- LUGAR DESTACADO ---
    // Definimos la ubicación del estadio para usarla fácilmente.
    private let estadioLocation = CLLocationCoordinate2D(latitude: 25.669282467531197, longitude:  -100.2444465605275)

    // --- ESTADO INICIAL DEL MAPA ---
    // Usamos una posición inicial para centrar el mapa en el estadio al abrir.
    @State private var initialPosition: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 25.669282467531197, longitude:  -100.2444465605275),
            distance: 800 // Distancia en metros para el zoom inicial
        )
    )

    // (El resto de tus datos de ejemplo y filtros se quedan igual)
    let lugares: [LugarTuristico] = [
        .init(nombre: "FIFA Fan Zone", tipo: "Fan Zone", coordenada: .init(latitude: 25.675, longitude: -100.25), presupuesto: .bajo),
        .init(nombre: "Restaurante Temático", tipo: "Restaurante", coordenada: .init(latitude: 25.671, longitude: -100.24), presupuesto: .alto)
    ]
    @State private var presupuestoSeleccionado: LugarTuristico.Presupuesto? = nil
    var lugaresFiltrados: [LugarTuristico] {
        if let presupuesto = presupuestoSeleccionado {
            return lugares.filter { $0.presupuesto == presupuesto }
        }
        return lugares
    }

    var body: some View {
        ZStack(alignment: .top) {
            // --- MAPA ACTUALIZADO CON CÍRCULO Y MARCADOR ---
            Map(position: $initialPosition) {
                // 1. Marcador con el nombre del lugar
                Marker("Estadio BBVA", coordinate: estadioLocation)

                // 2. Círculo con un radio de 100 metros
                MapCircle(center: estadioLocation, radius: 200)
                    .stroke(Color.blue, lineWidth: 2) // Borde del círculo
                    .foregroundStyle(Color.blue.opacity(0.3)) // Relleno del círculo

                // Marcadores para los otros lugares turísticos (el filtro sigue funcionando)
                ForEach(lugaresFiltrados) { lugar in
                    Annotation(lugar.nombre, coordinate: lugar.coordenada) {
                        Image(systemName: "star.circle.fill")
                            .font(.title)
                            .foregroundStyle(.red)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }
            .ignoresSafeArea()

            // Filtro de Presupuesto (sin cambios)
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
