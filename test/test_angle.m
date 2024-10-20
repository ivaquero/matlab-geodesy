function test_angle(res1, res2)
    res = (res1 - res2) ./ [180, 180, res2(3)];

    for i = 1:3

        if res(i) < 10e-6
            res(i) = 0;
        end

    end

    disp(res)
end
