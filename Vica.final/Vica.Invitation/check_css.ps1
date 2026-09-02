$c = Get-Content "C:\Users\pc\Desktop\Vica.final\Index.html" -Raw
$s1 = $c.IndexOf('<style>')
while ($s1 -ge 0) {
    $s2 = $c.IndexOf('</style>', $s1)
    if ($s2 -lt 0) { break }
    $b = $c.Substring($s1 + 7, $s2 - $s1 - 7)
    $open = ($b.ToCharArray() | Where-Object { $_ -eq '{' }).Count
    $close = ($b.ToCharArray() | Where-Object { $_ -eq '}' }).Count
    Write-Host "style abiertas=$open cerradas=$close diff=$($open-$close)"
    $s1 = $c.IndexOf('<style>', $s2)
}
