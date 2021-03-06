//
//  QueryService.swift
//  TMDB
//
//  Created by Alex Freitas on 01/07/21.
//

import Foundation

enum NetworkError: Error {
    case unexpectedError
    case decodingError
}

class QueryService {
    private let apiKey = "api_key=" // aqui vai a key do TMDB
    private let defaultSession = URLSession(configuration: .default)

    private func requestConfiguration(for route: String) -> URLRequest {
        let baseURL = "https://api.themoviedb.org/3"
        if let url = URL(string: baseURL + route + apiKey) {
            let request = URLRequest(url: url)
            return request
        } else {
            return URLRequest(url: URL(string: "")!)
        }
    }

    func getPopularMovieList(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        let movieListURL = "/discover/movie?sort_by=popularity.desc&"
        defaultSession.dataTask(with: requestConfiguration(for: movieListURL)) { data, response, error in
            if error != nil {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let movieList = try decoder.decode(MovieList.self, from: data)
                    completion(.success(movieList))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func getNowPlayingMovieList(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        let movieListURL = "/movie/now_playing?"
        defaultSession.dataTask(with: requestConfiguration(for: movieListURL)) { data, response, error in
            if error != nil {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let movieList = try decoder.decode(MovieList.self, from: data)
                    completion(.success(movieList))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }

    func getMovie(movieId: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        let movieURL = "/movie/\(movieId)?"
        defaultSession.dataTask(with: requestConfiguration(for: movieURL)) { data, response, error in
            if error != nil {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(Movie.self, from: data)
                    completion(.success(movie))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }

    func getGenres(completion: @escaping (Result<GenreList, NetworkError>) -> Void) {
        let genreListURL = "/genre/movie/list?language=en-US"
        defaultSession.dataTask(with: requestConfiguration(for: genreListURL)) { data, response, error in
            if error != nil {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let genreList = try decoder.decode(GenreList.self, from: data)
                    completion(.success(genreList))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
