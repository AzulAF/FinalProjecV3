//
//  Artist.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//

import Foundation

struct ArtistaResponse: Decodable{
    let artistasresp: [Artista]
}

struct Artista: Decodable {
    let id: String
    let mesa: String
    let piso: String
    let nombre: String
    let sellos: String
    let pagoefectivo: String
    let pagotarjeta: String
    let pagootro: String
    let imagen: String
    let descripcion: String
    let catalogo: String
    let tags: String
}
