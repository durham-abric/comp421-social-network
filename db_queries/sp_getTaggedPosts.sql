SELECT *
    FROM POST
    WHERE EXISTS(SELECT *
                    FROM CONTAINSTAG
                WHERE CONTAINSTAG.post - POST.pid AND
                CONTAINSTAG.tag = "placeholder") AND
    (POST.privacy = "public" OR
        (POST.privacy = "friends" AND 
        EXISTS (SELECT * 
                    FROM BIDIRECTIONALFRIENDS
                WHERE USERA = "placeholder")))
ORDER BY POST.postDate DESC;