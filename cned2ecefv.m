% Coordinate Transformation:NED ==> ECEF (Translation only)
%
% Syntax:
%   varargout = cned2ecefv(uNorth, vEast, wDown, lat0, lon0, options)
%
% Input:
%   [uNorth, vEast, wDown]      Target's NED coordinates in [m, m, m]
%   [lat0, lon0]                Reference's geodetic coordinates in [deg, deg]
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's ECEF coordinates in [m, m, m]
% Attention:
%

function varargout = cned2ecefv(uNorth, vEast, wDown, lat0, lon0, options)

    arguments
        uNorth {mustBeReal}
        vEast {mustBeReal}
        wDown {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        options.angleUnit (1, 1) string = 'degrees'
    end

    uvw = cenu2ecefv(vEast, uNorth, -wDown, lat0, lon0, 'angleUnit', options.angleUnit);

    if nargout == 1
        varargout{1} = uvw;
    elseif nargout == 3
        varargout{1} = uvw(1);
        varargout{2} = uvw(2);
        varargout{3} = uvw(3);
    else
        error('Invalid Number of Output Arguments');
    end

end
