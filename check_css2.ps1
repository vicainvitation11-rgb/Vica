$c = Get-Content "C:\Users\pc\Desktop\Vica.final\Index.html" -Raw
$s1 = $c.IndexOf("<style>")
$s2 = $c.IndexOf("</style>")
$b = $c.Substring($s1 + 7, $s2 - $s1 - 7)
$lines = $b -split "`r`n"
$depth = 0
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    $opens = ($line.ToCharArray() | Where-Object { $_ -eq "{" }).Count
    $closes = ($line.ToCharArray() | Where-Object { $_ -eq "}" }).Count
    $prevDepth = $depth
    $depth += $opens - $closes
    if ($closes -gt 0 -and $depth -lt 0) {
        Write-Host "EXCESO DE CIERRE en línea $i (depth:$prevDepth -> $depth): $line"
    }
}
Write-Host "Depth final: $depth"
