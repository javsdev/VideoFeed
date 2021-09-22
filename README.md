# Video Feed App 

## System design choices

App was done using MVVM for each of the modules, 
used delegation and RxSwift to handle messages between 
components.

I also used and App coordinator to navigate between the modules,
and a coordinator for each of them for routing for the views that
can be developed in the future.

I created one service per module and a shared property in each of
them to be able to access to an instance of them easily. They
implement a protocol and used mock data to load info about the user
and videos. It can be extended to be able to handle calls to an
endpoint to get that information.

###### Video Feed
The layout was done with one UICollectionView and each cell of the
same size of it, to show only one video at a time.
Passing to each cell the url so it is able to configure the player
and start playing the video.
More data can be passed to it, like a User object, or other formatted
data to display in front of the video.

####### Profile Page
The layout was done with stack views and autolayout, getting formatted
data from the View Model.


It can be extended easily, adding other modules and other views.
