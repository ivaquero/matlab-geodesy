% Coordinate Transformation:AER ==> ECEF
%
% Syntax:
%   varargout = caer2ecef(az, elev, rslant, options)
%
% Input:
%   [az, elev, rslant]      Target's spherical coordinates in [deg, deg, m]
%   [lat0, lon0, alt0]      Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's ECEF coordinates in [m, m, m]
% Attention:
%

function varargout = caer2ecef(az, elev, rslant, lat0, lon0, alt0, options)

    arguments
        az {mustBeReal}
        elev {mustBeReal}
        rslant {mustBeReal, mustBeNonnegative}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
    end

    [xeast, ynorth, zup] = caer2enu(az, elev, rslant, 'angleUnit', options.angleUnit);
    % ECEF coordinates: origin + offset
    ecef = cenu2ecef(xeast, ynorth, zup, lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);

    if nargout == 1
        varargout{1} = ecef;
    elseif nargout == 3
        varargout{1} = ecef(1);
        varargout{2} = ecef(2);
        varargout{3} = ecef(3);
    else
        error('Invalid Number of Output Arguments');
    end

end
