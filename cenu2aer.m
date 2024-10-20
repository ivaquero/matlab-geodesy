% Coordinate Transformation:ENU ==> AER
%
% Syntax:
%   varargout = cenu2aer(xEast, yNorth, zUp, options)
%
% Input:
%   [xEast, yNorth, zUp]    Target's ENU coordinates in [m, m, m]
%   options.angleUnitOut    Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's spherical coordinates in [deg, deg, m]
% Attention:
%

function varargout = cenu2aer(xEast, yNorth, zUp, options)

    arguments
        xEast {mustBeReal}
        yNorth {mustBeReal}
        zUp {mustBeReal}
        options.angleUnitOut (1, 1) string = 'degrees'
    end

    % 1 mm precision
    if abs(xEast) < 1e-3, xEast = 0.; end
    if abs(yNorth) < 1e-3, yNorth = 0.; end
    if abs(zUp) < 1e-3, zUp = 0.; end

    r = hypot(xEast, yNorth);
    % slant range
    rslant = hypot(r, zUp);
    % elevation
    elev = atan2(zUp, r);
    % azimuth
    az = mod(atan2(xEast, yNorth), 2 * pi);

    switch options.angleUnitOut
        case 'degrees'
            az = rad2deg(az);
            elev = rad2deg(elev);
        case 'radians'
        otherwise , error('Incorrect Output Angle Unit!');
    end

    if nargout == 1
        varargout{1} = [az, elev, rslant];
    elseif nargout == 3
        varargout{1} = az;
        varargout{2} = elev;
        varargout{3} = rslant;
    else
        error('Invalid Number of Output Arguments');
    end

end
