import XCTest
@testable import worldcup // Importa tu app para poder acceder a su código

final class worldcupTests: XCTestCase {

    // Test para nuestra lógica de filtro
    func testFiltradoDeEquipos() throws {
        // 1. Given (Dado): Preparamos nuestros datos de prueba
        let equiposDePrueba = [
            Equipo(nombre: "Argentina", nombreBandera: "argentina", descripcion: "", proximoPartido: "", ultimoResultado: ""),
            Equipo(nombre: "Brasil", nombreBandera: "brasil", descripcion: "", proximoPartido: "", ultimoResultado: ""),
            Equipo(nombre: "Paraguay", nombreBandera: "paraguay", descripcion: "", proximoPartido: "", ultimoResultado: "")
        ]

        // 2. When (Cuando): Ejecutamos la lógica que queremos probar
        let resultado1 = filtrarEquipos(equipos: equiposDePrueba, conTexto: "guay")
        let resultado2 = filtrarEquipos(equipos: equiposDePrueba, conTexto: "Brasil")
        let resultado3 = filtrarEquipos(equipos: equiposDePrueba, conTexto: "")
        let resultado4 = filtrarEquipos(equipos: equiposDePrueba, conTexto: "México")
        
        // 3. Then (Entonces): Verificamos que los resultados son los esperados
        XCTAssertEqual(resultado1.count, 1, "Debería encontrar solo 'Paraguay'")
        XCTAssertEqual(resultado1.first?.nombre, "Paraguay")
        
        XCTAssertEqual(resultado2.count, 1, "Debería encontrar 'Brasil'")
        XCTAssertEqual(resultado2.first?.nombre, "Brasil")
        
        XCTAssertEqual(resultado3.count, 3, "Un texto vacío debería devolver todos los equipos")
        
        XCTAssertEqual(resultado4.count, 0, "No debería encontrar equipos que no están en la lista")
    }
}
