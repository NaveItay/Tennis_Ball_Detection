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
      
        
    subplot(2, 4, 1);
	% Display RGB Frame.
            imshow(RGBFrame);
            caption = sprintf('Frame #%d 0f %d', k, numberOfFrames);  %% Show my current frame
            title(caption, 'FontSize', 16);
	drawnow;
    
    %       MASKS
   	redBand = RGBFrame(:, :, 1);
	greenBand = RGBFrame(:, :, 2);
	blueBand = RGBFrame(:, :, 3);
	% Display them.
	subplot(2, 4, 2);
	imshow(redBand);
    title('Red Band')
	subplot(2, 4, 3);
	imshow(greenBand);
    title('Green Band')
	subplot(2, 4, 4);
	imshow(blueBand);
    title('Blue Band')
    
       	% Compute and plot the red histogram.
                subplot(2, 4, 6);
                [countsR, grayLevelsR] = imhist(redBand);
                maxGLValueR = find(countsR > 0, 1, 'last');
                maxCountR = max(countsR);
                bar(countsR, 'r');
                grid on;
                xlabel('Gray Levels');
                ylabel('Pixel Count');
                title('Histogram of Red Band')
    
    % Compute and plot the green histogram.
                subplot(2, 4, 7);
                [countsG, grayLevelsG] = imhist(greenBand);
                maxGLValueG = find(countsG > 0, 1, 'last');
                maxCountG = max(countsG);
                bar(countsG, 'g', 'BarWidth', 0.95);
                grid on;
                xlabel('Gray Levels');
                ylabel('Pixel Count');
                title('Histogram of Green Band')
    
    % Compute and plot the blue histogram.
                subplot(2, 4, 8);
                [countsB, grayLevelsB] = imhist(blueBand);
                maxGLValueB = find(countsB > 0, 1, 'last');
                maxCountB = max(countsB);
                bar(countsB, 'b');
                grid on;
                xlabel('Gray Levels');
                ylabel('Pixel Count');
                title('Histogram of Blue Band')
    
    	% Plot all 3 histograms in one plot.
                subplot(2, 4, 5);
                plot(grayLevelsR, countsR, 'r', 'LineWidth', 2);
                grid on;
                xlabel('Gray Levels');
                ylabel('Pixel Count');
                hold on;
                plot(grayLevelsG, countsG, 'g', 'LineWidth', 2);
                plot(grayLevelsB, countsB, 'b', 'LineWidth', 2);
                title('Histogram of All Bands')
                maxGrayLevel = max([maxGLValueR, maxGLValueG, maxGLValueB]);  
                
                                  % Show the thresholds as vertical red bars on the histograms.
                    PlaceThresholdBars(6, redThresholdLow, redThresholdHigh)  
                    PlaceThresholdBars(7, greenThresholdLow, greenThresholdHigh)
                    PlaceThresholdBars(8, blueThresholdLow, blueThresholdHigh)
                
 end


% Function to show the low and high threshold bars on the histogram plots.
function PlaceThresholdBars(plotNumber, lowThresh, highThresh)
	% Show the thresholds as vertical red bars on the histograms.
	subplot(2, 4, plotNumber);
	hold on;
	yAxisRangeValues = ylim;
	line([lowThresh, lowThresh], yAxisRangeValues, 'Color', 'r', 'LineWidth', 2);
	line([highThresh, highThresh], yAxisRangeValues, 'Color', 'r', 'LineWidth', 2);
	% Place a text label on the bar chart showing the threshold.
	fontSizeThresh = 14;
	annotationTextL = sprintf('%d', lowThresh);
	annotationTextH = sprintf('%d', highThresh);
	% For text(), the x and y need to be of the data class "double" so let's cast both to double.
	text(double(lowThresh + 5), double(0.85 * yAxisRangeValues(2)), annotationTextL, 'FontSize', fontSizeThresh, 'Color', [0 .5 0], 'FontWeight', 'Bold');
	text(double(highThresh + 5), double(0.85 * yAxisRangeValues(2)), annotationTextH, 'FontSize', fontSizeThresh, 'Color', [0 .5 0], 'FontWeight', 'Bold');
    hold off
end

    