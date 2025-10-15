import SwiftUI

struct SeleccionEquiposView: View {
    var alCompletar: ([Equipo]) -> Void

    @State private var equiposSeleccionados: Set<Equipo> = []
    @State private var textoBusqueda: String = ""

    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var equiposFiltrados: [Equipo] {
        return filtrarEquipos(equipos: todosLosEquipos, conTexto: textoBusqueda)
    }

    var body: some View {
        ZStack {
            // Usa el color de fondo del tema
            Color.theme.mainBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    Button("Saltar") {
                        alCompletar([])
                    }
                    // Usa el color de texto primario del tema
                    .foregroundColor(Color.theme.primaryText)
                }

                Text(Constants.Titulos.seleccionEquipos)
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(Color.theme.primaryText)
            
                Text(Constants.Textos.seleccionEquiposSubtitulo)
                    // Usa el color de texto secundario del tema
                    .foregroundColor(Color.theme.secondaryText)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.theme.secondaryText)
                    
                    TextField("", text: $textoBusqueda, prompt: Text("Buscar equipos").foregroundColor(Color.theme.secondaryText))
                        .foregroundColor(Color.theme.primaryText)
                }
                .padding(.bottom, 8)
                .overlay(Rectangle().frame(height: 1).foregroundColor(Color.theme.secondaryText), alignment: .bottom)

                Text("Equipos en la competición")
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.theme.primaryText).padding(.top)

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
                    alCompletar(Array(equiposSeleccionados))
                }) {
                    Text("Continuar")
                        .font(.headline).frame(maxWidth: .infinity).padding()
                        .background(equiposSeleccionados.isEmpty ? Color.theme.secondaryText : Color.theme.primaryAccent)
                        .foregroundColor(.white) // El texto del botón suele ser blanco
                        .cornerRadius(12)
                }
                .disabled(equiposSeleccionados.isEmpty)
            }
            .padding()
        }
        // Se elimina .preferredColorScheme(.dark) para que la vista sea adaptable
    }
}

struct EquipoItemView: View {
    let equipo: Equipo
    var isSelected: Bool

    var body: some View {
        VStack {
            Image(equipo.nombreBandera)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 50, height: 40)
                .padding(.bottom, 5)

            Text(equipo.nombre)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .foregroundColor(Color.theme.primaryText)
        }
        .padding(8).frame(width: 100, height: 100)
        .background(Color.theme.cardBackground) // Usa el color de tarjeta del tema
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.theme.primaryAccent : Color.clear, lineWidth: 3) // Usa el color de acento
        )
    }
}
