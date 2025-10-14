import SwiftUI

struct SeleccionEquiposView: View {
    var alCompletar: ([Equipo]) -> Void

    @State private var equiposSeleccionados: Set<Equipo> = []
    @State private var textoBusqueda: String = ""

    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var equiposFiltrados: [Equipo] {
        // Llama a la función global y testeable
        return filtrarEquipos(equipos: todosLosEquipos, conTexto: textoBusqueda)
    }

    var body: some View {
        ZStack {
            Constants.Colores.fondoPrincipal.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    Button("Saltar") {
                        alCompletar([])
                    }
                    .foregroundColor(.white)
                }

                Text(Constants.Titulos.seleccionEquipos)
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(Constants.Textos.seleccionEquiposSubtitulo)
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
                    alCompletar(Array(equiposSeleccionados))
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
                .foregroundColor(.white)
        }
        .padding(8).frame(width: 100, height: 100)
        .background(Constants.Colores.fondoItem).cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue : Color.clear, lineWidth: 3)
        )
    }
}
