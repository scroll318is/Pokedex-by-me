//
//  Pokemon.swift
//  Pokedex
//
//  Created by Stoyan Yordanov Kostov on 10/19/15.
//  Copyright © 2015 com.kostov. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: String!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonUrl: String {
        return URL_BASE + URL_POKEMON + _pokedexId + "/"
    }

    var name: String {
        return _name
    }
    
    var pokedexId: String {
        return _pokedexId
    }
    
    var description: String {
        return _description
    }
    
    var type: String {
        return _type
    }
    
    var defence: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var attack: String {
        return _attack
    }
    
    var nextEvolutionTxt: String {
        return _nextEvolutionTxt
    }
    
    init(name: String, pokedexId: String, description: String, type: String, defense: String, height: String, weight: String, attack: String, nextEvolutionTxt: String)
    {
        _name = name
        _pokedexId = pokedexId
        _description = description
        _type = type
        _defense = defense
        _height = height
        _weight = weight
        _attack = attack
        _nextEvolutionTxt = nextEvolutionTxt
        
    }
    
    init(name: String, pokedexId: String)
    {
        _name = name
        _pokedexId = pokedexId
        
    }
    
    func downloadPokemonDetails(completion: DownloadComplete)
    {
        if let url = NSURL(string: _pokemonUrl) {
            Alamofire.request(.GET, url).responseJSON
                { response in
                    debugPrint(response)
                    
                    if let dict = response.result.value as? Dictionary<String, AnyObject> {
                        if let weight = dict["weight"] as? String {
                            self._weight = weight
                        }
                        
                        if let height = dict["height"] as? String {
                            self._height = height
                        }
                        
//                        if let attack = dict["attack"] as? Int {
//                            self._attack = "\("attack"
//                        }
//                        
//                        if let defense = dict["defense"] as? Int {
//                            self._defense = defense
//                        }
//                        
//                        print(self._weight)
//                        print(self._height)
//                        print(self._attack)
//                        print(self._defense)
                    }
                    
                    
                }
        }
    }
    
}
