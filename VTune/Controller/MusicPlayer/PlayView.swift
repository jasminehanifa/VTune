//
//  PlayView.swift
//  VTune
//
//  Created by Stefani Kurnia Permata Dewi on 07/11/19.
//  Copyright © 2019 Jasmine Hanifa Mounir. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
//
//protocol GetDataDelegate{
//    func getData()
//}


class PlayView: UIView {


    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeDuration: UILabel!
    @IBOutlet var currentTime: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnShuffle: UIButton!
    @IBOutlet weak var btnRepeat: UIButton!
    @IBOutlet weak var btnVibrateOutlet: UIButton!
    @IBOutlet weak var btnLirikOutlet: UIButton!
    
    var lirik = true
    var delegate: GetLyricDelegate?
    var vc: MusicPlayerViewController?
    var referenceHeaderView: MusicPlayerHeader?
    var referenceAlbumImageView: MusicPlayerAlbumImage?
//    var getDataDelegate: GetDataDelegate?
//    let transferSender:UIButton
    func getData(){
        if let nowPlaying = mediaPlayer.nowPlayingItem{
            var duration = MPTotalDuration?.text
            MPSongTitle?.text = nowPlaying.title!
            MPSongSinger?.text = nowPlaying.artist!
            duration = String(Int(nowPlaying.playbackDuration))
            MPAlbumImage!.image = nowPlaying.artwork?.image(at: CGSize(width: (MPAlbumImage!.frame.width), height: (MPAlbumImage!.frame.height)))
                referenceHeaderView?.nowPlayingSongTitle.text = MPSongTitle?.text
                referenceHeaderView?.nowPlayingSinger.text = MPSongSinger?.text
            referenceAlbumImageView?.nowPlayingAlbumImage.image = MPAlbumImage?.image
            let minutes = Int(duration!)!/60
            let seconds = Int(duration!)! - minutes * 60
            timeDuration.text = String(format: "%02d:%02d", minutes,seconds) as String
            print("Fungsi getData() Berhasil")
        }
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        if AudioUtilities.audioRunning{
            btnPlay.setImage(#imageLiteral(resourceName: "Play Button (Big)"), for: .normal)
            AudioUtilities.pauseAudio()
            //mediaPlayer.pause()
        }else{
            btnPlay.setImage(#imageLiteral(resourceName: "Pause Button (Big)"), for: .normal)
            AudioUtilities.pauseAudio()
            //mediaPlayer.play()
        }
    }

    @IBAction func btnNext(_ sender: Any) {
        mediaPlayer.skipToNextItem()
        mediaPlayer.stop()
        getData()
        mediaPlayer.play()
    }

    @IBAction func btnPrevious(_ sender: Any) {
        mediaPlayer.skipToPreviousItem()
        mediaPlayer.stop()
        getData()
        mediaPlayer.play()
    }
    
    
    @IBAction func btnRepeat(_ sender: Any) {
        
    }
    
    
    @IBAction func btnShuffle(_ sender: Any) {
        
    }
    
    @IBAction func btnVibrate(_ sender: Any) {
        if btnVibrateOutlet.currentImage == #imageLiteral(resourceName: "Vibrate Button On"){
            btnVibrateOutlet.setImage(#imageLiteral(resourceName: "Vibrate Button Off"), for: .normal)
        }else{
            btnVibrateOutlet.setImage(#imageLiteral(resourceName: "Vibrate Button On"), for: .normal)
        }
    }

    @IBAction func btnLirik(_ sender: UIButton) {
        delegate?.getLyric(sender: sender)
    }
    
    @IBAction func sliderValueChange(_ sender: Any) {
        mediaPlayer.currentPlaybackTime = TimeInterval(timeSlider.value)
    }
    
    @IBAction func sliderVolume(_ sender: UISlider) {
    }
    
}

extension MPVolumeView {
    static func setVolume(_ volume: Float){
        let volumeView = MPVolumeView()
        let volumeSlider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
    volumeSlider?.value = volume;
        }
    }
}
