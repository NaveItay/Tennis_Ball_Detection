clc
clear all
close all

videoObject = VideoReader('VID_20200629_135940.mp4');
numberOfFrames = videoObject.NumberOfFrame;

%   %%%%%%%%%%%%%%%%    Itay Nave edit your self    %%%%%%%%%%%%%%%%

		redThresholdLow = 90;
		redThresholdHigh = 185;
		greenThresholdLow = 65;
		greenThresholdHigh = 175;
		blueThresholdLow = 50;
		blueThresholdHigh = 165;
        
%   %%%%%%%%%%%%%%%%    Itay Nave edit your self    %%%%%%%%%%%%%%%%
        

for k = 1 : numberOfFrames	
	% Read one frame
    
	RGBFrame=read(videoObject,k);
    
		% Check to see if it's an 8-bit image needed later for scaling).
	if strcmpi(class(RGBFrame), 'uint8')
		% Flag for 256 gray levels.
		eightBit = true;
	else
		eightBit = false;
	end
      
        
    subplot(3, 4, 1);
	% Display RGB Frame.
            imshow(RGBFrame);
            caption = sprintf('Frame #%d 0f %d', k, numberOfFrames);
            title(caption, 'FontSize', 16);
	drawnow;
    
%     RGB  Masks
   	redBand = RGBFrame(:, :, 1);
	greenBand = RGBFrame(:, :, 2);
	blueBand = RGBFrame(:, :, 3);
	% Display them.
	subplot(3, 4, 2);
	imshow(redBand);
    title('Red Band')
	subplot(3, 4, 3);
	imshow(greenBand);
    title('Green Band')
	subplot(3, 4, 4);
	imshow(blueBand);
    title('Blue Band')
  
    % Trim x-axis to just the max gray level on the bright end.
	if eightBit
		xlim([0 255]);
	else
		xlim([0 maxGrayLevel]);
    end
    
          % Now apply each color band's particular thresholds to the color band
    redMask = ((redBand >= redThresholdLow) & (redBand <= redThresholdHigh));
	greenMask = not((greenBand >= greenThresholdLow) & (greenBand <= greenThresholdHigh));
	blueMask = not((blueBand >= blueThresholdLow) & (blueBand <= blueThresholdHigh));
    
    % Display the thresholded binary images.
	subplot(3, 4, 6);
	imshow(redMask, []);
	title('Is Not Red Mask')
	subplot(3, 4, 7);
	imshow(greenMask, []);
	title('Is Green Mask')
	subplot(3, 4, 8);
	imshow(blueMask, []);
	title('Is Not Blue Mask')
    
    % Combine the masks.
	greenObjectsMask = uint8(  (greenMask | blueMask) & (redMask)  );
	subplot(3, 4, 5);
	imshow(greenObjectsMask, []);
	caption = sprintf('Dedect Green Objects');
	title(caption)
    
   % Keep areas only if they're bigger than this.
	smallestAcceptableArea = 1000; 
    
    	% Get rid of small objects.  Note: bwareaopen returns a logical.
	MyMask = uint8(bwareaopen(greenObjectsMask, smallestAcceptableArea));
	subplot(3, 4, 9);
	imshow(MyMask, []);
	caption = sprintf('bwareaopen', smallestAcceptableArea);
	title(caption)
    
    	% Smooth the border using a morphological closing operation, imclose().
	structuringElement = strel('disk', 4);
	MyMask = imclose(MyMask, structuringElement);
	subplot(3, 4, 10);
	imshow(MyMask, []);
	title('Border smoothed')
    
    % Fill in any holes in the regions.
	MyMask = uint8(imfill(MyMask, 'holes'));
	subplot(3, 4, 11);
	imshow(MyMask, []);
	title('Regions Filled')
    
    % We need to convert the type of MyMask to the same data type as GreenBand.
	MyMask = cast(MyMask, class(greenBand));
    
    	% Use the green object mask to mask out the green-only portions of the rgb image.
	maskedImageR = MyMask .* redBand;
	maskedImageG = MyMask .* greenBand;
	maskedImageB = MyMask .* blueBand;
    
    	% Concatenate the masked color bands to form the rgb image.
	maskedRGBImage = cat(3, maskedImageR, maskedImageG, maskedImageB);
    
    	% Show the masked off, original image.
	subplot(3, 4, 12);
	imshow(maskedRGBImage);
	caption = sprintf('Masked Original Image\nShowing Only the Green Objects');
	title(caption)
       
% court = redBand >= 180 & redBand <= 220 & greenBand >= 140 & greenBand <= 160 & blueBand >= 100 & blueBand <= 120;
% 
% imshow(court);
% Get (row, column) list
% [centers2,radii2] = imfindcircles(court,[30 40],'ObjectPolarity','bright','Sensitivity',0.97);
% viscircles(centers2, radii2,'LineStyle','--');      
end
 