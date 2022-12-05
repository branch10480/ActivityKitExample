//
//  ViewController.swift
//  ActivityKitExample
//
//  Created by Toshiharu Imaeda on 2022/11/30.
//

import UIKit
import ActivityKit
import DataModule
import ImageCroppingKit

class ViewController: UIViewController {
    private var activity: Activity<MyWidgetAttributes>?
    private let imageUrl = URL(string: "https://blogger.googleusercontent.com/img/a/AVvXsEgM85LEvtgJrUmGx95tmMptVQWhITwGOun2FEdThRoHM1iA2IV7J9KA94UtTJco4GVIvitht8kY-nc9U6SBQ6oLlsGCLSlr2S0dv9m04sUFE_suAa77Z8V-HxOFVxSsPMEqRgGGlC0ilOpb-a_tAjkvTr_ux8GfLjdCFWkj8HVQ-kGVukNz9WfrQ9_s1g=s623")
    private var imageFileName: String?

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

                // 画像をリサイズする
                let originalImage = UIImage(data: data)
                let resizedImage = originalImage?.resized(maxLength: 64)

                // TODO: ローカルに画像ファイルを保存して、そのパスを Activity として渡す
                guard var path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.me.toshi-sv.ActivityKitExample") else { return }
                let fileName = "thumbnail"
                path = path.appending(path: fileName)
                print("path:", path.absoluteString)

                guard let data = resizedImage?.jpegData(compressionQuality: 0.8) else { return }
                try data.write(to: path)
                self.imageFileName = fileName

                startButton.isEnabled = true
                updateButton.isEnabled = true
                endButton.isEnabled = true
            } catch(let e) {
                print(e.localizedDescription)
            }
        }
    }

    private func startLiveActivity() {
        guard let imageFileName else { return }

        let state = MyWidgetAttributes.ContentState(readPages: 0)
        let attributes = MyWidgetAttributes(thumbnail: imageFileName)

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

