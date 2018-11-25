/*PGR-GNU*****************************************************************
File: turnRestrictedPath.sql

Generated with Template by:
Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

Function's developer:
Copyright (c) 2017 Vidhan Jain
Mail: vidhanj1307@gmail.com

------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

********************************************************************PGR-GNU*/


-------------------------
-- pgr_turnRestrictedPath
-------------------------

CREATE OR REPLACE FUNCTION _pgr_turnRestrictedPath(
    TEXT,   -- edges_sql
    TEXT,   -- restrictions_sql
    BIGINT, -- start_vertex
    BIGINT, -- end_vertex
    INTEGER,-- K cycles

    directed BOOLEAN,
    heap_paths BOOLEAN,
    stop_on_first BOOLEAN,
    strict BOOLEAN,

    OUT seq INTEGER,
    OUT path_id INTEGER,
    OUT path_seq INTEGER,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)

RETURNS SETOF RECORD AS
'MODULE_PATHNAME', 'turnRestrictedPath'
LANGUAGE c IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION pgr_turnRestrictedPath(
    TEXT,   -- edges_sql (required)
    TEXT,   -- restrictions_sql (required)
    BIGINT, -- start_vertex (required)
    BIGINT, -- end_vertex (required)
    INTEGER,-- K cycles (required)

    directed BOOLEAN DEFAULT true,
    heap_paths BOOLEAN DEFAULT false,
    stop_on_first BOOLEAN DEFAULT true,
    strict BOOLEAN DEFAULT false,

    OUT seq INTEGER,
    OUT path_id INTEGER,
    OUT path_seq INTEGER,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)
RETURNS SETOF RECORD AS
$BODY$
    SELECT *
    FROM _pgr_turnRestrictedPath(_pgr_get_statement($1), _pgr_get_statement($2), $3, $4, $5, $6, $7, $8, $9);
$BODY$
LANGUAGE SQL VOLATILE STRICT
COST 100
ROWS 1000;

-- COMMENTS

COMMENT ON FUNCTION _pgr_turnRestrictedPath(TEXT, TEXT, BIGINT, BIGINT, INTEGER, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN)
IS 'pgRouting internal function';

COMMENT ON FUNCTION pgr_turnRestrictedPath(TEXT, TEXT, BIGINT, BIGINT, INTEGER, BOOLEAN, BOOLEAN, BOOLEAN, BOOLEAN)
IS 'EXPERIMENTAL pgr_turnRestrictedPath -- edges_sql(id,source,target,cost[,reverse_cost]), restrictions_sql(id,cost,path), from_vid, to_vid, K [,directed, heap_paths, stop_on_first, strict]';

