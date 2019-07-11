//
//  ViewController.swift
//  ResumeApp
//
//  Created by Satish Birajdar on 2019-07-10.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var displayTextView: UITextView!
    @IBOutlet weak var sectionsSegmentControl: UISegmentedControl!
    
    // MARK: Class members
    var viewModel : HomeViewModel?
    
    // Trigger once Candidate details value is changed
    var candidateDetails: [Biodata]? {
        didSet {
            guard let candidateDetails = candidateDetails else { return }
            viewModel = HomeViewModel.init(candidDetail: candidateDetails)
            DispatchQueue.main.async {
                self.mainView.isUserInteractionEnabled = true
                self.loadingSpinner.stopAnimating()
                self.updateViewData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCandidateDetails()
        self.mainView.isUserInteractionEnabled = false
        self.loadingSpinner.startAnimating()
    }
    
    func getCandidateDetails(){
        // Request for candidate detail
        APIManager.sharedInstance.getBiodata { (candidateDetail, error) in
            if let error = error {
                print("Get candidate detail request error: \(error.localizedDescription)")
                return
            }
            guard let candidateDetail = candidateDetail  else { return }
            self.candidateDetails = candidateDetail
        }
    }
    
    func updateViewData(){
        guard let candidDetails = self.candidateDetails else {
            print("Candidate detail is null")
            return
        }
        self.nameLabel.text = candidDetails.first?.name
        self.contactLabel.text = candidDetails.first?.contactDetails
        self.displayTextView.text = candidDetails.first?.professionalSummary
    }
    
    // Segment control clicked function
    @IBAction func sectionSelectionClicked(_ sender: UISegmentedControl) {
        guard let candidateDetails = self.candidateDetails else {
            print("Candidate details is null")
            return
        }
        
        if sender.selectedSegmentIndex == 0 {               // Summary segment clicked
            guard let summary = candidateDetails.first?.professionalSummary else {
                print("Candidate summary is null")
                return
            }
            self.displayTextView.text = summary
        } else if sender.selectedSegmentIndex == 1 {        // Skills segment clicked
            guard let skills = candidateDetails.first?.skills else {
                print("Candidate skills is null")
                return
            }
            self.displayTextView.text = skills
        } else {                                            // Experience segment clicked
            guard let experiences = candidateDetails.first?.experiences else {
                print("Candidate experiences is null")
                return
            }
            var experienceDetailText: String = ""
            for experience in experiences {
                experienceDetailText += " Company Name: \(experience.companyName)\n Role: \(experience.role)\n From: \(experience.from)\n To: \(experience.to)\n Responsibilities:\n"
                for responsibility in experience.responsibilities {
                    experienceDetailText += "   - \(responsibility)\n"
                }
                experienceDetailText += "Achievements: \(experience.achievements)\n\n"
            }
            
            self.displayTextView.text = experienceDetailText
        }
    }
}

