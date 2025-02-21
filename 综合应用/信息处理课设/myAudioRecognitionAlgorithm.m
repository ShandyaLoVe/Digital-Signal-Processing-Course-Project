function result = myAudioRecognitionAlgorithm(audioData, sampleRate)
clc,close all;
    % 读取并处理各类鸟鸣参考音频
    birdFiles = {
        'sound/云雀.wav', 'sound/斑鸠.wav', 'sound/喜鹊.wav', ...
        'sound/大雁.wav', 'sound/布谷鸟.wav', 'sound/白头翁.wav', ...
        'sound/公鸡.wav', 'sound/海鸥.wav', 'sound/黄鹂.wav', 'sound/燕子.wav'};
    numBirds = length(birdFiles);
    referenceFFTs = cell(1, numBirds);

    % 加载参考音频并计算 FFT
    targetLength = 350208;
    for i = 1:numBirds
        [birdAudio, birdSampleRate] = audioread(birdFiles{i});
        birdAudio = birdAudio(1:targetLength); % 截取音频
        birdFFT = fft(birdAudio);             % 计算 FFT
        referenceFFTs{i} = birdFFT(1:targetLength/2); % 保存频谱数据
    end

    % 对输入音频计算 FFT
    audioData = audioData(1:min(length(audioData), targetLength));
    audioFFT = fft(audioData);
    audioFFT = audioFFT(1:targetLength/2);

    % 计算相关性，使用互相关函数进行匹配
    maxCorrelations = zeros(1, numBirds);
    for i = 1:numBirds
        correlation = xcorr(audioFFT, referenceFFTs{i});
        maxCorrelations(i) = max(abs(correlation));
    end

    % 获取相关性最大的鸟鸣类型
    [~, birdIndex] = max(maxCorrelations);

    % 返回结果
    birdNames = {'云雀', '斑鸠', '喜鹊', '大雁', '布谷鸟', ...
                 '白头翁', '公鸡', '海鸥', '黄鹂', '燕子'};
    if birdIndex > 0 && birdIndex <= numBirds
        result = birdNames{birdIndex};
    else
        result = '未知';
    end
end