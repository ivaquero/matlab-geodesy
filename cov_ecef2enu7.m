%% State error covariance transform: ECEF ==> ENU
%% 7-dimensional state (position + velocity + mass-drag ratio)
% Syntax:
%   varargout = cov_ecef2enu7(P_ecef, lat0, lon0, options)
%
% Input:
%   P_ecef                  State error covariance of target's ECEF coordinates
%   [lat0, lon0]            Reference's geodetic coordinates in [deg, deg]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               State error covariance of target's ENU coordinates
% Attention:
%

function varargout = cov_ecef2enu7(P_ecef, lat0, lon0, options)

    arguments
        P_ecef (7, 7) double
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    M_enu2ecef = covm_enu2ecef(lat0, lon0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
    M_ecef2enu = M_enu2ecef';

    P_enu(1:3, 1:3) = M_ecef2enu * P_ecef(1:3, 1:3) * M_ecef2enu';
    P_enu(1:3, 4:6) = M_ecef2enu * P_ecef(1:3, 4:6) * M_ecef2enu';
    P_enu(4:6, 1:3) = M_ecef2enu * P_ecef(4:6, 1:3) * M_ecef2enu';
    P_enu(4:6, 4:6) = M_ecef2enu * P_ecef(4:6, 4:6) * M_ecef2enu';

    P_enu(7, 1:3) = P_ecef(7, 1:3) * M_ecef2enu';
    P_enu(7, 4:6) = P_ecef(7, 4:6) * M_ecef2enu';
    P_enu(1:3, 7) = M_ecef2enu * P_ecef(1:3, 7);
    P_enu(4:6, 7) = M_ecef2enu * P_ecef(4:6, 7);
    P_enu(7, 7) = P_ecef(7, 7);

    if nargout == 1
        varargout{1} = P_enu;
    elseif nargout == 3
        varargout{1} = P_enu(1:3, 1:3);
        varargout{2} = P_enu(4:6, 4:6);
        varargout{3} = P_enu(7, 7);
    else
        error('Invalid Number of Output Arguments');
    end

end
