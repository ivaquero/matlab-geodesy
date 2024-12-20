% State error covariance transform: ENU ==> ECEF
% 6-dimensional state (position + velocity)
% Syntax:
%   varargout = cov_enu2ecef6(P_enu, lat0, lon0, options)
%
% Input:
%   P_enu                   State error covariance of target's ENU coordinates
%   [lat0, lon0]            Reference's geodetic coordinates in [deg, deg]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               State error covariance of target's ECEF coordinates
% Attention:
%

function varargout = cov_enu2ecef6(P_enu, lat0, lon0, options)

    arguments
        P_enu (6, 6) double
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    M_enu2ecef = covm_enu2ecef(lat0, lon0, options);

    P_ecef(1:3, 1:3) = M_enu2ecef * P_enu(1:3, 1:3) * M_enu2ecef';
    P_ecef(1:3, 4:6) = M_enu2ecef * P_enu(1:3, 4:6) * M_enu2ecef';
    P_ecef(4:6, 1:3) = M_enu2ecef * P_enu(4:6, 1:3) * M_enu2ecef';
    P_ecef(4:6, 4:6) = M_enu2ecef * P_enu(4:6, 4:6) * M_enu2ecef';

    if nargout == 1
        varargout{1} = P_ecef;
    elseif nargout == 2
        varargout{1} = P_ecef(1:3, 1:3);
        varargout{2} = P_ecef(4:6, 4:6);
    else
        error('Invalid Number of Output Arguments');
    end

end
