ABImageLoader
=============
If you faces the problem of loading different images for different devices and different orientations, this can help you.

Steps to use:

1. Add these categories to your project (for example just drag and drop them to the XCode).
2. Type `#import "UIImage+Loading.h"`
3. Use `[UIImage imageWithName:@"ImageName"]` to load image.



Image names should be in the next format:

**<<n>name><<n>orientation><<n>scale><<n>device>.<<n>extension>**

* **<<n>name>** -- name of the image. This name you should pass to the imageWithName: method.
* **<<n>orientation>** -- can be *-landscape*, *-portrait* or missed.
* **<<n>scale>** -- image scale factor. Should be written as *@2x*, *@3x*, etc. Don't use *@1x*, just left it empty instead.
* **<<n>device>** -- can be *~ipad*, *~iphone* or missed.
* **<<n>extension>** -- image extension (*png*, for example).

Passed to `imageWithName:` method parameter should be either **<<n>name>.<<n>extension>** or **<<n>name>** (in this case extension will be treated as *png*).

More detailed names have higher priority for loading. For example if there are *image@2x~ipad.png* and *image-portrait@2x~ipad.png*, the second one will be chosen for portrait orientation.
