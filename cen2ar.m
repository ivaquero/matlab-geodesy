% Coordinate Transformation:EN ==> AR
%
% Syntax:
%   varargout = cen2ar(xEast, yNorth)
%
% Input:
%   [xEast, yNorth]         Target's ENU coordinates in [m, m]
%   options.angleUnitOut    Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's spherical coordinates in [m, deg]
% Attention:
%

function varargout = cen2ar(xEast, yNorth, options)

    arguments
        xEast {mustBeReal}
        yNorth {mustBeReal}
        options.angleUnit (1, 1) string = 'degrees'
    end

    % slant range
    rslant = sqrt(xEast ^ 2 + yNorth ^ 2 + zUp ^ 2);
    % azimuth, true north is the y-axis
    az = atan2d(xEast, yNorth);

    switch options.angleUnitOut
        case 'degrees'
            az = rad2deg(az);
        case 'radians'
        otherwise , error('Incorrect Output Angle Unit!');
    end

    if nargout == 1
        varargout{1} = [az, rslant];
    elseif nargout == 2
        varargout{1} = az;
        varargout{3} = rslant;
    else
        error('Invalid Number of Output Arguments');
    end

end
