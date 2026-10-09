cask "qobuz-now-playing" do
  arch arm: "arm64", intel: "x64"

  version "1.2.0"
  sha256 arm:   "63133568d7a7c495661e4111ecb3c8e941ef78d90672c2a302a612890cf54b5c",
         intel: "30f20b3157089ee6106119c854e8217bfa23db79904846a52531c1e5be62b849"

  url "https://github.com/uifi95/qobuz-now-playing/releases/download/v#{version}/qobuz-now-playing-#{version}-macos-#{arch}.tar.gz"
  name "Qobuz Now Playing"
  desc "Shows the Qobuz desktop app in macOS Now Playing"
  homepage "https://github.com/uifi95/qobuz-now-playing"

  depends_on macos: :ventura

  # install.sh copies the watcher to ~/.qobuz-nowplaying and starts it as a
  # LaunchAgent; uninstall.sh stops it and removes both.
  installer script: {
    executable: "qobuz-now-playing-#{version}/install.sh",
  }

  uninstall script: {
    executable: "qobuz-now-playing-#{version}/uninstall.sh",
  }

  caveats <<~EOS
    Qobuz Now Playing is running, and starts again at every login.

    One more step, so the keyboard's media keys control whatever is playing
    instead of always Qobuz: remove Qobuz's Accessibility access, then quit
    and reopen Qobuz:
      tccutil reset Accessibility com.qobuz.desktop
      osascript -e 'quit app "Qobuz"'; sleep 3; open -a Qobuz
    When Qobuz asks for Accessibility access again, tick the option to
    not ask again and decline.

    To check it works, open Qobuz. A log line like "bridge: installed"
    means it's connected:
      tail ~/.qobuz-nowplaying/watcher.log
  EOS
end
