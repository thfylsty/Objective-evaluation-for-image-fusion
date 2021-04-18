function E = entropy(varargin)
%ENTROPY Entropy of intensity image.    
%   E = ENTROPY(I) returns E, a scalar value representing the entropy of an
%   intensity image.  Entropy is a statistical measure of randomness that can be
%   used to characterize the texture of the input image.  Entropy is defined as
%   -sum(p.*log2(p)) where p contains the histogram counts returned from IMHIST.
%  
%   ENTROPY uses 2 bins in IMHIST for logical arrays and 256 bins for
%   uint8, double or uint16 arrays.  
%
%   I can be multidimensional image. If I has more than two dimensions,
%   it is treated as a multidimensional intensity image and not as an RGB image. 
%  
%   Class Support
%   -------------  
%   I must be logical, uint8, uint16, or double, and must be real, nonempty,
%   and nonsparse. E is double.
%
%   Notes
%   -----    
%   ENTROPY converts any class other than logical to uint8 for the histogram
%   count calculation so that the pixel values are discrete and directly
%   correspond to a bin value.
%
%   Example
%   -------      
%       I = imread('circuit.tif');
%       E = entropy(I)
%  
%   See also IMHIST, ENTROPYFILT.

%   Copyright 1993-2007 The MathWorks, Inc.

%   Reference:
%      Gonzalez, R.C., R.E. Woods, S.L. Eddins, "Digital Image Processing
%      using MATLAB", Chapter 11. 
  
I = ParseInputs(varargin{:});

if ~islogical(I)
  I = im2uint8(I);
end

% calculate histogram counts
p = imhist(I(:));

% remove zero entries in p 
p(p==0) = [];

% normalize p so that sum(p) is one.
p = p ./ numel(I);

E = -sum(p.*log2(p));
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function I = ParseInputs(varargin)

narginchk(1,1);

validateattributes(varargin{1},{'uint8','uint16', 'double', 'logical'},...
              {'real', 'nonempty', 'nonsparse'},mfilename, 'I',1);

I = varargin{1};
