CREATE OR REPLACE PROCEDURE editComment(IN user1 INTEGER.
                                        IN commentID INTEGER,
                                        IN newMessage VARCHAR(200))
    LANGUAGE SQL

    BEGIN

        DECLARE today AS DATE;
        SELECT today = CURRENT_DATE FROM sysibm.sysdummy1;

        UPDATE  Comment
        SET     message = newMessage,
                postDate = today
        WHERE   poster = user1
        AND     cID = commentID;
        
    END@