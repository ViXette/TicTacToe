//
//  ViewController.swift
//  TicTacToe
//
//  Created by VX on 04/09/16.
//  Copyright © 2016 VXette. All rights reserved.
//


// TODO Draw situation

import UIKit

class ViewController: UIViewController {
	var activePlayer = 0 // 0 - nought, 1 - cross
	var gameIsActive = true
	
	var boardState = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
	
	let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
	                           [0, 3, 6], [1, 4, 7], [2, 5, 8],
	                           [0, 4, 8], [2, 4, 6]]
	
	@IBOutlet weak var winner_Label: UILabel!
	@IBOutlet weak var playAgain_Button: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		winner_Label.center = CGPoint(x: winner_Label.center.x - 500, y: winner_Label.center.y)
		playAgain_Button.center = CGPoint(x: playAgain_Button.center.x, y: playAgain_Button.center.y + 500)
	}
	
	@IBAction func cellTapped(_ sender: AnyObject) {
		let selectedPosition = sender.tag - 1
		
		if boardState[selectedPosition] == -1 && gameIsActive {
			boardState[selectedPosition] = activePlayer
			
			if activePlayer == 0 {
				sender.setImage(UIImage(named: "nought.png"), for: [])
				activePlayer = 1
			} else {
				if activePlayer == 1 {
					sender.setImage(UIImage(named: "cross.png"), for: [])
					activePlayer = 0
				}
			}
			
			for combination in winningCombinations {
				if boardState[combination[0]] != -1
				&& boardState[combination[0]] == boardState[combination[1]]
				&& boardState[combination[0]] == boardState[combination[2]] {
					// Winner here
					gameIsActive = false
					
					if boardState[combination[0]] == 0 {
						winner_Label.text = "Noughts has won!"
					} else if boardState[combination[0]] == 1 {
						winner_Label.text = "Crosses has won!"
					}
					
					winner_Label.isHidden = false
					playAgain_Button.isHidden = false
					
					UIView.animate(withDuration: 1, animations: {
						self.winner_Label.center = CGPoint(x: self.winner_Label.center.x + 500,
						                                   y: self.winner_Label.center.y)
						self.playAgain_Button.center = CGPoint(x: self.playAgain_Button.center.x,
						                                       y: self.playAgain_Button.center.y - 500)
					})
					
					break
				}
			}
		}
	}
	
	@IBAction func playAgainTapped(_ sender: AnyObject) {
		activePlayer = 0
		gameIsActive = true
		boardState = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
		
		winner_Label.isHidden = true
		playAgain_Button.isHidden = true
		winner_Label.center = CGPoint(x: winner_Label.center.x - 500, y: winner_Label.center.y)
		playAgain_Button.center = CGPoint(x: playAgain_Button.center.x, y: playAgain_Button.center.y + 500)
		
		for i in 1...9 {
			if let button = view.viewWithTag(i) as? UIButton {
				button.setImage(nil, for: [])
			}
		}
	}
	
}

