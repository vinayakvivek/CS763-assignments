function [result_pose, composed_rot] = transformPose(rotations, pose, kinematic_chain, root_location)
    % rotations: A 15 x 3 x 3 array for rotation matrices of 15 bones
    % pose: The base pose coordinates 16 x 3.
    % kinematic chain: A 15 x 2 array of joint ordering
    % root_positoin: the index of the root in pose vector.
    % Your code here 
    numJoints = size(pose,1);
    numBones = size(kinematic_chain,1);
    result_pose = ones(numJoints,4);
    result_pose(:,1:3) = pose;
    composed_rot = zeros(numJoints,4,4);
    
    for i  = 1:numBones
        translate = eye(4);
        translate(1:3,4) = -1*pose(kinematic_chain(i,2),1:3);
        composed_rot(i,4,4)=1;
        composed_rot(i,1:3,1:3) = rotations(i,:,:);
        translateBack = eye(4);
        translateBack(1:3,4) = pose(kinematic_chain(i,2),1:3);
        composed_rot(i,:,:) = translateBack*squeeze(composed_rot(i,:,:))*translate;
        
        for j = 1:i-1
            if (kinematic_chain(i,2) == kinematic_chain(j,1))
                composed_rot(i,:,:) = squeeze(composed_rot(j,:,:))*squeeze(composed_rot(i,:,:));
            end
        end
        
        result_pose(kinematic_chain(i,1),:) = squeeze(composed_rot(i,:,:))*result_pose(kinematic_chain(i,1),:)';
    end
    
    result_pose = result_pose(:,1:3);

end