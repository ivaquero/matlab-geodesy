% Coordinate Transformation: AER ==> ENU
%
% Syntax:
%   varargout = caer2enu(az, elev, rslant, options)
%
% Input:
%   [az, elev, rslant]      Target's spherical coordinates in [deg, deg, m]
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's ENU coordinates in [m, m, m]
% Attention:
%

function varargout = caer2enu(az, elev, rslant, options)

    arguments
        az {mustBeReal}
        elev {mustBeReal}
        rslant {mustBeReal, mustBeNonnegative}
        options.angleUnit (1, 1) string = 'degrees'
    end

    switch options.angleUnit
        case 'degrees'
            az = deg2rad(az);
            elev = deg2rad(elev);
        case 'radians'
        otherwise , error('Incorrect Input Angle Unit!');
    end

    zUp = rslant .* sin(elev);
    r = rslant .* cos(elev);
    xEast = r .* sin(az);
    yNorth = r .* cos(az);

    if nargout == 1
        varargout{1} = [xEast, yNorth, zUp];
    elseif nargout == 3
        varargout{1} = xEast;
        varargout{2} = yNorth;
        varargout{3} = zUp;
    else
        error('Invalid Number of Output Arguments');
    end

end
