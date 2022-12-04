//
//  ViewController.swift
//  ActivityKitExample
//
//  Created by Toshiharu Imaeda on 2022/11/30.
//

import UIKit
import ActivityKit
import MyLiveActivity

class ViewController: UIViewController {
    private var activity: Activity<MyWidgetAttributes>?
    private let imageUrl = URL(string: "https://1.bp.blogspot.com/--9Rl2O4BBN0/X-Fct8K5mqI/AAAAAAABdEI/yLOziAqJO34fwn73AolVP0e42A2h-ql1QCNcBGAsYHQ/s992/onepiece06_chopper.png")
    private var imageData: Data?

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var endButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


    @IBAction func didTapStartButton(_ sender: Any) {
        startLiveActivity()
    }

    @IBAction func didTapUpdateButton(_ sender: Any) {
        updateLiveActivity()
    }

    @IBAction func didTapEndButton(_ sender: Any) {
        endLiveActivity()
    }

    private func setup() {
        startButton.isEnabled = false
        updateButton.isEnabled = false
        endButton.isEnabled = false
        
        Task {
            do {
                guard let imageUrl else { return }
                let (data, _) = try await URLSession.shared.data(for: .init(url: imageUrl))
                imageData = data

                startButton.isEnabled = true
                updateButton.isEnabled = true
                endButton.isEnabled = true
            } catch(let e) {
                print(e.localizedDescription)
            }
        }
    }

    private func startLiveActivity() {
        let state = MyWidgetAttributes.ContentState(readPages: 0)
        let attributes = MyWidgetAttributes(thumbnail: imageData)

        do {
            self.activity = try Activity.request(attributes: attributes, contentState: state)
        } catch(let e) {
            print(e.localizedDescription)
        }
    }

    private func updateLiveActivity() {
        // TODO: Code
    }

    private func endLiveActivity() {
        let finalStatus = MyWidgetAttributes.ContentState(readPages: 100)
        Task {
            await activity?.end(using: finalStatus, dismissalPolicy: .default)
        }
    }
}

