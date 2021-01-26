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
      
        
    subplot(1, 3, 1);
	% Display RGB Frame.
            imshow(RGBFrame);
            caption = sprintf('Frame #%d 0f %d', k, numberOfFrames);
            title(caption, 'FontSize', 16);
	drawnow;
    
%       MASKS
   	redBand = RGBFrame(:, :, 1);
	greenBand = RGBFrame(:, :, 2);
	blueBand = RGBFrame(:, :, 3);

    % Trim x-axis to just the max gray level on the bright end.
	if eightBit
		xlim([0 255]);
	else
		xlim([0 maxGrayLevel]);
    end
    
%          Now apply each color band's particular thresholds to the color band
    redMask = ((redBand >= redThresholdLow) & (redBand <= redThresholdHigh));
	greenMask = not((greenBand >= greenThresholdLow) & (greenBand <= greenThresholdHigh));
	blueMask = not((blueBand >= blueThresholdLow) & (blueBand <= blueThresholdHigh));
    
%          mask of only the green parts of the image.
	greenObjectsMask = uint8(  (greenMask | blueMask) & (redMask)  );
    
%          Keep areas only if they're bigger than this.
	smallestAcceptableArea = 1000; 
    
%     	  Get rid of small objects.  Note: bwareaopen returns a logical.
	MyMask = uint8(bwareaopen(greenObjectsMask, smallestAcceptableArea));
    
%     	  Smooth the border using a morphological closing operation, imclose().
	structuringElement = strel('disk', 4);
	MyMask = imclose(MyMask, structuringElement);

    
    % Fill in any holes in the regions.
	MyMask = uint8(imfill(MyMask, 'holes'));
	subplot(1, 3, 2);
	imshow(MyMask, []);
	title('Regions Filled')
    
    
%             %%              Find my ball                %%


[centers,radii] = imfindcircles(MyMask,[30 40],'ObjectPolarity','bright','Sensitivity',0.98);
viscircles(centers, radii,'Color','b');



    % We need to convert the type of MyMask to the same data type as greenBand.
	MyMask = cast(MyMask, class(greenBand));
    
    	% Use the green object mask to mask out the green-only portions of the rgb image.
% 	maskedImageR = MyMask .* redBand;
% 	maskedImageG = MyMask .* greenBand;
% 	maskedImageB = MyMask .* blueBand;
    
    	% Concatenate the masked color bands to form the rgb image.
% 	maskedRGBImage = cat(3, maskedImageR, maskedImageG, maskedImageB);
    
   subplot(1, 3, 3);
	% Display RGB Frame.
            imshow(RGBFrame);
            caption = sprintf('Detect my tennis ball - Frame #%d 0f %d', k, numberOfFrames);
            title(caption, 'FontSize', 16)
            viscircles(centers, radii,'LineStyle','--');
            
% %              Detect In/Out Ball

court = redBand >= 180 & redBand <= 220 & greenBand >= 140 & greenBand <= 160 & blueBand >= 100 & blueBand <= 120;
court = court .* not(redMask) ;
% subplot(1, 4, 4);
% imshow(court);
[centers2,radii2] = imfindcircles(court,[30 40],'ObjectPolarity','bright','Sensitivity',0.99);
% viscircles(centers2, radii2,'LineStyle','--');

XCourt = centers2;
YCourt = centers2;

XCourt(:,2) = [] ; 
XCourtmin = min(XCourt);
XCourtmax = max(XCourt);

YCourt(:,1) = [] ; 
YCourtmin = min(YCourt);
YCourtmax = max(YCourt);

if ne(centers,0)
    
        XBall = centers;
        YBall = centers;

        XBall(:,2) = [] ; 
        XBallmin = min(XBall);
        XBallmax = max(XBall);

        YBall(:,1) = [] ;
        YBallmin = min(YBall);
        YBallmax = max(YBall);

if and( XBallmin > XCourtmin , XBallmax < XCourtmax) && and( YBallmin > YCourtmin , YBallmax < YCourtmax )
    title('Ball In !')
else
    title('Ball Out !')
end

else
   title('Ball Out !')
end


end