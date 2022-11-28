//
//  CharacterDetailInteractor.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation

struct Section {
    var season: String
    var episodes: [Episode]
}

class CharacterDetailInteractor: CharacterDetailInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: CharacterDetailInteractorOutputProtocol?
    var localDatamanager: CharacterDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol?

    var episodes: [Episode]?
    var sections: [Section] = [Section]()
    
    func fetchEpisodesData(episodes: [String]) {
        self.remoteDatamanager?.fetchEpisodiesFromService(episodes: episodes)
    }
    
    func changeFormatDate(date: String) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"
        dateFormatter.locale = .init(identifier: "en_US")
        let _date = dateFormatter.date(from: date)
        let localFormatter = DateFormatter()
        localFormatter.dateStyle = .long
        localFormatter.locale = .init(identifier: "es_ES")
        let outputDate = localFormatter.string(from: _date!)
        return outputDate
    }
}

extension CharacterDetailInteractor: CharacterDetailRemoteDataManagerOutputProtocol {
    
    func fetchedEpisodes(apiResponse: Swift.Result<[Episode], Error>) {
        switch apiResponse {
        case .success(let episodes):
            self.episodes = episodes
            
            if let _episodes = self.episodes {
                for var epi in _episodes {
                    
                    let prefix = epi.episode.prefix(3)
                    
                    epi.airDate = self.changeFormatDate(date: epi.airDate)
                    
                    if( self.sections.enumerated().filter({ $0.element.season == prefix }).map({ $0.offset }).count > 0) {
                        if let index = self.sections.enumerated().filter({ $0.element.season == prefix }).map({ $0.offset }).last {
                            self.sections[index].episodes.append(epi)
                        }
                    }
                    else{
                        let newSection = Section(season: String(prefix), episodes: [epi])
                        self.sections.append(newSection)
                    }
                }
            }
            presenter?.fetchedEpisodesSuccess()
        case .failure(let error):
            self.episodes = nil
            presenter?.fetchedEpisodesFailure(error: error)
        }
    }
    
}
