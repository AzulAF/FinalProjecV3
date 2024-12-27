//
//  ArtistasService.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 22/12/24.
//

import Foundation

class ArtistasService {
    static let shared = ArtistasService()
    private init() {}
    
    func fetchArtistas(completion: @escaping (Result<[Artista], Error>) -> Void ){
        guard let laurl = URL(string: "https://private-a4ba8-dadmtarea.apiary-mock.com/event/tables") else {
            completion(.failure(NSError(domain: "URL no valida", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: laurl){data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No hay nada en el archivo", code: -1, userInfo: nil)))
                return
            }
            do{
                let artistaResponse = try JSONDecoder().decode(ArtistaResponse.self, from: data)
                completion(.success(artistaResponse.artistasresp))
            } catch {
                completion(.failure(error))
            }
            
            
        }.resume()
    }
    
}
