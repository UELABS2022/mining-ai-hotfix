# Mining AI updater hotfix

Use this only if Mining AI update fails with:

`EPERM: operation not permitted, unlink D:\Mining AI\engine\llama.cpp\ggml-base.dll`

## Easy command

1. Close Mining AI.
2. Open Windows PowerShell.
3. Paste this command and press Enter:

```powershell
irm https://raw.githubusercontent.com/UELABS2022/mining-ai-hotfix/main/MiningAI-Update-Hotfix-v1.0.10.ps1 | iex
```

4. Reopen Mining AI.
5. Run Settings -> Check for Updates.

This changes only `D:\Mining AI\engine\updater_config.json` so the updater does not try to delete locked llama.cpp DLLs.
