$ErrorActionPreference = 'Stop'

$protectedItems = @(
  'app','engine/active_chat_machine.js','engine/backupLibrary.js','engine/backupMetadataExtractor.js','engine/backupRootUtil.js','engine/backupScanner.js','engine/checksumUtil.js','engine/config.js','engine/delta','engine/delta_applier.js','engine/embedder.js','engine/fleet_loader.js','engine/hoseTranslations.js','engine/ingest_runner.js','engine/ipcHandlers.js','engine/llm_generator.js','engine/manualLibrary.js','engine/manualSearch.js','engine/model_loader.js','engine/onnxEmbedder.js','engine/packDisplay.js','engine/packManager.js','engine/pack_loader.js','engine/parCompareService.js','engine/parParser.js','engine/partsCatalog.js','engine/picoclawManager.js','engine/quizClient.js','engine/rag_mcp_server.js','engine/rag_retriever_v2.js','engine/recipeCompareService.js','engine/recipeInjector.js','engine/recipeLibrary.js','engine/recipeManagerService.js','engine/run_llm.js','engine/security','engine/site_pack_loader.js','engine/store','engine/subModelUtil.js','engine/updater.js','engine/updater_changelog.js','engine/viewer','troubleshooting','main.js','preload.js','package.json'
)

Write-Host 'Stopping Mining AI / llama processes if running...'
Get-Process | Where-Object {
  $_.ProcessName -match 'MiningAI|Mining AI|llama|picoclaw|electron'
} | ForEach-Object {
  try { Stop-Process -Id $_.Id -Force -ErrorAction Stop; Write-Host "Stopped $($_.ProcessName) PID $($_.Id)" } catch {}
}

$candidates = @()
foreach ($drive in Get-PSDrive -PSProvider FileSystem) {
  $p = Join-Path $drive.Root 'Mining AI\engine\updater_config.json'
  if (Test-Path $p) { $candidates += $p }
}

if ($candidates.Count -eq 0) {
  Write-Host 'Mining AI updater config not found on any drive at <drive>:\Mining AI\engine\updater_config.json' -ForegroundColor Red
  Write-Host 'If Mining AI is inside another folder, tell Jory the exact install path.'
  Read-Host 'Press Enter to exit'
  exit 1
}

foreach ($configPath in $candidates) {
  $config = Get-Content $configPath -Raw | ConvertFrom-Json
  $config.protected_items = $protectedItems
  $config | ConvertTo-Json -Depth 8 | Set-Content $configPath -Encoding UTF8
  Write-Host "Patched: $configPath" -ForegroundColor Green
}

Write-Host ''
Write-Host 'Hotfix complete. Reopen Mining AI from the drive you want, then run Settings -> Check for Updates.' -ForegroundColor Green
Read-Host 'Press Enter to exit'
