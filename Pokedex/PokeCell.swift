//
//  PokeCell.swift
//  Pokedex
//
//  Created by Stoyan Yordanov Kostov on 10/19/15.
//  Copyright © 2015 com.kostov. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
