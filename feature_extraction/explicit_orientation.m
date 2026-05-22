function theta = explicit_orientation(blob_image)
% Deterministic blob orientation in degrees for MATLAB/Python parity.

blob_image = logical(blob_image);
[h, w] = size(blob_image);

m00 = 0.0;
m10 = 0.0;
m01 = 0.0;

% Match Python ravel(order='C'): scan rows first, then columns.
for r = 1:h
    for c = 1:w
        if blob_image(r,c)
            fi = double(1.0);
        else
            fi = double(0.0);
        end
        x = double(c);
        y = double(r);
        m00 = double(m00 + double(fi));
        m10 = double(m10 + double(x * fi));
        m01 = double(m01 + double(y * fi));
    end
end

if m00 == 0
    theta = 0.0;
    return
end

xbar = double(m10 / m00);
ybar = double(m01 / m00);

mu20 = 0.0;
mu02 = 0.0;
mu11 = 0.0;
for r = 1:h
    for c = 1:w
        if blob_image(r,c)
            fi = double(1.0);
        else
            fi = double(0.0);
        end
        dx = double(double(c) - xbar);
        dy = double(double(r) - ybar);
        mu20 = double(mu20 + double(dx * dx * fi));
        mu02 = double(mu02 + double(dy * dy * fi));
        mu11 = double(mu11 + double(dx * dy * fi));
    end
end

theta = double(-0.5) * double(atan2d(double(2.0) * mu11, mu20 - mu02));
while theta > 90.0
    theta = double(theta - 180.0);
end
while theta <= -90.0
    theta = double(theta + 180.0);
end

end
