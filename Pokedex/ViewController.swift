//
//  ViewController.swift
//  Pokedex
//
//  Created by Stoyan Yordanov Kostov on 10/19/15.
//  Copyright © 2015 com.kostov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicBtn: UIButton!
  
    let MUSIC_BTN_REDUCED_ALPHA = 0.5 as CGFloat
    
    var pokemons = [Pokemon]()
    var filterdPokemons = [Pokemon]()
    var isInSearchMode = false

    var musicPlayer: AVAudioPlayer!
    
    var playing: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("MPPlaying")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .Done
        parsePokemonCSV()
        initMusicPlayer()
    }
    
    func initMusicPlayer()
    {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            if playing {
                musicPlayer.play()
            } else {
                musicBtn.alpha = MUSIC_BTN_REDUCED_ALPHA
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV()
    {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")
        
        do {
            let csvParser = try CSV(contentsOfURL:path!)
            let rows = csvParser.rows
        
            for row in rows {
                if let pokename = row["identifier"], let pokeId = Int(row["id"]!) {
                    let pokemon = Pokemon(name: pokename, pokedexId: pokeId)
                    pokemons.append(pokemon)
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func onMusicPlayerTap(sender: UIButton)
    {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = MUSIC_BTN_REDUCED_ALPHA
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
        NSUserDefaults.standardUserDefaults().setBool(musicPlayer.playing, forKey: "MPPlaying")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            if isInSearchMode {
               pokemon = filterdPokemons[indexPath.row]
            } else {
               pokemon = pokemons[indexPath.row]
            }
            
            cell.configureCell(pokemon)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            isInSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filterdPokemons = pokemons.filter({ $0.name.rangeOfString(lower) != nil })
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if isInSearchMode {
            return filterdPokemons.count
        }
        return pokemons.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
          return CGSizeMake(105, 105)
    }
    
}

