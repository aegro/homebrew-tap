cask "monitor-claude" do
  version "0.6.14"
  sha256 "11ccea8518afc4ca2673ece078b36c06e1ec372883c8a7551de490bfb0aa5441"

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
