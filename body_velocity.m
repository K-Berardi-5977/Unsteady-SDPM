function Vbody = body_velocity(body, bodyState)
%BODY_VELOCITY
% Compute local rigid-body velocity at every body collocation point.
%
% INPUTS
%   body
%       Current panel geometry
%
%   bodyState
%       Current rigid-body state:
%
%           bodyState.x
%           bodyState.z
%               Current global position of body reference/pivot point
%
%           bodyState.u
%           bodyState.w
%               Translational velocity of the reference point
%
%           bodyState.omega
%               Angular velocity about the y-axis [rad/s]
%
%
% OUTPUT
%   Vbody
%       (N x 2) local velocity at each panel collocation point
%
%       Vbody(:,1) = x velocity
%       Vbody(:,2) = z velocity
%
%
% For rigid-body motion:
%
%       V_B = V_ref + Omega x r
%
% In 2-D:
%
%       Vx = u - omega*(z-z_ref)
%
%       Vz = w + omega*(x-x_ref)


%% ========================================================================
%  POSITION RELATIVE TO CURRENT ROTATION CENTER
% =========================================================================

rx = ...
    body.cp(:,1) - bodyState.x;

rz = ...
    body.cp(:,2) - bodyState.z;


%% ========================================================================
%  LOCAL RIGID-BODY VELOCITY
% =========================================================================

% Positive bodyState.omega = nose-up / clockwise pitch rate.

Vx = ...
    bodyState.u ...
    + bodyState.omega .* rz;

Vz = ...
    bodyState.w ...
    - bodyState.omega .* rx;


%% ========================================================================
%  PACKAGE
% =========================================================================

Vbody = [Vx, Vz];


end