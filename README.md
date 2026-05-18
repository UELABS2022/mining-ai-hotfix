# Mining AI updater hotfix

Use this if Mining AI update fails with:

`EPERM: operation not permitted, unlink ...\engine\llama.cpp\ggml-base.dll`

## Easy command

1. Close Mining AI.
2. Open Windows PowerShell.
3. Paste this command and press Enter:

```powershell
irm https://raw.githubusercontent.com/UELABS2022/mining-ai-hotfix/main/MiningAI-Update-Hotfix-v1.0.10.ps1 | iex
```

4. It patches every `<drive>:\Mining AI\engine\updater_config.json` it finds, including USB copies like `E:\Mining AI`.
5. Reopen Mining AI.
6. Run Settings -> Check for Updates.

This changes only updater config so the update does not try to delete locked llama.cpp DLLs.
