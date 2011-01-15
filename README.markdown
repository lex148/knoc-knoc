# knoc-knoc, a gem to tell you who is there

KnocKnoc will scan your network and tell you who is on it.
It will tell you when someone new arrives and when someone leaves

##About KnocKnoc

KnocKnoc has two modes live and monitor. 

Monitor mode scans your network in the background. if you ask KnocKnoc whos there in monitor mode, it will only tell you about who it knows about right then.
 
Live mode only scans when you ask about the network. when in live mode you are guaranteed a fill list of people on your network, however you will have to wait for it.

###Switching Modes

- KnocKnoc::mode = KnocKnoc::WatchmanMonitor
- KnocKnoc::mode = KnocKnoc::WatchmanLive


##Using KnocKnoc

To use KnocKnoc you ask it who is there

- KnocKnoc::whos_there => [list of people on your network]
- KnocKnoc::whos_new => [list of the new people on your network]
- KnocKnoc::whos_left => [list of the people that have left your network]



