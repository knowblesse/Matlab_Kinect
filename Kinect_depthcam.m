%% Kinect_depthcam
% Using matlab native "Kinect for Windows Sensor Support Package", this
% script captures color image data with depth info and plots in 3d space.
% @Knowblesse 2019

%% Constants
numFrame = 1;

%% Get Device Info
hwInfo = imaqhwinfo('kinect');
hwInfo.DeviceInfo(1); %color
hwInfo.DeviceInfo(2); %depth

colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);

triggerconfig([colorVid, depthVid], 'manual'); % trigger capture mannually
colorVid.FramesPerTrigger = numFrame;
depthVid.FramesPerTrigger = numFrame;

%% Start capturing
start([colorVid,depthVid]);
trigger([colorVid,depthVid]);
[colorFrameData,colorTimeData,colorMetaData] = getdata(colorVid);
[depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
stop([colorVid depthVid]);

%% Integrate color image data with depth info
frameNum2Use = 1;
cdat = colorFrameData(:,:,:,frameNum2Use);
ddat = depthFrameData(:,:,:,frameNum2Use);

%% Plot Image in 3D space
figure(1);
clf;
cdat_resized = imresize(cdat,size(ddat));
warp(max(max(max(ddat)))-ddat,cdat);