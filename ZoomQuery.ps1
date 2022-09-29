# Authentication block

$ZoomAccountID = "ABCDEFG123456789"
$ZoomClientID = "ABCDEFG123456789"
$ZoomClientSecret = "ABCDEFG123456789"

$BaseAuthURL = "https://zoom.us/oauth/token?grant_type=account_credentials&account_id=$($ZoomAccountID)"

$Header1 = @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($ZoomClientID+":"+$ZoomClientSecret))}
$Header2 = @{"User-Agent" = "Mozilla/4.0 (compatible; MSIE 5.0; Series60/2.8 Nokia6630/4.06.0 Profile/MIDP-2.0 Configuration/CLDC-1.1"}
$Header = $Header1 + $Header2

$ContentType = "application/json"

Try
{
    $ZoomSessionResponse = Invoke-RestMethod -Uri $BaseAuthURL -Headers $Header -Method POST -ContentType $ContentType -Verbose
}
Catch
{
    Get-Date -Format g
    $_.Exception.ToString()
    $error[0] | Format-List -Force
}

# End authentication block

$Header = @{"Authorization" = "Bearer $($ZoomSessionResponse.access_token)"}

# Use any valid Zoom API endpoint below
$me = Invoke-RestMethod -Uri "https://api.zoom.us/v2/users/me" -Method GET -Headers $Header -Verbose
