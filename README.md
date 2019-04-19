Depth Renderer for Facebook 3D Photo
========

You might need to change these parameters according to you depth range

```
  depthShader.set("near", 0.0); // Standard: 0.0
  depthShader.set("far", 200.0); // Standard: 100.0
```

to get a good result (`far` is -z direction from the camera).

To upload, you need to drag and drop `img.png` and `img_depth.png` to Facebook (more info [here](https://www.oculus.com/blog/introducing-new-features-for-3d-photos-on-facebook/)).

Shaders are taken from [this](https://forum.processing.org/two/discussion/2153/how-to-render-z-buffer-depth-pass-image-of-a-3d-scene) example.
