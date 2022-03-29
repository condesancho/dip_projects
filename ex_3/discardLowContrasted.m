function keypointsHighC = discardLowContrasted(DoGs, keypoints, t, p)

    index = 1;
    
    keypointsHighC = [];

    for i = 1:size(keypoints,1)       
        
        dogs = DoGs{1,keypoints(i,1)};
        
        w = dogs(keypoints(i,3),keypoints(i,4),keypoints(i,2));
        
        if abs(w) > p*t
            keypointsHighC(index,:) = keypoints(i,:);
            index = index + 1;
        end        
        
    end
    
end