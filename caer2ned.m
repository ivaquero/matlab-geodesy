% Coordinate Transformation:AER ==> NED
%
% Syntax:
%   varargout = caer2ned(az, elev, rslant, options)
%
% Input:
%   [az, elev, rslant]          Target's spherical coordinates in [deg, deg, m]
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's NED coordinates in [m, m, m]
% Attention:
%

function varargout = caer2ned(az, elev, rslant, options)

    arguments
        az {mustBeReal}
        elev {mustBeReal}
        rslant {mustBeReal, mustBeNonnegative}
        options.angleUnit (1, 1) string = 'degrees'
    end

    [yEast, xNorth, zUp] = caer2enu(az, elev, rslant, 'angleUnit', options.angleUnit);
    zDown = -zUp;

    if nargout == 1
        varargout{1} = [xNorth, yEast, zDown];
    elseif nargout == 3
        varargout{1} = xNorth;
        varargout{2} = yEast;
        varargout{3} = zDown;
    else
        error('Invalid Number of Output Arguments');
    end

end
