%% State error covariance transform: ECEF ==> ENU
% Syntax:
%   P_enu = cov_ecef2enu(P_ecef, lat0, lon0, options)
%
% Input:
%   P_ecef                  State error covariance of target's ECEF coordinates
%   [lat0, lon0]            Reference's geodetic coordinates in [deg, deg]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   P_enu                   State error covariance of target's ENU coordinates
% Attention:
%

function P_enu = cov_ecef2enu(P_ecef, lat0, lon0, options)

    arguments
        P_ecef (3, 3) double
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    M_enu2ecef = covm_enu2ecef(lat0, lon0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
    M_ecef2enu = M_enu2ecef';

    P_enu = M_ecef2enu * P_ecef * M_ecef2enu';
end
