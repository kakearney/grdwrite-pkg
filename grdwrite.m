function grdwrite(x, y, z, filename)
%GRDWRITE Creates a .grd (GMT) file from xyz values
%
% grdwrite(x, y, z, filename)
%
% Creates a .grd file from gridded x, y, and z data.  This program is an
% attempt to mimic the functionality of grdwrite.c, which I cannot get to
% compile properly on Windows with Matlab 7.0.1.  Rather than writing
% directly to a binary grd file, this program uses GMT's xyz2grd
% (Environment variables must be permanantly set, since using gmtenv.bat
% hides these settings from an outside system call).  Assumes that x and y
% hold full grid (evenly spaced and no nulls).
%
% Input variables:
%
%   x:          x values, any dimension
%
%   y:          y values, same dimensions as x
%
%   z:          z values, same dimensions as x
%
%   filename:   .grd file name

% Copywrite 2005 Kelly Kearney

xinc = mean(diff(unique(x(:))));
yinc = mean(diff(unique(y(:))));
[xmin, xmax] = minmax(x);
[ymin, ymax] = minmax(y);

fid = fopen('temp.xyz', 'w');
fprintf(fid, '%f %f %f\n', [x(:)'; y(:)'; z(:)']);
fclose(fid);

system(sprintf('xyz2grd temp.xyz -G%s -I%f/%f -R%f/%f/%f/%f', ...
                filename, xinc, yinc, xmin, xmax, ymin, ymax));
            
delete('temp.xyz');