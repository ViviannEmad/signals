rgbImage = imread('peppers.png');

% Extract color channels.
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel

% Create an all-black channel.
allBlack = zeros(size(rgbImage, 1), size(rgbImage, 2));

% Create color versions of the individual color channels.
just_red = cat(3, redChannel, allBlack, allBlack);
just_green = cat(3, allBlack, greenChannel, allBlack);
just_blue = cat(3, allBlack, allBlack, blueChannel);
 
figure
subplot(1, 3, 1); imshow(just_red); title('red');
subplot(1, 3, 2); imshow(just_green); title('green');
subplot(1, 3, 3); imshow(just_blue); title('blue');



rgbImage = imread('peppers.png');
image = rgbImage;
% Extract color channels.
redChannel = rgbImage(:,:,1); 
greenChannel = rgbImage(:,:,2);
blueChannel = rgbImage(:,:,3);

% Define an edge enhancement filter.
edges = [0 -1 0; -1 4 -1; 0 -1 0];

% Apply convolution to each channel.
image(:,:,1)= conv2(redChannel, edges,"same");
image(:,:,2)= conv2(greenChannel, edges,"same");
image(:,:,3)= conv2(blueChannel, edges,"same");

% Display the original image and the edge-enhanced image.
figure;
subplot(1, 2, 1); imshow(rgbImage); title('Original Image');
subplot(1, 2, 2); imshow(image); title('edged image');


rgbImage = imread('peppers.png');
image = rgbImage;
% Extract color channels.
redChannel = rgbImage(:,:,1); 
greenChannel = rgbImage(:,:,2);
blueChannel = rgbImage(:,:,3);

% Define a sharpening filter.
sharpen = [0 -1 0;-1 5 -1;0 -1 0];

% Apply convolution to each channel.
image(:,:,1)= conv2(redChannel, sharpen,"same");
image(:,:,2)= conv2(greenChannel, sharpen,"same");
image(:,:,3)= conv2(blueChannel, sharpen,"same");

% Display the original image and the edge-enhanced image.
figure;
subplot(1, 2, 1); imshow(rgbImage); title('Original Image');
subplot(1, 2, 2); imshow(image); title('sharpened');



rgbImage = imread('peppers.png');
image = rgbImage;
% Extract color channels.
redChannel = rgbImage(:,:,1); % Convert to double for accurate calculations
greenChannel = rgbImage(:,:,2);
blueChannel = rgbImage(:,:,3);

% Define a plurring filter.
plurring = ones(5)/25; % create a matrix with size n with all ones then get the avg(/n^2)

% Apply convolution to each channel.
image(:,:,1)= conv2(redChannel, plurring,"same");
image(:,:,2)= conv2(greenChannel, plurring,"same");
image(:,:,3)= conv2(blueChannel, plurring,"same");


% Display the plurred image.
figure;
imshow(image,[]); title('plurred');


rgbImage = imread('peppers.png');

% Extract color channels.
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel

%creating horizontal blurring filter
motion = zeros(25);
motion (12,1:25)=1;
r= conv2(motion,redChannel);
g=conv2(motion,greenChannel);
b=conv2(motion,blueChannel);
%crop the image
rr=r(25:size(rgbImage, 1), 25:size(rgbImage, 2));
gg=g(25:size(rgbImage, 1), 25:size(rgbImage, 2));
bb=b(25:size(rgbImage, 1), 25:size(rgbImage, 2));
%concatenate
blurred=cat(3,rr,gg,bb);
bnormalised= mat2gray(blurred); %normalize the image
imshow(bnormalised);


% Read the image
rgbImage = imread('peppers.png');

% Extract color channels
redChannel = rgbImage(:,:,1);
greenChannel = rgbImage(:,:,2);
blueChannel = rgbImage(:,:,3);


% Create a motion matrix
motion = zeros(size(rgbImage,1),size(rgbImage,2));
motion(12,1:25) = 1;

% Perform FFT
ftmotion = fft2(motion);
ftimager = fft2(redChannel);
ftimageg = fft2(greenChannel);
ftimageb = fft2(blueChannel);

% Multiply the FFTs
outr = (ifft2(ftmotion .* ftimager));
outg = (ifft2(ftmotion .* ftimageg));
outb = (ifft2(ftmotion .* ftimageb));

%to crop the image
rr=outr(25:size(rgbImage, 1), 25:size(rgbImage, 2));
gg=outg(25:size(rgbImage, 1), 25:size(rgbImage, 2));
bb=outb(25:size(rgbImage, 1), 25:size(rgbImage, 2));

% Combine color channels
outtot = cat(3, rr, gg, bb);
moved =mat2gray(outtot);


% adding eps to avoid dividing by zero
outri = (ifft2(fft2(outr) ./(ftmotion+eps)));
outgi = (ifft2(fft2(outg) ./(ftmotion+eps)));
outbi = (ifft2(fft2(outb) ./(ftmotion+eps)));

% Combine color channels
outtoti = cat(3, outri, outgi, outbi);
recombined = mat2gray(outtoti);

% Display the original image and the result
figure;
subplot(1, 3, 1), imshow(rgbImage);  title('Original');
subplot(1, 3, 2), imshow(real(moved),[]);  title('motional blurred');
subplot(1, 3, 3), imshow (real(recombined),[]);  title('recombined');


