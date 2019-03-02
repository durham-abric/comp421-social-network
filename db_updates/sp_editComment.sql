CREATE OR REPLACE PROCEDURE editComment(IN user1 INTEGER,
                                        IN commentID INTEGER,
                                        IN newMessage VARCHAR(200))
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE today DATE;
        
        SELECT CURRENT_DATE 
        INTO today
        FROM sysibm.sysdummy1;

        UPDATE  Comment
        SET     message = newMessage,
                postDate = today
        WHERE   poster = user1
        AND     cID = commentID;
        
    END@