% Coordinate Transformation: ECEF ==> Geodetic
%
% Syntax:
%   varargout = cecef2geodetic(x, y, z, options)
%
% Input:
%   [x, y, z]               Target's ECEF coordinates in [m, m, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnitOut    Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's geodetic coordinates in [deg, deg, m]
% Attention:
%

function varargout = cecef2geodetic(x, y, z, options)

    arguments
        x {mustBeReal}
        y {mustBeReal}
        z {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnitOut (1, 1) string = 'degrees'
    end

    % reference ellipsoid properties
    a = options.spheroid.SemimajorAxis;
    b = options.spheroid.SemiminorAxis;
    e2 = options.spheroid.Eccentricity2; % square of the 1st eccentricity
    ae2 = a * e2;
    bep2 = b * e2 / (1 - e2); % b * square of the 2nd eccentricity

    % latitude, refer to Bowring method (1985)
    rho = hypot(x, y); % radial distance in spherical coordinates
    r = hypot(rho, z); % equatorial reference distance
    u = a * rho; % major axis of the projected ellipse
    v = b * z .* (1 + bep2 ./ r); % minor axis of projected ellipse
    cosbeta = sign(u) ./ hypot(1, v ./ u);
    sinbeta = sign(v) ./ hypot(1, u ./ v);

    % revised version of Bowring's formula, usually completed within 3 iterations
    % this method is borrowed from MATLAB
    count = 0;
    iterate = true;

    while iterate && count < 5
        cosprev = cosbeta;
        sinprev = sinbeta;
        u = rho - ae2 * cosbeta .^ 3;
        v = z + bep2 * sinbeta .^ 3;
        au = a * u;
        bv = b * v;
        cosbeta = sign(au) ./ hypot(1, bv ./ au);
        sinbeta = sign(bv) ./ hypot(1, au ./ bv);
        iterate = any(hypot(cosbeta - cosprev, sinbeta - sinprev) > eps(pi / 2), 'all');
        count = count + 1;
    end

    switch options.angleUnitOut
        case 'degrees'
            % longitude
            lon = atan2d(y, x);
            % latitude
            lat = atan2d(v, u);
            cosphi = cosd(lat);
            sinphi = sind(lat);
        case 'radians'
            % longitude
            lon = atan2(y, x);
            % latitude
            lat = atan2(v, u);
            cosphi = cos(lat);
            sinphi = sin(lat);
        otherwise , error('Incorrect Output Angle Unit!');
    end

    % altitude
    N = a ./ sqrt(1 - e2 * sinphi .^ 2);
    alt = rho .* cosphi + (z + e2 * N .* sinphi) .* sinphi - N;

    if nargout == 1
        varargout{1} = [lat, lon, alt];
    elseif nargout == 3
        varargout{1} = lat;
        varargout{2} = lon;
        varargout{3} = alt;
    else
        error('Invalid Number of Output Arguments');
    end

end
