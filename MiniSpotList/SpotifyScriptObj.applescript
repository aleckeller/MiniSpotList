script SpotifyScriptObj
    property parent: class "NSObject"

    on getCurrentPlaying()
        set currentlyPlayingTrack to getCurrentlyPlayingTrack()
        return currentlyPlayingTrack
    end getCurrentPlaying

    on getCurrentlyPlayingTrack()
        tell application "Spotify"
            set currentTrack to name of current track as string
            set currentPlay to currentTrack
            return currentTrack
        end tell
    end getCurrentlyPlayingTrack

    on playTrack:trackId
        tell application "Spotify"
            play track "spotify:track:" & trackId
        end tell
    end playTrack

end script
