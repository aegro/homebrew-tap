# Aegro Homebrew Tap

Homebrew tap com as ferramentas da Aegro — CLIs e apps de macOS.

```sh
brew tap aegro/tap
```

## Disponível

### Aegro CLI (formula)

CLI da API de gestão agrícola da Aegro.

```sh
brew install aegro
brew upgrade aegro
```

- [PyPI](https://pypi.org/project/aegro/) · [código](https://github.com/aegro/tool-aegro-cli)

### Monitor Claude (cask)

Monitor de consumo do Claude Code na barra de menu do macOS — app nativo, assinado com Developer ID e notarizado.

```sh
brew install --cask monitor-claude
brew upgrade --cask monitor-claude
```

Na primeira execução, o macOS pergunta uma vez se o app pode ler a credencial do Claude Code no Keychain — clique **Sempre Permitir** (não volta a perguntar).

- [código](https://github.com/aegro/tool-claude-monitor-macos)
