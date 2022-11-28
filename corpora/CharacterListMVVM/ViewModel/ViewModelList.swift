//
//  ViewModelList.swift
//  corpora
//
//  Created by David Ortego Lucas on 19/11/22.
//

import Foundation

class ViewModelList {
    
    var refreshData = { () -> () in }
    
    var dataArray: [Result] = [] {
        didSet {
            refreshData()
        }
    }
    
    var filtering : String?
    var totalData : CharacterResponse?
    
    func retrieveData(nextPage: Bool?) {
            
        let _nextPage = self.getNext(value: nextPage)
    
        let nService = NativeURLSessionNetworkService()
        
        NetWorkManager.init(wbs: nService).apiCall_GetCharacters(next: _nextPage, filter: nil, query: nil) { [weak self] result in
            switch (result)
            {
            case .success(let response):
                
                if (_nextPage != nil) == true {
                    self?.totalData?.info = response.info
                    self?.totalData?.results.append(contentsOf: response.results)
                    if( self?.filtering != nil)
                    {
                        self?.filterData(title: self?.filtering)
                    }
                    else
                    {
                        self?.dataArray.append(contentsOf: response.results)
                    }
                }
                else
                {
                    self?.totalData = response
                    self?.dataArray = response.results
                }
                
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNext(value: Bool?) -> String? {
        guard value != nil else {
            return nil
        }
        return totalData?.info.next
    }
    
    func viewNeedMoreCharacters(index: Int)
    {
        let count = dataArray.count
        if(count != 0)
        {
            if (index == count - 1 ) {
                self.retrieveData(nextPage: true)
            }
        }
    }
    
    func filterData(title: String?)
    {
        self.filtering =  (self.filtering == title) ? nil : title
        
        switch self.filtering
        {
            case "Vivo":
            self.dataArray = (totalData?.results.filter{ $0.status == "Alive" })!
            break
            case "Muerto":
            self.dataArray = (totalData?.results.filter{ $0.status == "Dead" })!
            break
            case "Desconocido":
            self.dataArray = (totalData?.results.filter{ $0.status == "unknown" })!
            break
            default:
            self.dataArray = totalData!.results
        }
    }
}
