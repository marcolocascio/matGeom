function test_suite = test_createDodecahedron(varargin) %#ok<STOUT>
%TESTCREATEDodecahedron  One-line description here, please.
%
%   output = testCreateDodecahedron(input)
%
%   Example
%   testCreateDodecahedron
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

initTestSuite;


function testCreation %#ok<*DEFNU>

createDodecahedron();


function testVEFCreation

[v, e, f] = createDodecahedron();
assertTrue(~isempty(v));
assertTrue(~isempty(e));
assertTrue(~isempty(f));

[nv, ne, nf] = getMeshElementsNumber;
assertEqual([nv 3], size(v));
assertEqual([ne 2], size(e));
assertEqual(nf, length(f));


function testVFCreation

[v, f] = createDodecahedron();
assertTrue(~isempty(v));
assertTrue(~isempty(f));

[nv, ne, nf] = getMeshElementsNumber; %#ok<ASGLU>
assertEqual([nv 3], size(v));
assertEqual(nf, length(f));


function testMeshCreation

mesh = createDodecahedron();
assertTrue(isstruct(mesh));
assertTrue(isfield(mesh, 'vertices'));
assertTrue(isfield(mesh, 'edges'));
assertTrue(isfield(mesh, 'faces'));

[nv, ne, nf] = getMeshElementsNumber;
assertEqual([nv 3], size(mesh.vertices));
assertEqual([ne 2], size(mesh.edges));
assertEqual(nf, length(mesh.faces));


function testFacesOutwards

[v, e, f] = createDodecahedron(); %#ok<ASGLU>

centro = centroid(v);
fc  = faceCentroids(v, f);
fc2 = createVector(centro, fc);
n   = faceNormal(v, f);

assertEqual(size(n), size(fc2));

dp = dot(fc2, n, 2);

assertTrue(sum(dp <= 0) == 0);


function [nv, ne, nf] = getMeshElementsNumber

nv = 20;
ne = 30;
nf = 12;
