$BigPapeDir = ".\OverSizePapes"
$PapeDir = ".\Papes"
$FitPapeDir = ".\FittedPapes"
$SmallPapeDir = ".\SmallPapes"

function SortPapes() {
    Write-Output "*******************************Sorting Wallpapers *************************************"
    foreach($p in Get-ChildItem -Path $PapeDir){
        $Bmap = (GetBitmap -Path $P.FullName)
        $Area = ($Bmap.Width * $Bmap.Height)
        $Width = $Bmap.Width
        $Height = $Bmap.Height
        $Bmap.Dispose()

        if ($Area -gt 2073600 -and $Width -gt 1920) {
            Write-Output "Too wide. Moving to oversized folder..."
            Move-Item -Path $p.FullName -Destination $BigPapeDir
        }
        elseif ($Area -gt 2073600 -and $Height -gt 1080) {
            Write-Output "Too tall. Moving to oversized folder..."
            Move-Item -Path $p.FullName -Destination $BigPapeDir
        }
        elseif ($Width -eq 1920 -and $Height -eq 1080) {
            Write-Output "Wallpaper already fitted..."
            Move-Item -Path $p.FullName -Destination $FitPapeDir
        }
        else {
            Write-Output "Too small. Moving to small folder..."
            Move-Item -Path $p.FullName -Destination $SmallPapeDir
        }
    }
}

function ResizeBigPapes(){
    Write-Output "*********************Resizing Wallpapers - Please Wait*************************************"
    Get-ChildItem -Path $BigPapeDir | ResizePic -Width 1920 -Height 1080 -Destination $FitPapeDir
    Write-Output "*************************************Done**************************************************"
}

SortPapes
ResizeBigPapes
Move-Item -Path $SmallPapeDir\* -Destination $FitPapeDir\


