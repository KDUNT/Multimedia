r = audiorecorder(44100,16,1); % Record with fs = 44100,16-bit,1-channel 
disp('Start recording...')     
recordblocking(r,6); % Record to 'r' in 6s  
disp('End.');
play(r);
data = getaudiodata(r,'int16');  % Get data in 'r'
filename = 'orig_input.wav';
audiowrite(filename, data, 44100); %save as 'orig_input.wav'