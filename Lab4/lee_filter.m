function [f_hat] = lee_filter(g, noise_var, window)
    local_mean = colfilt(g, [window,window], 'sliding', @mean);
    local_var = colfilt(g, [window,window], 'sliding', @var);
    K = (local_var - noise_var)./local_var;
    f_hat = (K.*g)+((1-K).*local_mean);
end

