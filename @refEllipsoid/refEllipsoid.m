% Reference ellipsoid
%
% Syntax:
%   ref = refEllipsoid(name, lengthUnit)
% Input:
%   name                    name of the reference ellipsoid system, 'wgs84' (default)
%   lengthUnit              length unit, 'm' (default)
% Output:
%   ref                     reference ellipsoid object
% Attention:
%

classdef refEllipsoid

    properties
        EPSG
        Name
        LengthUnit
        SemimajorAxis
        SemiminorAxis
        Flattening
        Eccentricity2
        SecondEccentricity2
        MeanRadius
        Volume
    end

    methods

        function ref = refEllipsoid(name, lengthUnit)

            arguments
                name (1, 1) string = "wgs84"
                lengthUnit (1, 1) string = "m"
            end

            mustBeMember(lengthUnit, ["m", "meters"])

            switch name
                case 'wgs84'
                    % WGS-84 Ellipsoid parameters.
                    ref.EPSG = 4326;
                    ref.Name = 'World Geodetic System 1984';
                    ref.LengthUnit = 'meter';
                    ref.SemimajorAxis = 6378137.0;
                    ref.SemiminorAxis = 6356752.31414036;
                    ref.Flattening = getFlattening(ref);
                    ref.Eccentricity2 = getEccentricity2(ref);
                    ref.SecondEccentricity2 = getSecondEccentricity2(ref);
                    ref.MeanRadius = getMeanRadius(ref);
                    ref.Volume = getVolume(ref);
                case 'grs80'
                    % GRS-80 Ellipsoid parameters
                    ref.EPSG = 7019;
                    ref.Name = 'Geodetic Reference System 1980';
                    ref.LengthUnit = 'meter';
                    ref.SemimajorAxis = 6378137.0;
                    ref.SemiminorAxis = 6356752.31424518;
                    ref.Flattening = getFlattening(ref);
                    ref.Eccentricity2 = getEccentricity2(ref);
                    ref.SecondEccentricity2 = getSecondEccentricity2(ref);
                    ref.MeanRadius = getMeanRadius(ref);
                    ref.Volume = getVolume(ref);
                case 'cgcs2000'
                    % CGCS2000 Ellipsoid parameters
                    ref.EPSG = 4490;
                    ref.Name = 'China Geodetic Coordinate System 2000';
                    ref.LengthUnit = 'meter';
                    ref.SemimajorAxis = 6378137.0;
                    ref.SemiminorAxis = 6356752.31414;
                    ref.Flattening = getFlattening(ref);
                    ref.Eccentricity2 = getEccentricity2(ref);
                    ref.SecondEccentricity2 = getSecondEccentricity2(ref);
                    ref.MeanRadius = getMeanRadius(ref);
                    ref.Volume = getVolume(ref);
                otherwise , error(name + " not yet implemented")
            end

        end

        function f = getFlattening(Ellipsoid)
            f = 1 - Ellipsoid.SemiminorAxis / Ellipsoid.SemimajorAxis;

            assert(f >= 0)
        end

        function e2 = getEccentricity2(Ellipsoid)
            f = Ellipsoid.Flattening;
            e2 = f * (2 - f);

            assert(e2 >= 0)
        end

        function ep2 = getSecondEccentricity2(Ellipsoid)
            f = Ellipsoid.Flattening;
            ep2 = f * (2 - f) / (1 - f) ^ 2;

            assert(ep2 >= 0)
        end

        function r = getMeanRadius(Ellipsoid)
            r = (2 * Ellipsoid.SemimajorAxis + Ellipsoid.SemiminorAxis) / 3;

            assert(r >= 0)
        end

        function v = getVolume(Ellipsoid)
            v = 4 * pi / 3 * Ellipsoid.SemimajorAxis ^ 2 * Ellipsoid.SemiminorAxis;

            assert(v >= 0)
        end

    end

end
