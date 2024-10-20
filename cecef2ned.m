% Coordinate Transformation:ECEF ==> NED
%
% Syntax:
%   varargout = cecef2ned(x, y, z, lat0, lon0, alt0, options)
% Input:
%   [x, y, z]                   Target's ECEF coordinates in [m, m, m]
%   [lat0, lon0, alt0]          Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid            Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's NED coordinates in [m, m, m]
% Attention:
%

function varargout = cecef2ned(x, y, z, lat0, lon0, alt0, options)

    arguments
        x {mustBeReal}
        y {mustBeReal}
        z {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
        options.rotateOnly (1, 1) string = 'false'
    end

    [yEast, xNorth, zUp] = cecef2enu(x, y, z, lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
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
