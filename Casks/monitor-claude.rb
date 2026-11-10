cask "monitor-claude" do
  version "0.6.17"
  sha256 "3802b278c7ef27d827cf1706a4aa8948be7ad63678a7ebf4232db5cacde8c301"

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
