$c = Get-Content "C:\Users\pc\Desktop\Vica.final\Copiadeseguridad.html" -Raw
$s1 = $c.IndexOf("<style>")
$foundExtra = $false
while ($s1 -ge 0) {
    $s2 = $c.IndexOf("</style>", $s1)
    if ($s2 -lt 0) { break }
    $b = $c.Substring($s1 + 7, $s2 - $s1 - 7)
    $lines = $b -split "`r`n"
    $startLine = $c.Substring(0, $s1).Split("`n").Count
    $depth = 0
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $opens = ($line.ToCharArray() | Where-Object { $_ -eq "{" }).Count
        $closes = ($line.ToCharArray() | Where-Object { $_ -eq "}" }).Count
        $depth += $opens - $closes
        if ($closes -gt 0 -and $depth -lt 0) {
            Write-Host ("EXCESO CIERRE en línea $($startLine + $i): $line")
            $depth = 0
            $foundExtra = $true
        }
    }
    Write-Host "Depth final: $depth"
    $s1 = $c.IndexOf("<style>", $s2)
}
if (-not $foundExtra) { Write-Host "No se encontraron cierres extra" }
