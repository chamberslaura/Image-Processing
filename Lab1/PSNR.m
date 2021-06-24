function PSNR_out = PSNR(f,g)
%Peak Signal to Noise Ratio (PSNR)
%   Outputs PSNR given a reference image f and a test image g
    [m n] = size(f);
    MAX_f = 255.0;
    error_fg = (double(f)-double(g)).^2;
    PSNR_out = 10*log10(1/mean2((f-g)*.2); 
end


