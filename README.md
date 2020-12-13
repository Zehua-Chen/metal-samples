# Metal Samples

Metal sample codes

## Overview

- `SampleKit`: shared definition of samples
- `SampleXXX`: sample with pascal-casing name `XXX`
- `MetalSamples`: a Swift UI Mac app that hosts all the samples
  
## Adding New Samples

1. Create a bundle and name it `SampleXXX`
2. Reference but **do not embed** `SampleKit` in `SampleXXX`
3. Create a class in `SampleXXX` named `SampleXXX` and set `SampleXXX` as the "Principal class" in `Info.plist`
   ```swift
   import SampleKit
   
   @objc(SampleSkybox)
   public class SampleSkybox: Sample {
     public var name: String = "Skybox"
     public var tag: SampleTag = .textures

     public required init() {
     }
   }
   ``` 
4. Embed `SampleXXX` in `MetalSamples`
