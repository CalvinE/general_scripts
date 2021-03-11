param (
    [ValidateSet("single", "channel", "playlist", "channel-playlist")][string]$type = "single",
    [string]$maxDownloads = "10000",
    # 01/01/1970
    [string]$notBefore = "19700101",
    [string]$outputFormatPrepend = $null,
    [Parameter(Mandatory=$true)][string[]]$urls
)

$singleVideoOutputFormat = "%(title)s/%(title)s.%(ext)s"
$channelVideoOutputFormat = "%(uploader)s/%(title)s/%(title)s.%(ext)s"
$playListVideoOutputFormat = "%(playlist_title)s/%(playlist_index)s-%(title)s/%(title)s.%(ext)s"
$channelPlayListVideoOutputFormat = "%(uploader)s/%(playlist_title)s/%(playlist_index)s-%(title)s/%(title)s.%(ext)s"

foreach ($url in $urls) {
    Write-Host ("Downloading a max of {0} videos not uploaded before {1} from {3} - {2}" -f $maxDownloads, $notBefore, $url, $type)
    switch($type) {
        "single" {
            $outputFormat = $singleVideoOutputFormat
        }
        "channel" {
            $outputFormat = $channelVideoOutputFormat
        }
        "playlist" {
            $outputFormat = $playListVideoOutputFormat
        }
        "channel-playlist" {
            $outputFormat = $channelPlayListVideoOutputFormat
        }
        Default {
            throw
        }
    }
    if ($outputFormatPrepend) {
        $outputFormat = Join-Path -Path $outputFormatPrepend -ChildPath $outputFormat
    }
    $command = "youtube-dl.exe --sleep-interval 1 --max-sleep-interval 3 --write-info-json --write-annotations --all-subs --write-all-thumbnails --max-downloads $maxDownloads --dateafter $notBefore -i -o ""$outputFormat"" ""$url"""
    Invoke-Expression "$command"
}
