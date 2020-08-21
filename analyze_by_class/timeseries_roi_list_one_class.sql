WITH
    CI AS (
        SELECT id FROM classify_classlabel WHERE name = '%s'
    ),
 
    CA AS (
        SELECT DISTINCT ON (c.bin, c.roi) c.*, p.power
            FROM classify_classification c, auth_user_groups g, auth_group p
            WHERE c.user_id = g.user_id
            AND p.id = g.group_id
        	AND cast(timeseries_id as uuid)=(select id from classify_timeseries where url like '%%%s/')
            ORDER BY c.bin, c.roi, p.power DESC, c.verification_time DESC NULLS LAST, c.time DESC
    ),
    CF AS (
        SELECT * FROM CA,CI WHERE CA.classification_id = CI.id
    )

SELECT bin,roi FROM CF ORDER BY bin
