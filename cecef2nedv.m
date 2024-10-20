% Coordinate Transformation:ECEF ==> NED (Translation only)
%
% Syntax:
%   varargout = cecef2nedv(u, v, w, lat0, lon0, alt0, options)
% Input:
%   [u, v, w]                   Target's ECEF coordinates in [m, m, m]
%   [lat0, lon0]                Reference's geodetic coordinates in [deg, deg]
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's NED coordinates in [m, m, m]
% Attention:
%

function varargout = cecef2nedv(u, v, w, lat0, lon0, options)

    arguments
        u {mustBeReal}
        v {mustBeReal}
        w {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        options.angleUnit (1, 1) string = 'degrees'
    end

    [vEast, uNorth, wUp] = cecef2enuv(u, v, w, lat0, lon0, 'angleUnit', options.angleUnit);
    wDown = -wUp;

    if nargout == 1
        varargout{1} = [uNorth, vEast, wDown];
    elseif nargout == 3
        varargout{1} = uNorth;
        varargout{2} = vEast;
        varargout{3} = wDown;
    else
        error('Invalid Number of Output Arguments');
    end

end
