
$IE=new-object -com internetexplorer.application
$IE.navigate2("https://www.twitch.tv/overwatchleague").MainWindowTitle
$IE.visible=$true

#get-process iexplore | stop-process