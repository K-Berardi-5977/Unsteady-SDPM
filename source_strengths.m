function sigma = source_strengths(body, flow, Vbody)
%SOURCE_STRENGTHS
% Prescribe constant source strength on each moving body panel.
%
% INPUTS
%   body
%       Current body panel geometry from panel_geometry()
%
%   flow
%       Flow structure containing:
%
%           flow.Uvec = [U_x, U_z]
%
%   Vbody
%       (N x 2) local body velocity at each panel collocation point:
%
%           Vbody(:,1) = body x-velocity
%           Vbody(:,2) = body z-velocity
%
%
% OUTPUT
%   sigma
%       (N x 1) prescribed body-panel source strengths
%
%
% MOVING-WALL BOUNDARY CONDITION
%
%       (u - V_body) dot n = 0
%
% Therefore the prescribed source strength is based on the
% relative incident velocity:
%
%       sigma_i = -(U_inf - V_body,i) dot n_i


%% ========================================================================
%  RELATIVE FLOW VELOCITY
% =========================================================================

% flow.Uvec is 1 x 2.
% Vbody is N x 2.
%
% MATLAB implicit expansion creates an N x 2 relative-velocity array.

Vrelative = ...
    flow.Uvec - Vbody;


%% ========================================================================
%  SOURCE STRENGTH
% =========================================================================

% Row-wise dot product with outward panel normal.

sigma = ...
    -sum(Vrelative .* body.normal, 2);


end