import Foundation

struct Equipo: Identifiable, Hashable, Codable {
    let id = UUID()
    let nombre: String
    let logoName: String
}


let todosLosEquipos: [Equipo] = [
    Equipo(nombre: "Arsenal", logoName: "sportscourt.fill"),
    Equipo(nombre: "Atleti", logoName: "flag.fill"),
    Equipo(nombre: "Bayern München", logoName: "shield.fill"),
    Equipo(nombre: "Benfica", logoName: "star.fill"),
    Equipo(nombre: "Chelsea", logoName: "crown.fill"),
    Equipo(nombre: "Juventus", logoName: "bolt.fill"),
    Equipo(nombre: "Man Utd", logoName: "flame.fill"),
    Equipo(nombre: "Paris SG", logoName: "paperplane.fill"),
    Equipo(nombre: "Real Madrid", logoName: "moon.fill"),
]
