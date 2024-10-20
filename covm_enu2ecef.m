%% State error covariance transformation matrix: ECEF ==> ENU
% Syntax:
%   M_enu2ecef = covm_enu2ecef(lat, lon, options)
%
% Input:
%   [lat, lon]              Target's geodetic coordinates in [deg, deg, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   M_enu2ecef              Target's state error covariance matrix
% Attention:
%

function M_enu2ecef = covm_enu2ecef(lat, lon, options)

    arguments
        lat {mustBeReal}
        lon {mustBeReal}
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

    M_enu2ecef = [ ...
                      -sin(lat), -cos(lat) * sin(lon), cos(lat) * cos(lon); ...
                      cos(lat), -sin(lat) * sin(lon), sin(lat) * cos(lon); ...
                      0, cos(lon), sin(lon)];
end
