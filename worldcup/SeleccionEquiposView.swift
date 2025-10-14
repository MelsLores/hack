import SwiftUI

struct SeleccionEquiposView: View {
    // La acción ahora envía un array de equipos
    var alCompletar: ([Equipo]) -> Void

    @State private var equiposSeleccionados: Set<Equipo> = []
    @State private var textoBusqueda: String = ""

    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var equiposFiltrados: [Equipo] {
        if textoBusqueda.isEmpty {
            return todosLosEquipos // Usa la lista global
        } else {
            return todosLosEquipos.filter { $0.nombre.localizedCaseInsensitiveContains(textoBusqueda) }
        }
    }

    var body: some View {
        ZStack {
            Color(red: 25/255, green: 38/255, blue: 62/255).ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                // Botón de Saltar
                HStack {
                    Spacer()
                    Button("Saltar") {
                        alCompletar([]) // Llama a la acción de completar con una lista vacía
                    }
                    .foregroundColor(.white)
                }

                Text("Elige los equipos que quieres seguir")
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Consigue un acceso más rápido a las noticias, a los próximos partidos y mucho más.")
                    .foregroundColor(.gray)

                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("", text: $textoBusqueda, prompt: Text("Buscar equipos").foregroundColor(.gray))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 8)
                .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)

                Text("Equipos en la competición")
                    .font(.headline).fontWeight(.bold).foregroundColor(.white).padding(.top)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(equiposFiltrados) { equipo in
                            EquipoItemView(
                                equipo: equipo,
                                isSelected: equiposSeleccionados.contains(equipo)
                            )
                            .onTapGesture {
                                if equiposSeleccionados.contains(equipo) {
                                    equiposSeleccionados.remove(equipo)
                                } else {
                                    equiposSeleccionados.insert(equipo)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    alCompletar(Array(equiposSeleccionados)) // La acción del botón ahora envía los datos
                }) {
                    Text("Continuar")
                        .font(.headline).frame(maxWidth: .infinity).padding()
                        .background(equiposSeleccionados.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white).cornerRadius(12)
                }
                .disabled(equiposSeleccionados.isEmpty)
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

// Vista para un solo equipo en la cuadrícula
struct EquipoItemView: View {
    let equipo: Equipo
    var isSelected: Bool

    var body: some View {
        VStack {
            // --- LÍNEA MODIFICADA ---
            // Antes: Image(systemName: equipo.logoName)
            // Ahora busca la imagen en tus Assets
            Image(equipo.nombreBandera)
                .resizable() // Hace que la imagen se pueda redimensionar
                .aspectRatio(contentMode: .fit) // Mantiene la proporción
                .clipShape(Circle()) // Opcional: la hace redonda
                .frame(width: 50, height: 40) // Ajusta el tamaño
                .padding(.bottom, 5)
            // --- FIN DE LA MODIFICACIÓN ---

            Text(equipo.nombre)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .foregroundColor(.white)
        }
        .padding(8).frame(width: 100, height: 100)
        .background(Color(red: 43/255, green: 56/255, blue: 82/255)).cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue : Color.clear, lineWidth: 3)
        )
    }
}
