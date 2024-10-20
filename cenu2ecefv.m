% Coordinate Transformation:ENU ==> ECEF (Translation only)
%
% Syntax:
%   varargout = cenu2ecefv(uEast, vNorth, wUp, lat0, lon0, options)
%
% Input:
%   [uEast, vNorth, wUp]    Target's ENU coordinates in [m, m, m]
%   [lat0, lon0]            Reference's geodetic coordinates in [deg, deg]
%   options.angleUnit       Input's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout               Target's ECEF coordinates in [m, m, m]
% Attention:
%

function varargout = cenu2ecefv(uEast, vNorth, wUp, lat0, lon0, options)

    arguments
        uEast {mustBeReal}
        vNorth {mustBeReal}
        wUp {mustBeReal}
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

    t = cosPhi .* wUp - sinPhi .* vNorth;
    w = sinPhi .* wUp + cosPhi .* vNorth;
    u = cosLambda .* t - sinLambda .* uEast;
    v = sinLambda .* t + cosLambda .* uEast;

    if nargout == 1
        varargout{1} = [u, v, w];
    elseif nargout == 3
        varargout{1} = u;
        varargout{2} = v;
        varargout{3} = w;
    else
        error('Invalid Number of Output Arguments');
    end

end
