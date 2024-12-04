% Coordinate Transformation: Geodetic ==> AER
%
% Syntax:
%   varargout = cgeodetic2aer(lat, lon, alt, lat0, lon0, alt0, options)
%
% Input:
%   [lat, lon, alt]         Target's geodetic coordinates in [deg, deg, m]
%   [lat0, lon0, alt0]      Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid        Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
%   options.angleUnitOut    Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout      Target's spherical coordinates in [deg, deg, m]
% Attention:
%

function varargout = cgeodetic2aer(lat, lon, alt, lat0, lon0, alt0, options)

    arguments
        lat {mustBeReal}
        lon {mustBeReal}
        alt {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
        options.angleUnitOut (1, 1) string = 'degrees'
    end

    [xEast, yNorth, zUp] = cgeodetic2enu(lat, lon, alt, lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
    aer = cenu2aer(xEast, yNorth, zUp, 'angleUnitOut', options.angleUnitOut);

    if nargout == 1
        varargout{1} = aer;
    elseif nargout == 3
        varargout{1} = aer(1);
        varargout{2} = aer(2);
        varargout{3} = aer(3);
    else
        error('Invalid Number of Output Arguments');
    end

end
