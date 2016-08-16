# first you have to be admin
function isAdmin {
	$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
	$principal = new-object System.Security.Principal.WindowsPrincipal($identity)
	$admin = [System.Security.Principal.WindowsBuiltInRole]::Administrator
	$principal.IsInRole($admin)
}
if (isAdmin) {
	echo "
[+] Welcome!
This script will download Shadowsocks Plus and install it as an auto start job,
if your Anti-Virus complains, you can safely ignore it
"
}
else {
	echo "
[-] Sorry, but I reli need admin privilege to finish my job :( Please run me again as admin
"
	$end = Read-Host 'Press Enter to exit'
	exit 1
}

$install_dir = $env:SystemRoot
#$myself = $MyInvocation.MyCommand.Name
# fetch ssp from github
$wc = New-Object System.Net.WebClient
$url = "https://github.com/jm33-m0/shadowsocks-plus/releases/download/v0.1/ssp.exe"
$out_file = "$PWD\ssp.exe"
if (-Not(Test-Path $PWD\ssp.exe)) {
    echo "[*] Downloading ssp from Github..."
	$wc.DownloadFile($url, $out_file) # download file, of course we can `wget $url -Outfile .\ssp.exe`
}

# now we install our job
if (Test-Path $install_dir\ssp.exe) {
	echo "I am already in your PATH
"
}
else {
	echo "You dont have me in your PATH, I will put myself there
"
	cp $out_file $install_dir
}
if (-Not(Test-Path $install_dir\ssp.ps1)) {
    # server config
	echo "[*] Shall we fill in the server config details now?
"
	$server = Read-Host 'Server IP'
	$port = Read-Host 'Server port'
	$password = Read-Host 'Password'
	$lport = Read-Host 'Local port'
	echo ""
    echo "$install_dir\ssp.exe -s $server -p $port -l $lport -k $password" > $install_dir\ssp.ps1
}

# this is how we install a auto start job
$triger = New-JobTrigger -AtStartup
Register-ScheduledJob -Name ssp -FilePath $install_dir\ssp.ps1 -Trigger $triger