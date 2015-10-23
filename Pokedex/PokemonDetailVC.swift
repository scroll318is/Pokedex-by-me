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
        currnetEvolutionImage.image = mainImage.image
        updateUi()
        
        pokemon.downloadPokemonDetails({
            self.updateUi()
        })
    }
    
    func updateUi() {
        descriptionLbl.text = pokemon.description
        defenceLbl.text = pokemon.defence
        typeLbl.text = pokemon.type
        heightLbl.text = pokemon.type
        pokedexIdLbl.text = pokemon.pokedexId
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            nextEvolutionImage.hidden = true
            nextEvolutionLbl.text = "No Evolution"
        } else {
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution:" + pokemon.nextEvolutionTxt
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL " + pokemon.nextEvolutionLvl
            }
        }
        
    }
    
    @IBAction func backBtnTap(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
