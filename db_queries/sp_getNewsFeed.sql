SELECT *
    FROM POST
    WHERE POST.privacy = "public" OR
        (POST.privacy = "friends" AND 
        EXISTS (SELECT * 
                    FROM BIDIRECTIONALFRIENDS
                WHERE USERA = "placeholder"))
ORDER BY POST.postDate DESC;