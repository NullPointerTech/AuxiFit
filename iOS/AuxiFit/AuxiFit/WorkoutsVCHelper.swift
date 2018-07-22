//
//  WorkoutsVCHelper.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 15/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit
import CoreData

class WorkoutCellItem: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var lastCompleted: String
    @NSManaged var nextWorkout: String
}

class WorkoutCell: UICollectionViewCell {
    var workoutCellItem: WorkoutCellItem? {
        didSet {
            // Add workout name. Since this is first item, we use mutable.
            let workoutName = NSMutableAttributedString(string: (workoutCellItem?.name)!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)])
            let attributedText = workoutName
            // Add last completed date.
            let lastCompString = "\nLast Completed: " + (workoutCellItem?.lastCompleted)!
            let workoutLastComp = NSAttributedString(string: lastCompString, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray])
            attributedText.append(workoutLastComp)
            // Add next workout details.
            let nextWorkoutString = "\nNext Workout: " + (workoutCellItem?.nextWorkout)!
            let workoutNextDet = NSAttributedString(string: nextWorkoutString, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray])
            attributedText.append(workoutNextDet)
            // Set line spacing.
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            //Finally, update workoutInfoLabel and return.
            workoutInfoLabel.attributedText = attributedText
        }
    }

    // Create workout info label.
    let workoutInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setup workout cell views on init.
        setupCellViews()
    }

    // This is required by compiler.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCellViews() {
        backgroundColor = UIColor.white

        // Add to subview hierarchy.
        addSubview(workoutInfoLabel)

        // Put on screen using constraints. 8 pixels from left.
        addConstraintsWithFormat(format: "H:|-8-[v0]|", views: workoutInfoLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: workoutInfoLabel)
    }
}

extension WorkoutsVC {
    func clearData() {
        // Get context from app delegate.
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                let tempWorkoutList = (try(context.fetch(WorkoutCellItem.fetchRequest())) as? [WorkoutCellItem])!
                for workout in tempWorkoutList {
                    context.delete(workout)
                }
                try(context.save())
            } catch let err {
                print(err)
            }
        }
    }

    func setupData() {
        //First clear data.
        clearData()

        // Get context from app delegate.
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

            // Create workout cell items. FIXME: Fetch this from Core Data.
            let currDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy, h:mm a"

            let workoutOne = NSEntityDescription.insertNewObject(forEntityName: "WorkoutCellItem", into: context) as! WorkoutCellItem
            workoutOne.name = "Workout Routine 1"
            workoutOne.lastCompleted = dateFormatter.string(from: currDate)
            workoutOne.nextWorkout = "Shoulders"

            let workoutTwo = NSEntityDescription.insertNewObject(forEntityName: "WorkoutCellItem", into: context) as! WorkoutCellItem
            workoutTwo.name = "Workout Routine 2"
            workoutTwo.lastCompleted = dateFormatter.string(from: currDate)
            workoutTwo.nextWorkout = "Legs"

            // Save the workouts to data.
            do {
                try(context.save())
            } catch let err {
                print(err)
            }

            // Load all data.
            loadData()
        }
    }

    func loadData() {
        // Get context from app delegate.
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                workoutsList = (try(context.fetch(WorkoutCellItem.fetchRequest())) as? [WorkoutCellItem])!
            } catch let err {
                print(err)
            }
        }
    }

    func sequeToCreateWorkout() {
        print ("Clicked CreateWorkout button")
        let createWorkoutVC = CreateWorkoutVC(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(createWorkoutVC, animated: true)
    }
}
