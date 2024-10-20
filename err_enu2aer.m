% Error Propagation: ENU ==> AER
%
% Syntax:
%   E_aer = err_enu2aer(xEast, yNorth, zUp, P_enu, options)
%
% Input:
%   [xEast, yNorth, zUp]        Target's ENU coordinates in [m, m, m]
%   P_enu                       State error covariance of target's ENU coordinates
%   options.angleUnitOut        Output's angle unit in 'degrees' (default) or 'radians'
% Output:
%   E_aer                       Target's spherical coordinate error in [deg, deg, m]
% Attention:
%   When no units are specified, SI units are used.

function E_aer = err_enu2aer(xEast, yNorth, zUp, P_enu, options)

    arguments
        xEast {mustBeReal}
        yNorth {mustBeReal}
        zUp {mustBeReal}
        P_enu (3, 3) double
        options.angleUnit (1, 1) string = 'degrees'
    end

    R = hypot(xEast, yNorth, zUp);
    R1 = hypot(xEast, yNorth);

    M_enu2aer = [ ...
                     zUp / R, xEast / R, xEast / R; ...
                     0, yNorth / (R1 ^ 2), -xEast / (R1 ^ 2); ...
                     R1 / (R ^ 2), -xEast * zUp / (R1 * R ^ 2), -yNorth * zUp / (R1 * R ^ 2) ...
                 ];

    P_aer = M_enu2aer * P_enu * M_enu2aer';
    E_aer = sqrt(diag(P_aer));

    switch options.angleUnitOut
        case 'degrees'
            E_aer(1) = rad2deg(E_aer(1));
            E_aer(2) = rad2deg(E_aer(2));
        case 'radians'
        otherwise , error('Incorrect Output Angle Unit!');
    end

end
