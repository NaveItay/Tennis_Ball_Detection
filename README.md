# Tennis Ball detection using matlab

###### _Home video project using MATLAB_
###### _Tennis Ball detection - alert when "Ball In/Out"_

![title](/Images/Final_result.PNG)


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
>     ![title](/Images/RGB_Masks.PNG)
>
> * imclose - Remove small objects from binary image
>     ![title](/Images/imclose.PNG)
>
>
>
>
>
>
>
>
>


###### Color masks
> ![title](/Images/RGB_Masks.PNG)
>

###### Color masks
> ![title](/Images/RGB_Masks.PNG)
>

###### Color masks
> ![title](/Images/RGB_Masks.PNG)
>

###### Color masks
> ![title](/Images/RGB_Masks.PNG)
>
   
   
   
     
     
