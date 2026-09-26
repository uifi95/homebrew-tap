cask "qobuz-now-playing" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "a2a0ef844bc0062717a834e08e80b96c52ca187da9b5a8521fc8e20af347059b",
         intel: "3e4eb5b2d95cf142e796508f436bbf2177b6b383e492f43db2bb3b877e37a6bc"

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
    So the keyboard's media keys control whatever is playing, not always
    Qobuz, remove Qobuz's Accessibility access, then quit and reopen Qobuz:
      tccutil reset Accessibility com.qobuz.desktop
  EOS
end
