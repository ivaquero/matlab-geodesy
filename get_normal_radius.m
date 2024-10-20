% Calculation: normalized radius
%
% Syntax:
%   RN = get_normal_radius(Lat, options)
%
% Input:
%   Lat                     Target's geodetic coordinates in rad
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
% Output:
%   RN                       normalized radius in m
% Attention:
%

function RN = get_normal_radius(Lat, options)

    arguments
        Lat {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
    end

    a = options.spheroid.SemimajorAxis;
    b = options.spheroid.SemiminorAxis;

    RN = a ^ 2 ./ sqrt(a ^ 2 .* cos(Lat) .^ 2 + b ^ 2 .* sin(Lat) .^ 2);

end
