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

    on playTrack:trackId userId:theUserId playlistId: thePlaylistId
        tell application "Spotify"
            play track "spotify:track:" & trackId in context "spotify:user:" & theUserId & ":playlist:" & thePlaylistId
        end tell
    end playTrack:playlist:

end script
