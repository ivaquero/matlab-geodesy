% Coordinate Transformation:ENU ==> ECEF
%
% Syntax:
%   varargout = cenu2ecef(xEast, yNorth, zUp, lat0, lon0, alt0, options)
%
% Input:
%   [xEast, yNorth, zUp]    Target's ENU coordinates in [m, m, m]
%   [lat0, lon0, alt0]      Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's ECEF coordinates in [m, m, m]
% Attention:
%

function varargout = cenu2ecef(xEast, yNorth, zUp, lat0, lon0, alt0, options)

    arguments
        xEast {mustBeReal}
        yNorth {mustBeReal}
        zUp {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    [x0, y0, z0] = cgeodetic2ecef(lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
    % convert to ECEF coordinate system and calculate the offset from ENU to ECEF
    [dx, dy, dz] = cenu2ecefv(xEast, yNorth, zUp, lat0, lon0, 'angleUnit', options.angleUnit);

    % reference + offset
    x = x0 + dx;
    y = y0 + dy;
    z = z0 + dz;

    if nargout == 1
        varargout{1} = [x, y, z];
    elseif nargout == 3
        varargout{1} = x;
        varargout{2} = y;
        varargout{3} = z;
    else
        error('Invalid Number of Output Arguments');
    end

end
