//
//  MovieDetailsService.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 27.01.2023.
//

import Foundation
import UIKit
import Alamofire

class AlamofireNetworkService {
    
    private let API_KEY = "e516e695b99f3043f08979ed2241b3db"
    
    static let shared = AlamofireNetworkService()
    // без юрл компонентов и сессии не сделать запрос
    
    private lazy var baseUrl: String = {
        return "https://api.themoviedb.org"
    }()
    
    private let session: Session
    
    private init() {
        session = Session()
    }
    
    func loadGenres(completion: @escaping ([Genre]) -> Void?) {
        
        let url = baseUrl + "/3/genre/movie/list"
        let parameters: Parameters = ["api_key": API_KEY]
        session.request(url, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let genresEntity = try JSONDecoder().decode(GenresEntity.self, from: data)
                    completion(genresEntity.genres)
                } catch {
                    completion([])
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion([])
            }
        }
    }
    
    func loadMovieListToday(completion: @escaping ([Movie]) -> Void) {
        loadMovieList(path: "/3/movie/now_playing") { movies in
            completion(movies)
        }
    }
    
    func loadMovieListTrending(completion: @escaping ([Movie]) -> Void) {
        loadMovieList(path: "/3/trending/movie/week") { movies in
            completion(movies)
        }
    }
    
    func loadMovieListSoon(completion: @escaping ([Movie]) -> Void) {
        loadMovieList(path: "/3/movie/upcoming") { movies in
            completion(movies)
        }
    }
    
    func loadMovieList(path: String, completion: @escaping ([Movie]) -> Void) {
        let url = baseUrl + path
        let parameters: Parameters = ["api_key": API_KEY]
        session.request(url, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let moviesEntity = try
                    JSONDecoder().decode(MoviesEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(moviesEntity.results)
                    }
                } catch {
                    completion([])
                }
            case .failure(let error ):
                print("Error: \(error)")
                completion([])
            }
        }
    }
    
    func loadCastDetails(with id: Int, completion: (([CastDetailEntity]) -> (Void))?) {
        let url = self.baseUrl + "/3/person/\(id)"
        let parameters: Parameters = ["api_key": self.API_KEY]
        self.session.request(url, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let actor = try decoder.decode(CastDetailEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion?([actor])
                    }
                } catch {
                    print("error")
                }
            case .failure(let error ):
                print("Error: \(error)")
            }
        }
    }
    func getMovieDetails(
        with id: Int,
        completion: (([MovieDetailsResponse]) -> (Void))?
    ) {
        let url = self.baseUrl + "/3/movie/\(id)"
        let parameters: Parameters = ["api_key": self.API_KEY]
        self.session.request(url, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                //            парсим здесь
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let movieDetailResponse = try
                    decoder.decode(MovieDetailsResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion?([movieDetailResponse])
                    }
                } catch {
                    print("неудалось распарсить JSON")
                }
            case .failure(_):
                print("error")
            }
        }
    }
    
    func getMovieCredits(with id: Int, completion: (([Actors]) -> (Void))?)  {
        let url = self.baseUrl + "/3/movie/\(id)/credits"
        let parameters: Parameters = ["api_key": self.API_KEY]
        self.session.request(url, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                //            парсим здесь
                do {
                    let castEntity = try
                    JSONDecoder().decode(CastEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion?(castEntity.cast)
                    }
                } catch {
                    completion?([])
                }
            case .failure(_):
                print("error")
            }
        }
    }
}

