function rot_matrix = angles2rot(angles_list)
    %% Your code here
    % angles_list: [theta1, theta2, theta3] about the x,y and z axes,
    % respectively.
    numPoints = size(angles_list,1);
    rot_matrix = zeros(numPoints,3,3);
    for i = 1:numPoints
        rotX = [1 0 0; 0 cosd(angles_list(i,1)) -sind(angles_list(i,1)); 0 sind(angles_list(i,1)) cosd(angles_list(i,1))];
        rotY = [cosd(angles_list(i,2)) 0 sind(angles_list(i,2)); 0 1 0; -sind(angles_list(i,2)) 0 cosd(angles_list(i,2))];
        rotZ = [cosd(angles_list(i,3)) -sind(angles_list(i,3)) 0; sind(angles_list(i,3)) cosd(angles_list(i,3)) 0; 0 0 1];
        rot_matrix(i,:,:) = rotX*rotY*rotZ;
    end
end




