# Test if server is running
Write-Host "Testing server connection..." -ForegroundColor Yellow

# Wait a bit for server to start
Start-Sleep -Seconds 3

# Test root endpoint
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get -TimeoutSec 5
    Write-Host "✅ Server is running!" -ForegroundColor Green
    Write-Host "Response: $($response | ConvertTo-Json)" -ForegroundColor Cyan
} catch {
    Write-Host "❌ Server not responding: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Checking if port 8000 is in use..." -ForegroundColor Yellow
    $connections = Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue
    if ($connections) {
        Write-Host "Port 8000 is in use by process: $($connections.OwningProcess)" -ForegroundColor Yellow
    } else {
        Write-Host "Port 8000 is not in use" -ForegroundColor Red
    }
}

# Test health endpoint
try {
    $health = Invoke-RestMethod -Uri "http://localhost:8000/health" -Method Get -TimeoutSec 5
    Write-Host "`n✅ Health check passed!" -ForegroundColor Green
    Write-Host "Health: $($health | ConvertTo-Json)" -ForegroundColor Cyan
} catch {
    Write-Host "`n⚠️  Health endpoint not responding: $($_.Exception.Message)" -ForegroundColor Yellow
}

