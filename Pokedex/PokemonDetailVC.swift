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

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.blueColor()
        activityIndicator.startAnimating()
        
        let greyView = UIView(frame: view.bounds)
        greyView.backgroundColor = UIColor.blackColor()
        greyView.alpha = 0.4
        
        greyView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint_top    = NSLayoutConstraint(item: greyView, attribute: .Top,      relatedBy: .Equal, toItem: view, attribute: .Top,      multiplier: 1.0, constant: 0)
        let constraint_bottom = NSLayoutConstraint(item: greyView, attribute: .Bottom,   relatedBy: .Equal, toItem: view, attribute: .Bottom,   multiplier: 1.0, constant: 0)
        let constraint_left   = NSLayoutConstraint(item: greyView, attribute: .Leading,  relatedBy: .Equal, toItem: view, attribute: .Leading,  multiplier: 1.0, constant: 0)
        let constraint_right  = NSLayoutConstraint(item: greyView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        let activity_horizontal_center = NSLayoutConstraint(item: activityIndicator, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let  activity_vertical_center = NSLayoutConstraint(item: activityIndicator, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        view.addSubview(greyView)
        view.addSubview(activityIndicator)
        
        view.addConstraint(constraint_top)
        view.addConstraint(constraint_bottom)
        view.addConstraint(constraint_left)
        view.addConstraint(constraint_right)
        
        view.addConstraint(activity_horizontal_center)
        view.addConstraint(activity_vertical_center)
        
        pokemon.downloadPokemonDetails({
            greyView.removeFromSuperview()
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
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
