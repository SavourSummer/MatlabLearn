for k=1:16
    plot(fft(eye(k+16)))
    axis equal
    M(k) = getframe;
end