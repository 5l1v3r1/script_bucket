# fetch hosts file from github
$tmp_dir = $PWD
$wc = New-Object System.Net.WebClient
$url = "https://raw.githubusercontent.com/racaljk/hosts/master/hosts"
$out_file = "$tmp_dir\hosts"
$wc.DownloadFile($url, $out_file) # download file

echo ""
Write-Output "[*] i just downloaded a file from github using *Object* in PowerShell"
echo "" # this prints a newline, like it does in Shell script

# another way to do so
wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts -OutFile hosts.1
Write-Output "[*] this is another way to download a file, using 'Invoke-WebRequest' aka 'wget'"
echo ""

$install_path = $env:SystemRoot
echo $args[1]
echo "i just copied myself to $install_path\$0"

function isAdmin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = new-object System.Security.Principal.WindowsPrincipal($identity)
    $admin = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $principal.IsInRole($admin)
}

if (isAdmin) {
    echo "welcome"
    }
echo $args