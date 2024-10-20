% Coordinate Transformation:NED ==> AER
%
% Syntax:
%   varargout = cned2aer(xNorth, yEast, zDown, options)
%
% Input:
%   [xNorth, yEast, zDown]      Target's NED coordinates in [m, m, m]
%   options.angleUnitOut        Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   varargout                   Target's spherical coordinates in [deg, deg, m]
% Attention:
%

function varargout = cned2aer(xNorth, yEast, zDown, options)

    arguments
        xNorth {mustBeReal}
        yEast {mustBeReal}
        zDown {mustBeReal}
        options.angleUnit (1, 1) string = 'degrees'
    end

    aer = cenu2aer(yEast, xNorth, -zDown, 'angleUnitOut', options.angleUnitOut);

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
