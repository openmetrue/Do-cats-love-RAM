# Do cats love RAM?
SwiftUI needs to learn how to save memory. I decided to teach him to work with reusable.
(special thanks to Vadim @V8tr)
> **Important:** I need help to improve this project!

### Performance
* GeometryReader in each cell + medium resolution pictures (Apple A12) + 500mb total cost limit

![Project demo](screenrecording.gif)

* Using NukeUI, with old conditions + 500mb total cost limit

![Project demo NukeUI](screenrecordingNukeUI.gif)

### Use for your projects!
You can use a collection with pagination, with pullToRefresh
```swift
public let pullToRefresh = PassthroughSubject<Void, Never>()
public let loadMore = PassthroughSubject<Void, Never>()
public let limit = 10
UIKitCollection(items: cats,
                prefetchLimit: limit,
                loadMoreSubject: loadMore,
                pullToRefreshSubject: pullToRefresh)
{ indexPath, item in
    CatsCell(item: item, index: indexPath.row)
}
.onReceive(loadMore) {
    //fetch next page
}
.onReceive(pullToRefresh) {
    //refreshing page
}
```

Or just as a replacement SwiftUI ForEach
```swift
UIKitCollection(items: catsDB) { indexPath, item in
    NavigationLink(destination: CatsFavoriteDetail(cat: item)) {
        AsyncImageCached(url: item.url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
    }
}
```
