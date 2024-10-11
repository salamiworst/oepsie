$picture = "https://4.bp.blogspot.com/-iU33xmthFhA/UC5-jfzvzbI/AAAAAAAAFOE/xx3oKoIZGqU/s1600/dieren-en-paarden-wallpaper-met-een-prachtig-groot-zwart-paard-in-het-weiland-hd-achtergrond-foto.jpg"

# Maak een pad naar de AppData-folder
$path = "$env:APPDATA\Microsoft\Windows"
if (!(Test-Path -Path $path)) {
    New-Item -ItemType Directory -Path $path
}

# Controleer of de afbeelding al bestaat
$Image = "$path\background.jpg"
if (!(Test-Path -Path $Image)) {
    # Download de afbeelding als deze nog niet bestaat
    try {
        iwr $picture -OutFile $Image
    } catch {
        # Fout bij het downloaden van de afbeelding. (verwijderd)
    }
}

# Stel de afbeelding in als bureaubladachtergrond
$code = @'
using System.Runtime.InteropServices; 
namespace Win32 { 
    public class Wallpaper { 
        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
        static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); 
         
        public static void SetWallpaper(string thePath) { 
            SystemParametersInfo(20, 0, thePath, 3); 
        }
    }
}
'@

Add-Type $code 
[Win32.Wallpaper]::SetWallpaper($Image)

# Geen registerwijzigingen meer om verdachte acties te vermijden
