% Error Propagation: ECEF ==> AER
%
% Syntax:
%   E_aer = err_ecef2aer(x, y, z, P_ecef, lat0, lon0, alt0, options)
%
% Input:
%   [x, y, z]                   Target's ECEF coordinates in [m, m, m]
%   P_ecef                      State error covariance of reference's ECEF coordinates
%   [lat0, lon0, alt0]          Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid            Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnitOut        Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   E_aer                       Target's spherical coordinate error in [deg, deg, m]
% Attention:
%   When no units are specified, SI units are used.

function E_aer = err_ecef2aer(x, y, z, P_ecef, lat0, lon0, alt0, options)

    arguments
        x {mustBeReal}
        y {mustBeReal}
        z {mustBeReal}
        P_ecef (3, 3) double
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnitOut (1, 1) string = 'degrees'
    end

    [xEast, yNorth, zUp] = cecef2enu(x, y, z, lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);

    P_enu = cov_ecef2enu(P_ecef, lat0, lon0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);

    E_aer = err_enu2aer(xEast, yNorth, zUp, P_enu, options, 'angleUnit', options.angleUnitOut);

end
