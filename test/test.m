function test(res1, res2)
    res = res1 ./ res2 - 1;

    if res < 10e-6
        res = res .* 0;
    end

    disp(res)
end
