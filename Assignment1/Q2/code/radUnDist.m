function imOut = radUnDist(imIn, k1, k2, nSteps)
    % Your code here
    [m, n] = size(imIn);
    [x, y] = meshgrid(1:n, 1:m);

    cx = m/2;
    cy = n/2;
    
    x = x - cx;
    y = y - cy;
    x = x / cx;
    y = y / cy;
    
    x_orig = x;
    y_orig = y;
    
    for ii = 1:nSteps
        r = x.^2 + y.^2;
        m =  1 + k1 * r + k2 * r;
        x = x_orig ./ m;
        y = y_orig ./ m;
    end
    
    x = x*cx + cx;
    y = y*cy + cy;
    
    imOut = interp2(imIn, x, y, 'cubic');
end