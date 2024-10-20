% Coordinate Transformation:ENU ==> Geodetic
%
% Syntax:
%   varargout = cenu2geodetic(xEast, yNorth, zUp, lat0, lon0, alt0, options)
%
% Input:
%   [xEast, yNorth, zUp]        Target's ENU coordinates in [m, m, m]
%   [lat0, lon0, alt0]          Reference's geodetic coordinates in [deg, deg, m]
%   options.spheroid            Reference ellipsoid model: 'wgs84' (default) or 'grs80'
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
%   options.angleUnitOut        Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's geodetic coordinates in [deg, deg, m]
% Attention:
%

function varargout = cenu2geodetic(xEast, yNorth, zUp, lat0, lon0, alt0, options)

    arguments
        xEast {mustBeReal}
        yNorth {mustBeReal}
        zUp {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        alt0 {mustBeReal}
        options.spheroid (1, 1) refEllipsoid = refEllipsoid('wgs84', 'm')
        options.angleUnit (1, 1) string = 'degrees'
        options.angleUnitOut (1, 1) string = 'degrees'
    end

    [x, y, z] = cenu2ecef(xEast, yNorth, zUp, lat0, lon0, alt0, 'spheroid', options.spheroid, 'angleUnit', options.angleUnit);
    geodetic = cecef2geodetic(x, y, z, 'spheroid', options.spheroid, 'angleUnitOut', options.angleUnitOut);

    if nargout == 1
        varargout{1} = geodetic;
    elseif nargout == 3
        varargout{1} = geodetic(1);
        varargout{2} = geodetic(2);
        varargout{3} = geodetic(3);
    else
        error('Invalid Number of Output Arguments');
    end

end
