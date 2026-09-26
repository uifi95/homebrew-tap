cask "qobuz-now-playing" do
  arch arm: "arm64", intel: "x64"

  version "1.1.1"
  sha256 arm:   "c53bf4f63a4305d8dc3214beb814c09ac815e0d7e5e8a5791053f484129c26bc",
         intel: "f757eb49da8347c3fc1ec1ce227e62190ab7e4530f5d4b8fd55bc34915e2e753"

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
