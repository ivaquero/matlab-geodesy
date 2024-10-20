% Coordinate Transformation:Geodetic ==> ECEF
%
% Syntax:
%   varargout = cgeodetic2ecef(lat, lon, alt, options)
%
% Input:
%   [lat, lon, alt]         Target's geodetic coordinates in [deg, deg, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's ECEF coordinates in [m, m, m]
% Attention:
%

function varargout = cgeodetic2ecef(lat, lon, alt, options)

    arguments
        lat {mustBeReal}
        lon {mustBeReal}
        alt {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    switch options.angleUnit
        case 'degrees'
            lat = deg2rad(lat);
            lon = deg2rad(lon);
        case 'radians'
        otherwise , error('Incorrect Input Angle Unit!');
    end

    % 参考椭球属性
    N = get_normal_radius(lat, 'spheroid', options.spheroid);
    e2 = options.spheroid.Eccentricity2;

    % 变换矩阵
    x = (N + alt) .* cos(lat) .* cos(lon);
    y = (N + alt) .* cos(lat) .* sin(lon);
    z = (N * (1 - e2) + alt) .* sin(lat);

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
