# Tennis Ball detection using matlab

###### _Home video project using MATLAB_
###### _Tennis Ball detection - alert when "Ball In/Out"_

![title](/Images/frames.PNG)


## Project management stages:
   * Splitting the frame into color layers
   * RGB histograms
   * Set a custom threshold for creating the masks
   * Color masks
   * Morphological operations
     - bwareaopen
       - Remove small objects from binary image
     - imclose
       - Morphologically close image
     - imfill
       - Fill image regions and holes
   * Concatenate RGB arrays
   * Hough Transformation
     - Find circles using circular Hough transform
   * Use the objects coordinates to alert when "ball in / out"
   
   
   
   
     
     
