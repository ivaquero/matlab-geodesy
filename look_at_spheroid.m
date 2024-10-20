% Calculation: intersection of sight line and ellipsoid
%
% Syntax:
%   [lat, lon, rslant] = look_at_spheroid(lat0, lon0, alt0, az, tilt, options)
%
% Input:
%   [lat0, lon0, alt0]      geodetic coordinates of the observation point in [deg, deg, m]
%   [az, tilt]              azimuth and inclination of the observation point in [deg, deg]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
%   options.angleUnitOut    Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   [lat, lon, rslant]      Coordinates of intersection of sight line and ellipsoid in [deg, deg, m]
% Attention:
%

function [lat, lon, rslant] = look_at_spheroid(lat0, lon0, alt0, az, tilt, options)

    arguments
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal, mustBeNonnegative}
        az {mustBeReal}
        tilt {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
        options.angleUnitOut (1, 1) string = 'degrees'
    end

    switch options.angleUnit
        case 'degrees'
            elev = tilt - 90;
        case 'radians'
            elev = tilt - pi / 2;
        otherwise , error('Incorrect Input Angle Unit!');
    end

    a = spheroid.SemimajorAxis;
    b = a;
    c = spheroid.SemiminorAxis;

    [e, n, u] = caer2enu(az, elev, 1., 'angleUnit', options.angleUnit); % fixed slope distance is 1 km
    [u, v, w] = cenu2ecefv(e, n, u, lat0, lon0, 'angleUnit', options.angleUnit);
    [x, y, z] = cgeodetic2ecef(lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);

    value = -a .^ 2 .* b .^ 2 .* w .* z - a .^ 2 .* c .^ 2 .* v .* y - b .^ 2 .* c .^ 2 .* u .* x;
    radical = a .^ 2 .* b .^ 2 .* w .^ 2 + a .^ 2 .* c .^ 2 .* v .^ 2 - a .^ 2 .* v .^ 2 .* z .^ 2 + 2 .* a .^ 2 .* v .* w .* y .* z - ...
        a .^ 2 .* w .^ 2 .* y .^ 2 + b .^ 2 .* c .^ 2 .* u .^ 2 - b .^ 2 .* u .^ 2 .* z .^ 2 + 2 .* b .^ 2 .* u .* w .* x .* z - ...
        b .^ 2 .* w .^ 2 .* x .^ 2 - c .^ 2 .* u .^ 2 .* y .^ 2 + 2 .* c .^ 2 .* u .* v .* x .* y - c .^ 2 .* v .^ 2 .* x .^ 2;

    magnitude = a .^ 2 .* b .^ 2 .* W .^ 2 + a .^ 2 .* c .^ 2 .* V .^ 2 + b .^ 2 .* c .^ 2 .* U .^ 2;

    % when radical < 0 or d < 0, return nan
    rslant = (value - a .* b .* c .* sqrt(radical)) ./ magnitude;
    rslant(radical < 0 | d < 0) = nan; % dividing Line

    x = x + rslant .* u;
    y = y + rslant .* v;
    z = z + rslant .* w;

    % altitude should be 0
    [lat, lon, ~] = cecef2geodetic(x, y, z, 'angleUnitOut', options.angleUnitOut);

end
