# Tennis Ball detection

###### _Home video project using MATLAB_
###### _Tennis Ball detection - alert when "Ball In/Out"_

![title](/Images/Final_result.PNG)

###### Video Link

- Link to [Youtube](https://youtu.be/FgB4Xg2Jxw4).

## Project management stages:
   * Splitting the frame into color layers
   * RGB histograms
   * Set a custom threshold for creating the masks
   * Color masks
   * Morphological operations
     - bwareaopen
     - imclose
     - imfill
   * Concatenate RGB arrays
   * Hough Transformation
   * Use the objects coordinates to alert when "ball in / out"
   
   
   
   
# 
###### Splitting the frame into color layers
>  ![title](/Images/RGB_layers.PNG)
>

###### RGB histograms
> ![title](/Images/hist.PNG)
>

###### Set a custom threshold for creating the masks
> ![title](/Images/threshold_for_masks.PNG)
>
 
###### Color masks
> ![title](/Images/RGB_Masks.PNG)
>

###### Morphological operations
> * bwareaopen - Remove small objects from binary image
>       
>   ![title](/Images/RGB_Masks.PNG)
>       
> * imclose - Remove small objects from binary image
>           
>   ![title](/Images/imclose.PNG)
>
> * imfill - Fill image regions and holes
>
>   ![title](/Images/imfill.PNG)
>

###### Concatenate RGB arrays
> ![title](/Images/cat.PNG)
>

###### Hough Transformation
> ![title](/Images/hough_on_mask.PNG)
> * Find circles using circular Hough transform
>       
>     ![title](/Images/explain_hough_transformation.PNG)
>     ``` 
>     The purpose of the technique is to find imperfect instances of objects within a certain class of shapes by a voting 
>     procedure. This voting procedure is carried out in parameter space, from which object candidates are obtained as local maxima in a
>     so-called accumulator space that is explicitly constructed by the algorithm for computing the Hough transform.
>     ```
>

###### Use the objects coordinates to alert when "ball in / out"
> ![title](/Images/Coordinates.PNG)
>
