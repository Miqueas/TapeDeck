import gintro/[gtk4, adw, gobject, gio]
import mpdclient

const appID = "io.github.Miqueas.TapeDeck"
var playerThread: Thread[void]

proc playerThreadProc {.thread.} =
  let client = newMPDClient()

  while client.idle(subPlayer) == subPlayer:
    echo "E"

proc onStartup(self: adw.Application) =
  let
    win = adw.newApplicationWindow(self)
    mainBox = newBox(Orientation.vertical, 4)
    titleLabel = newLabel(cstring("Tape Deck"))
    artistLabel = newLabel(cstring("The MPD client for GNOME"))
    timeSliderAdjustment = newAdjustment(cdouble(0), cdouble(1), cdouble(100), cdouble(5), cdouble(10))
    timeSlider = newScale(Orientation.horizontal, timeSliderAdjustment)
    playbackPrevButton = newButtonFromIconName(cstring("media-skip-backward-symbolic"))
    playbackPlayButton = newButtonFromIconName(cstring("media-playback-start-symbolic"))
    playbackPlayButtonIcon = playbackPlayButton.getChild()
    playbackNextButton = newButtonFromIconName(cstring("media-skip-forward-symbolic"))
    playbackButtonsBox = newBox(Orientation.horizontal, 8)

  timeSlider.setSizeRequest(256, 0)

  playbackPrevButton.valign = Align.center
  playbackPrevButton.getChild().setMargin(8)
  playbackPrevButton.addCssClass(cstring("circular"))

  playbackPlayButtonIcon.setMargin(16)
  playbackPlayButton.addCssClass(cstring("suggested-action"))
  playbackPlayButton.addCssClass(cstring("circular"))

  playbackNextButton.valign = Align.center
  playbackNextButton.getChild().setMargin(8)
  playbackNextButton.addCssClass(cstring("circular"))

  playbackButtonsBox.halign = Align.center
  playbackButtonsBox.append(playbackPrevButton)
  playbackButtonsBox.append(playbackPlayButton)
  playbackButtonsBox.append(playbackNextButton)
  
  titleLabel.addCssClass(cstring("title-1"))

  mainBox.valign = Align.center
  mainBox.halign = Align.center
  mainBox.setMargin(10)
  mainBox.append(titleLabel)
  mainBox.append(artistLabel)
  mainBox.append(timeSlider)
  mainBox.append(playbackButtonsBox)

  win.content = mainBox
  win.setDefaultSize(400, 300)

  playerThread.createThread(playerThreadProc)

proc onActivate(self: adw.Application) =
  let win = self.activeWindow()
  win.present()

proc onShutdown(self: adw.Application) =
  echo "Shutting down!"

let app = adw.newApplication(appID, ApplicationFlagsDefaultFlags)
app.connect("startup", onStartup)
app.connect("activate", onActivate)
app.connect("shutdown", onShutdown)

discard app.run()