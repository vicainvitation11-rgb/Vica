$c = Get-Content "C:\Users\pc\Desktop\Vica.final\Index.html" -Raw
$s1 = $c.IndexOf("<style>")
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
            Write-Host ("EXCESO CIERRE en línea $($startLine + $i) (depth:$($depth + $closes)): $line")
            $depth = 0
        }
    }
    Write-Host "Depth final del bloque: $depth"
    $s1 = $c.IndexOf("<style>", $s2)
}
