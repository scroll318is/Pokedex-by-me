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
    private var _name = ""
    private var _pokedexId = ""
    private var _description = ""
    private var _type = ""
    private var _defense = ""
    private var _height = ""
    private var _weight = ""
    private var _attack = ""
    private var _nextEvolutionId = ""
    private var _nextEvolutionTxt = ""
    private var _nextEvolutionLvl = ""
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
    
    var nextEvolutionId: String {
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String {
        return _nextEvolutionLvl
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
                        
                        if let attack = dict["attack"] as? Int {
                            self._attack = "\(attack)"
                        }

                        if let defense = dict["defense"] as? Int {
                            self._defense = "\(defense)";
                        }
                        
                        if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                            if let type = types[0]["name"] {
                                self._type = type
                            }
                            
                            if types.count > 1 {
                                
                                for x in 1 ..< types.count {
                                    if let name = types[x]["name"] {
                                        self._type += "/\(name)"
                                    }
                                }
                                
                            }
                        } else {
                            self._type = ""
                        }
                        
                        print(self._weight)
                        print(self._height)
                        print(self._attack)
                        print(self._defense)
                        print(self._type)
                        
                        if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                            
                            if let url = descArr[0]["resource_uri"] {
                                    let nsurl = NSURL(string: URL_BASE + url)!
                                    Alamofire.request(.GET, nsurl).responseJSON
                                            { response in
                                            debugPrint(response)
                                                if let descDict = response.result.value as? Dictionary<String, AnyObject>
                                                {
                                                    if let description = descDict["description"] as? String {
                                                        self._description = description
                                                        print(description.debugDescription)
                                                    }
                                                }
                                                completion()
                                            }

                            }
                            
                        } else {
                            self._description = ""
                        }
                        
                        if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                            
                            if let to = evolutions[0]["to"] as? String {
                                // mega is not found
                                // can't spport mega pokemon right now but still has mega data
                                if to.rangeOfString("mega") == nil {
                                    
                                    if let uri = evolutions[0]["resource_uri"] as? String {
                                        
                                        var newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                        newStr = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                        
                                        self._nextEvolutionId = newStr
                                        self._nextEvolutionTxt = to
                                        
                                        if let lvl = evolutions[0]["level"] as? Int {
                                            self._nextEvolutionLvl = "\(lvl)"
                                        }
                                        
//                                        print("Evo" + self._nextEvolutionTxt)
//                                        print(self._nextEvolutionLvl)
//                                        print(self._nextEvolutionId)
//                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
        }
    }
}
