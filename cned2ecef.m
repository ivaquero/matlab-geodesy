% Coordinate Transformation:NED ==> ECEF
%
% Syntax:
%   varargout = cned2ecef(xNorth, yEast, zDown, lat0, lon0, alt0, options)
%
% Input:
%   [xNorth, yEast, zDown]      Target's NED coordinates in [m, m, m]
%   [lat0, lon0, alt0]          Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid            Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's ECEF coordinates in [m, m, m]
% Attention:
%

function varargout = cned2ecef(xNorth, yEast, zDown, lat0, lon0, alt0, options)

    arguments
        xNorth {mustBeReal}
        yEast {mustBeReal}
        zDown {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    ecef = cenu2ecef(yEast, xNorth, -zDown, lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);

    if nargout == 1
        varargout{1} = ecef;
    elseif nargout == 3
        varargout{1} = ecef(1);
        varargout{2} = ecef(2);
        varargout{3} = ecef(3);
    else
        error('Invalid Number of Output Arguments');
    end

end
