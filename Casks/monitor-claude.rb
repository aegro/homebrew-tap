cask "monitor-claude" do
  version "0.1.0"
  sha256 "2a35d0c779bcc79de4c861b7a2b52491b72bc350fede9986792eae3457edb269"

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
