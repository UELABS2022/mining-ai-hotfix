$ErrorActionPreference = 'Stop'
$root = 'D:\Mining AI'
$configPath = Join-Path $root 'engine\updater_config.json'
if (!(Test-Path $configPath)) {
  Write-Host "Mining AI updater config not found at: $configPath" -ForegroundColor Red
  Write-Host "If Mining AI is installed somewhere else, tell Jory the install folder path."
  Read-Host "Press Enter to exit"
  exit 1
}
$config = Get-Content $configPath -Raw | ConvertFrom-Json
$config.protected_items = @(
  'app','engine/active_chat_machine.js','engine/backupLibrary.js','engine/backupMetadataExtractor.js','engine/backupRootUtil.js','engine/backupScanner.js','engine/checksumUtil.js','engine/config.js','engine/delta','engine/delta_applier.js','engine/embedder.js','engine/fleet_loader.js','engine/hoseTranslations.js','engine/ingest_runner.js','engine/ipcHandlers.js','engine/llm_generator.js','engine/manualLibrary.js','engine/manualSearch.js','engine/model_loader.js','engine/onnxEmbedder.js','engine/packDisplay.js','engine/packManager.js','engine/pack_loader.js','engine/parCompareService.js','engine/parParser.js','engine/partsCatalog.js','engine/picoclawManager.js','engine/quizClient.js','engine/rag_mcp_server.js','engine/rag_retriever_v2.js','engine/recipeCompareService.js','engine/recipeInjector.js','engine/recipeLibrary.js','engine/recipeManagerService.js','engine/run_llm.js','engine/security','engine/site_pack_loader.js','engine/store','engine/subModelUtil.js','engine/updater.js','engine/updater_changelog.js','engine/viewer','troubleshooting','main.js','preload.js','package.json'
)
$config | ConvertTo-Json -Depth 8 | Set-Content $configPath -Encoding UTF8
Write-Host "Mining AI updater hotfix applied." -ForegroundColor Green
Write-Host "Now reopen Mining AI and run Settings -> Check for Updates."
Read-Host "Press Enter to exit"
