cask "qobuz-now-playing" do
  arch arm: "arm64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "e4d6239433d7a1b3010a1e06da097e5232c666c285ec921dc8d2442c0e2bc60e",
         intel: "b1144690362173fc5a05c7552e12655232ad64d2eb8ce03133fb81597914ba6e"

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
