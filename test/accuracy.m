% CLEAN WORKSPACE
clear; close all; clc;

% LOAD TOOLBOX
path(path, strcat(pwd, '/..'));

% REFERENCE POINT COORDINATES
lat0 = 31.67749919;
lon0 = 116.75590625;
alt0 = 72.4121;

% TARGET POINT COORDINATES
latz = 31.635400994;
lonz = 116.701204066;
altz = 464.799;

% MATLAB Mapping toolbox
wgs84 = wgs84Ellipsoid('meter');
[x0, y0, z0] = geodetic2ecef(wgs84, latz, lonz, altz);
[e0, n0, u0] = geodetic2enu(latz, lonz, altz, lat0, lon0, alt0, wgs84, 'degrees');
[az0, el0, rs0] = geodetic2aer(latz, lonz, altz, lat0, lon0, alt0, wgs84, 'degrees');
[lat00, lon00, alt00] = ecef2geodetic(wgs84, x0, y0, z0);
[lat01, lon01, alt01] = enu2geodetic(e0, n0, u0, lat0, lon0, alt0, wgs84, 'degrees');
[lat02, lon02, alt02] = aer2geodetic(az0, el0, rs0, lat0, lon0, alt0, wgs84, 'degrees');
[e01, n01, u01] = ecef2enu(x0, y0, z0, lat0, lon0, alt0, wgs84, 'degrees');
[e02, n02, u02] = aer2enu(az0, el0, rs0, 'degrees');
[x01, y01, z01] = enu2ecef(e0, n0, u0, lat0, lon0, alt0, wgs84, 'degrees');
[x02, y02, z02] = aer2ecef(az0, el0, rs0, lat0, lon0, alt0, wgs84, 'degrees');
[az01, el01, rs01] = enu2aer(e0, n0, u0, 'degrees');
[az02, el02, rs02] = ecef2aer(x0, y0, z0, lat0, lon0, alt0, wgs84, 'degrees');

% geodesy toolbox
ecef = cgeodetic2ecef(latz, lonz, altz);
enu = cgeodetic2enu(latz, lonz, altz, lat0, lon0, alt0);
aer = cgeodetic2aer(latz, lonz, altz, lat0, lon0, alt0);
lla = cecef2geodetic(x0, y0, z0);
lla1 = cenu2geodetic(e0, n0, u0, lat0, lon0, alt0);
lla2 = caer2geodetic(az0, el0, rs0, lat0, lon0, alt0);
enu1 = cecef2enu(x0, y0, z0, lat0, lon0, alt0);
enu2 = caer2enu(az0, el0, rs0);
ecef1 = cenu2ecef(e0, n0, u0, lat0, lon0, alt0);
ecef2 = caer2ecef(az0, el0, rs0, lat0, lon0, alt0);
aer1 = cenu2aer(e0, n0, u0);
aer2 = cecef2aer(x0, y0, z0, lat0, lon0, alt0);

% test1 geodetic -> ecef: precision > 99%
disp('geodetic2ecef(), error rates are:')
test([x0, y0, z0], ecef);

% test2: enu -> ecef: precision > 99%
disp('enu2ecef(), error rates are:')
test([x01, y01, z01], ecef1);

% test3:aer -> ecef:precision > 99%
disp('aer2ecef(), error rates are:')
test([x02, y02, z02], ecef2);

% test4 ecef -> geodetic: precision > 99%
disp('ecef2geodetic(), error rates are:')
test([lat00, lon00, alt00], lla);

% test5: enu -> geodetic: precision > 99%
disp('enu2geodetic(), error rates are:')
test([lat01, lon01, alt01], lla1);

% test6: aer -> geodetic: precision > 99%
disp('aer2geodetic(), error rates are:')
test([lat02, lon02, alt02], lla2);

% test7: geodetic -> enu: precision > 99%
disp('geodetic2enu(), error rates are:')
test([e0, n0, u0], enu);

% test8: ecef -> enu: precision > 99%
disp('ecef2enu(), error rates are:')
test([e01, n01, u01], enu1);

% test9: aer -> enu: precision > 99%
disp('aer2enu(), error rates are:')
test([e02, n02, u02], enu2);

% test10: geodetic -> aer: precision > 99%
disp('geodetic2aer(), error rates are:')
test_angle([az0, el0, rs0], aer);

% test11: enu -> aer: precision > 99%
disp('enu2aer(), error rates are:')
test_angle([az01, el01, rs01], aer1);

% test12:ecef -> aer:precision > 99 %
disp('ecef2aer(), error rates are:')
test_angle([az02, el02, rs02], aer2);
