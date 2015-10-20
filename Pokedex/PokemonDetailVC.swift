//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Stoyan Yordanov Kostov on 10/20/15.
//  Copyright © 2015 com.kostov. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var pokemonLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var currnetEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonLbl.text = pokemon.name
        mainImage.image = UIImage(named: pokemon.pokedexId)
        
        pokemon.downloadPokemonDetails({
            
        })
    }
    
    @IBAction func backBtnTap(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
