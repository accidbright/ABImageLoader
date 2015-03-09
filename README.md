ABImageLoader
=============
If you faces the problem of loading different images for different devices and different orientations, this can help you.

Category uses swizzling and support two types of image loading:

* Programmatically.
* From XIB/Storyboard.

Steps to use:

1. Add these categories to your project (for example just drag and drop them to the XCode).
2. Load images as usually with  `[UIImage imageNamed:@"ImageName"]`. Or set them in XIB/Storyboard



Image names should be in the next format:

**<<n>name><<n>orientation><<n>screen_height><<n>scale><<n>device>.<<n>extension>**

* **<<n>name>** -- name of the image. This name you should pass to the `imageNamed:` method.
* **<<n>orientation>** -- can be *-landscape*, *-portrait* or missed.
* **<<n>screen_height>** -- screen height if you want to specify different images for different screen heights. Can be *-568h*, *-667h*, *-736h* or missed.
* **<<n>scale>** -- image scale factor. Should be written as *@2x*, *@3x*, etc. Don't use *@1x*, just left it empty instead.
* **<<n>device>** -- can be *~ipad*, *~iphone* or missed.
* **<<n>extension>** -- image extension (*png*, for example).

Passed to `imageNamed:` method parameter should be either **<<n>name>.<<n>extension>** or **<<n>name>** (in this case extension will be treated as *png*).

More detailed names have higher priority for loading. For example if there are *image@2x~ipad.png* and *image-portrait@2x~ipad.png*, the second one will be chosen for portrait orientation.

You can send me your notes and questions about this source to the email: [accidbright@gmail.com](mailto:accidbright@gmail.com).
