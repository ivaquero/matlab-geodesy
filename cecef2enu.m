% Coordinate Transformation:ECEF ==> ENU
%
% Syntax:
%   varargout = cecef2enu(x, y, z, lat0, lon0, alt0, options)
% Input:
%   [x, y, z]               Target's ECEF coordinates in [m, m, m]
%   [lat0, lon0, alt0]      Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's ENU coordinates in [m, m, m]
% Attention:
%

function varargout = cecef2enu(x, y, z, lat0, lon0, alt0, options)

    arguments
        x {mustBeReal}
        y {mustBeReal}
        z {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    % get reference's ECEF coordinates
    [x0, y0, z0] = cgeodetic2ecef(lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
    % consider offset
    dx = x - x0;
    dy = y - y0;
    dz = z - z0;

    enu = cecef2enuv(dx, dy, dz, lat0, lon0, 'angleUnit', options.angleUnit);

    if nargout == 1
        varargout{1} = enu;
    elseif nargout == 3
        varargout{1} = enu(1);
        varargout{2} = enu(2);
        varargout{3} = enu(3);
    else
        error('Invalid Number of Output Arguments');
    end

end
