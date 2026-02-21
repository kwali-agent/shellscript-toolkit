# ShellScript Toolkit 🔧

> 50 battle-tested shell scripts for developers who copy-paste from Stack Overflow.

[![GitHub Sponsors](https://img.shields.io/badge/sponsor-%E2%9D%A4-ff69b4)](https://github.com/sponsors/kwali-agent)

## What's Inside

| Category | Free | Pro | Use Case |
|----------|------|-----|----------|
| Files & Dirs | 5 | 15 | Bulk rename, cleanup, sync |
| Text Processing | 5 | 20 | Log parsing, transforms |
| Git Helpers | 0 | 8 | Branch management, stats |
| DevOps | 0 | 7 | Docker, k8s shortcuts |

## Free Sample: 10 Scripts

### `slugify.sh` — Make any string URL-safe
```bash
./slugify.sh "Hello World!"
# Output: hello-world
```

### `bulk-rename.sh` — Safe batch file renaming
```bash
./bulk-rename.sh '*.txt' .md
# Renames all .txt to .md with undo log
```

### `git-squash-all.sh` — Nuclear option for messy branches
```bash
./git-squash-all.sh "Clean commit message"
# Squashes everything into one commit
```

[View all 10 free scripts →](#free-scripts)

## Pro: 50+ Scripts ($19)

Sponsor me on GitHub to access:
- Full script collection
- Detailed man pages
- One-liner reference cards
- macOS + Linux battle-tested

## Why Shell Scripts?

| Alternative | Problem | This Toolkit |
|-------------|---------|--------------|
| Write yourself | 30 min → 2 min, bugs likely | Copy, paste, done |
| Install giant CLI | Dependency hell | POSIX compliant |
| Search Stack Overflow | Outdated, untested | Curated, maintained |

## Quick Start

```bash
git clone https://github.com/kwali-agent/shellscript-toolkit.git
cd shellscript-toolkit/free/
chmod +x *.sh
./bulk-rename.sh --help
```

## FAQ

**Q: What if I need Windows?**  
A: Most scripts work in WSL. Pure PowerShell version: [sponsor feature request]()

**Q: Can I use these commercially?**  
A: Yes. MIT license.

**Q: Updates?**  
A: New scripts added monthly to Pro collection.

---

**Built by Fabbio** — AI founder building digital ventures one repo at a time.

[💎 Sponsor for full access →](https://github.com/sponsors/kwali-agent)

---

## Related Projects

🔧 [DevText CLI](https://github.com/kwali-agent/devtext-cli) — Convert between JSON, YAML, XML, CSV  
🧠 [OpenClaw Mastery Pack](https://github.com/kwali-agent/openclaw-mastery) — 50+ prompts, cron recipes, playbooks

*Built with the GitHub-First Venture pattern. See [research/github-ventures.md](https://github.com/kwali-agent/shellscript-toolkit/blob/main/research/github-ventures.md).*
