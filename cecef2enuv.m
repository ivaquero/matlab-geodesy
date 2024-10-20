% Coordinate Transformation:ECEF ==> ENU (Translation only)
%
% Syntax:
%   varargout = cecef2enuv(u, v, w, lat0, lon0, options)
%
% Input:
%   [u, v, w]                   Target's ECEF coordinates in [m, m, m]
%   [lat0, lon0]                Reference's geodetic coordinates in [deg, deg]
%   options.angleUnit           Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's ENU coordinates in [m, m, m]
% Attention:
%

function varargout = cecef2enuv(u, v, w, lat0, lon0, options)

    arguments
        u {mustBeReal}
        v {mustBeReal}
        w {mustBeReal}
        lat0 {mustBeReal}
        lon0 {mustBeReal}
        options.angleUnit (1, 1) string = 'degrees'
    end

    switch options.angleUnit
        case 'degrees'
            lat0 = deg2rad(lat0);
            lon0 = deg2rad(lon0);
        case 'radians'
        otherwise , error('Incorrect Input Angle Unit!');
    end

    cosPhi = cos(lat0);
    sinPhi = sin(lat0);
    cosLambda = cos(lon0);
    sinLambda = sin(lon0);

    t = cosLambda .* u + sinLambda .* v;
    uEast = -sinLambda .* u + cosLambda .* v;
    wUp = cosPhi .* t + sinPhi .* w;
    vNorth = -sinPhi .* t + cosPhi .* w;

    if nargout == 1
        varargout{1} = [uEast, vNorth, wUp];
    elseif nargout == 3
        varargout{1} = uEast;
        varargout{2} = vNorth;
        varargout{3} = wUp;
    else
        error('Invalid Number of Output Arguments');
    end

end
