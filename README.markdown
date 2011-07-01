#STSegmentedControl

###About:

This is a custom class I wrote to enable use of own images in UISegmentedControl. I started with a UIControl subclass and tried to make it behave as much as possible like UISegmentedControl. This implementation also allows use of icons in the segments.

###Usage:

Using STSegmentedControl is straightforward. If you change your instances of UISegmentedControl to STSegmentedControl, most things will likely work.

My implementation does however have certain requirements for the images. The images are partially being overlaid, so you may have to fiddle with your shadows/transparency a little. You can check out the demo images to see how it's done.

Hit me up on [Twitter](twitter.com/SkyTrix) or send me an [email](mailto:cedric@freshcreations.be).