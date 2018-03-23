//
//  PlayMusicScreenViewController.swift
//  M4C
//
//  Created by Kalpesh Satasiya on 21/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit
import SWRevealViewController
import AVFoundation
import MediaPlayer

class PlayMusicScreenViewController: UIViewController, SWRevealViewControllerDelegate, AVAudioPlayerDelegate {
    
    
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnSearch: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    var dictMusicDetail = NSDictionary()
    
    
    @IBOutlet var btnPrevious: UIButton!
    @IBOutlet var btnPlayAndPaush: UIButton!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnTipsNovaction: UIButton!
    @IBOutlet var btnShare: UIButton!
    @IBOutlet var btnWorld: UIButton!
    
    @IBOutlet var MusicProgress: UISlider!
    @IBOutlet var volumeProgress: UISlider!
    
    @IBOutlet var imgBackground: UIImageView!
    @IBOutlet var imgFront: UIImageView!
    @IBOutlet var imgMusic: UIImageView!
    
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblDesciption: UILabel!
    @IBOutlet var lblTitleMusic: UILabel!
    
    @IBOutlet var txtSearch: CustomTextField!
    
    
     var isSearched : Bool! = false
    var audioPlayer:AVAudioPlayer! = nil
    var currentAudio = ""
    var currentAudioPath:URL!
    var audioList:NSArray!
    var currentAudioIndex = 0
    var audioLength = 0.0
    var toggle = true
    var timer:Timer!
    var finalImage:UIImage!
    var shuffleState = false
    var shuffleArray = [Int]()
      let commanUntil = CommanUntil()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(dictMusicDetail)
        setScreenLayOut()
        fillMusicDetail()
        prepareAudio()
    }
    
    func leftSilder() {
        
        
        if self.revealViewController() != nil {
            
            self.revealViewController().delegate = self
            btnMenu.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)) , for:.touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func setScreenLayOut()  {
        btnShare.layer.cornerRadius = 0.5 * btnShare.bounds.size.width
        btnWorld.layer.cornerRadius = 0.5 * btnWorld.bounds.size.width
        commanUntil .ButtonCornerRedious(button: btnTipsNovaction)
    }
    
    
    func fillMusicDetail()  {
        if let url  = dictMusicDetail.value(forKey: "image_url") as? String
        {
            loadImageWithURL(url: url, view: (imgBackground)!)
            loadImageWithURL(url: url, view: (imgFront)!)
             loadImageWithURL(url: url, view: (imgMusic)!)
        }
        
        if let title  = dictMusicDetail.value(forKey: "title") as? String
        {
            lblTitle.text = title;
            lblTitleMusic.text = title;
        }
        
        if dictMusicDetail.value(forKey: "target") != nil ,dictMusicDetail.value(forKey: "tip") != nil
        {
            let str = "$\(setcurrencyWithoutSymbol(price: "\(dictMusicDetail.value(forKey: "tip")!)")) in Tips"
            let attributedString = NSMutableAttributedString(string:str)
            let range = (str as NSString).range(of: "$\(setcurrencyWithoutSymbol(price: "\(dictMusicDetail.value(forKey: "tip")!)"))")
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.hexa("3ba250", alpha: 1.0), range: range)
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "HelveticaNeue-Bold", size: 23)!, range: range)
            
            lblAmount.attributedText = attributedString;
            
        }
        
        if dictMusicDetail.value(forKey: "charity_name") != nil
        {
            let str = "$\(setcurrencyWithoutSymbol(price: "\(dictMusicDetail.value(forKey: "tip")!)")) PLEDGE TO \(dictMusicDetail.value(forKey: "charity_name")!)."
            let attributedString = NSMutableAttributedString(string:str)
            let range = (str as NSString).range(of: "$\(setcurrencyWithoutSymbol(price: "\(dictMusicDetail.value(forKey: "tip")!)"))")
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.hexa("ef3644", alpha: 1.0), range: range)
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "HelveticaNeue-Bold", size: 13)!, range: range)
            
            lblDesciption.attributedText = attributedString;
            
        }
        else{
            let attributedString = NSMutableAttributedString(string:"")
            lblDesciption.attributedText = attributedString;
        }
        
        setBorderToView(view: (imgFront)!, color: UIColor.white, width: 1)
        setBorderToView(view: (imgMusic)!, color: UIColor.white, width: 1)
    }
    
    // Prepare audio for playing
    func prepareAudio(){
        setCurrentAudioPath()
        do {
            //keep alive audio at background
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
        audioPlayer = try? AVAudioPlayer(contentsOf: currentAudioPath)
        audioPlayer.delegate = self
        audioLength = audioPlayer.duration
        MusicProgress.maximumValue = CFloat(audioPlayer.duration)
        MusicProgress.minimumValue = 0.0
        MusicProgress.value = 0.0
        audioPlayer.prepareToPlay()
//        showTotalSongLength()
        
    }
    
    //Sets audio file URL
    func setCurrentAudioPath(){
        currentAudioPath = URL(fileURLWithPath: Bundle.main.path(forResource: "Baby Be Mine", ofType: "mp3")!)
        print("\(currentAudioPath)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController? .popViewController(animated: true)
        if timer != nil {
            timer.invalidate()
            audioPlayer.pause()
        }
        
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        if isSearched{
            isSearched = false
            self.txtSearch.isHidden = true
            self.txtSearch.text = ""
            self.txtSearch.resignFirstResponder()
            self.btnSearch.setImage(UIImage.init(named: "ic_search"), for: .normal)
        }
        else{
            isSearched = true
            self.txtSearch.isHidden = false
            self.txtSearch.text = ""
            self.txtSearch.becomeFirstResponder()
            self.btnSearch.setImage(UIImage.init(named: "close_white"), for: .normal)
        }
    }
    

    @IBAction func btnPlayAndPause(_ sender: Any) {
        if shuffleState == true {
            shuffleArray.removeAll()
        }
        let play = UIImage(named: "ic_play")
        let pause = UIImage(named: "ic_push")
        if audioPlayer.isPlaying{
            pauseAudioPlayer()
            audioPlayer.isPlaying ? "\(btnPlayAndPaush.setImage( pause, for: UIControlState()))" : "\(btnPlayAndPaush.setImage(play , for: UIControlState()))"
            
        }else{
            playAudio()
            audioPlayer.isPlaying ? "\(btnPlayAndPaush.setImage( pause, for: UIControlState()))" : "\(btnPlayAndPaush.setImage(play , for: UIControlState()))"
        }
    }
    
    @IBAction func btnPrevious(_ sender: Any) {
       
        
    }
    
    @IBAction func Slidermusic(_ sender: UISlider) {
        
        audioPlayer.currentTime = TimeInterval(sender.value)
    }
    
    @IBAction func volumeProgress(_ sender: UISlider) {
        let selectedValue = Float(sender.value)
        audioPlayer.volume = selectedValue
    }
    
    
    //MARK:- Player Controls Methods
    func  playAudio(){
         startTimer()
        audioPlayer.play()
    }
    
    //MARK:-
    
    func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayMusicScreenViewController.update(_:)), userInfo: nil,repeats: true)
            timer.fire()
        }
    }
    
    
    func stopTimer(){
        timer.invalidate()
        
    }
    
    
    @objc func update(_ timer: Timer){
        if !audioPlayer.isPlaying{
            return
        }
//        let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
        MusicProgress.value = CFloat(audioPlayer.currentTime)
        UserDefaults.standard.set(MusicProgress.value , forKey: "playerProgressSliderValue")
        
    }
    
    func calculateTimeFromNSTimeInterval(_ duration:TimeInterval) ->(minute:String, second:String){
        // let hour_   = abs(Int(duration)/3600)
        let minute_ = abs(Int((duration/60).truncatingRemainder(dividingBy: 60)))
        let second_ = abs(Int(duration.truncatingRemainder(dividingBy: 60)))
        
        // var hour = hour_ > 9 ? "\(hour_)" : "0\(hour_)"
        let minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        let second = second_ > 9 ? "\(second_)" : "0\(second_)"
        return (minute,second)
    }

    
    
    func pauseAudioPlayer(){
        audioPlayer.pause()
        
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
    }
    
    @IBAction func btnTipsNovaction(_ sender: Any) {
    }
    
    @IBAction func btnInfo(_ sender: Any) {
    }
    @IBAction func btnShare(_ sender: Any) {
    }
    
}
