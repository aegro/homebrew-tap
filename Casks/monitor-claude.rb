cask "monitor-claude" do
  version "0.6.1"
  sha256 "c24e57bf401fac10ebcada0ee7a20adbaf1f4b7fd34690e50ca6161c9aa58df4"

  url "https://github.com/aegro/tool-claude-monitor-macos/releases/download/v#{version}/Monitor-Claude-#{version}.zip"
  name "Monitor Claude"
  desc "Menu bar monitor for Claude Code usage"
  homepage "https://github.com/aegro/tool-claude-monitor-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Monitor Claude.app"

  zap trash: "~/Library/Application Support/MonitorClaude"
end
