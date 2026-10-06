function Bp = transform_body(Bp0, bodyState)
%TRANSFORM_BODY
% Apply rigid-body translation and rotation to reference boundary points.
%
% INPUTS
%   Bp0
%       (N+1 x 2) reference/body-frame boundary points
%
%   bodyState
%       Current rigid-body state:
%
%           bodyState.x
%               Current global x-location of body reference point
%
%           bodyState.z
%               Current global z-location of body reference point
%
%           bodyState.theta
%               Current body rotation [rad]
%
%       Optional:
%
%           bodyState.xRef
%           bodyState.zRef
%
%       These define the reference-frame point about which the body
%       rotates. If omitted, [0,0] is used.
%
%
% OUTPUT
%   Bp
%       Current boundary-point coordinates in the global frame.


%% ========================================================================
%  REFERENCE / PIVOT POINT
% =========================================================================

% Default pivot is the origin of the reference geometry.

if isfield(bodyState, 'xRef')
    xRef = bodyState.xRef;
else
    xRef = 0;
end

if isfield(bodyState, 'zRef')
    zRef = bodyState.zRef;
else
    zRef = 0;
end

rRef = [xRef, zRef];


%% ========================================================================
%  ROTATION MATRIX
% =========================================================================

% Positive bodyState.theta = nose-up / increasing aerodynamic AoA.
% In the x-z plane this corresponds to a clockwise geometric rotation.

thetaGeom = -bodyState.theta;

R = [ ...
     cos(thetaGeom), -sin(thetaGeom); ...
     sin(thetaGeom),  cos(thetaGeom)];


%% ========================================================================
%  SHIFT REFERENCE GEOMETRY TO ROTATION CENTER
% =========================================================================

BpRelative = ...
    Bp0 - rRef;


%% ========================================================================
%  ROTATE
% =========================================================================

BpRotated = ...
    (R * BpRelative.').';


%% ========================================================================
%  TRANSLATE INTO GLOBAL FRAME
% =========================================================================

% bodyState.x and bodyState.z are the GLOBAL coordinates of the pivot /
% body reference point.

Bp = ...
    BpRotated ...
    + [bodyState.x, bodyState.z];


end