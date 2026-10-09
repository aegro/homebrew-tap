cask "monitor-claude" do
  version "0.6.2"
  sha256 "329e722660b36443a45de20ecdda4584eceed95a1c22ef046b35e5c7f178f3c2"

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
